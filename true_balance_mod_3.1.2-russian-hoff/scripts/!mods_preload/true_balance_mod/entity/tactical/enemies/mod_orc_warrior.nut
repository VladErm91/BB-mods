::mods_registerMod("mod_orc_warrior", 1.8, "True Balance Mod Orc Warrior");
::mods_queue("mod_orc_warrior", "mod_true_balance", function() {
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

		if (this.ClassName == "orc_warrior")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			
			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
			{
				local weapons = [
					"weapons/greenskins/orc_axe",
					"weapons/greenskins/orc_cleaver"
				];
				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_heavy_shield"));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
			{
				local armor = [
					"armor/greenskins/orc_warrior_light_armor",
					"armor/greenskins/orc_warrior_medium_armor",
					"armor/greenskins/orc_warrior_heavy_armor",
					"armor/greenskins/orc_warrior_heavy_armor"
				];
				this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
			{
				local helmet = [
					"helmets/greenskins/orc_warrior_light_helmet",
					"helmets/greenskins/orc_warrior_medium_helmet",
					"helmets/greenskins/orc_warrior_heavy_helmet"
				];
				this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
			}

			if (this.m.IsMiniboss)
			{
				local weapons = [
				"weapons/named/named_orc_cleaver",
				"weapons/named/named_orc_axe"
				];
				local shields = [
					"shields/named/named_orc_heavy_shield"
				];

				if (this.Math.rand(1, 100) <= 50)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
				}
				else
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
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

		if (this.m.Type == this.Const.EntityType.OrcWarrior)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_orc_warrior_agent");
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

		if (this.m.Type == this.Const.EntityType.OrcWarrior)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/handorcs"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_true_believer"));
			this.m.Skills.add(this.new("scripts/skills/effects/ripostes_effect"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			}
		}
	};
});
})