::mods_registerMod("mod_orc_berserker", 1.8, "True Balance Mod Orc Berserker");
::mods_queue("mod_orc_berserker", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.m.Type == this.Const.EntityType.OrcBerserker && !this.m.IsMiniboss)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_axe"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_cleaver"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_flail_2h"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_axe_2h"));
			}

			local r;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
			{
				r = this.Math.rand(1, 5);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_berserker_light_armor"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_berserker_medium_armor"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				r = this.Math.rand(1, 5);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_berserker_light_armor"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_berserker_medium_armor"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_berserker_light_armor"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_berserker_medium_armor"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_berserker_helmet"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_berserker_helmet"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_berserker_helmet"));
				}
			}	
		}
	};
});
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.m.Type == this.Const.EntityType.OrcBerserker)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_orc_berserker_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("onAfterInit" in a))
	{
		a = a[a.SuperName];
	}

	local onAfterInit = a.onAfterInit;
	a.onAfterInit = function ()
	{
		onAfterInit();

		if (this.m.Type == this.Const.EntityType.OrcBerserker)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/handorcs"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_bers_believer"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_tm"));
			this.m.Skills.add(this.new("scripts/skills/effects/ripostes_effect"));
			this.m.Skills.add(this.new("scripts/skills/effects/injuries_orc_berserk_effect"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			}
		}
	};
});
})