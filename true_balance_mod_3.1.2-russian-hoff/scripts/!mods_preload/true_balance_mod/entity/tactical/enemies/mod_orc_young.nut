::mods_registerMod("mod_orc_young", 1.8, "True Balance Mod Orc Young");
::mods_queue("mod_orc_young", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.OrcYoung)
		{
		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		local r;
		local weapon;

		if (this.Math.rand(1, 100) <= 25)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/orc_javelin"));
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				local r = this.Math.rand(1, 2);

				if (r == 1)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_axe");
				}
				else if (r == 2)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_cleaver");
				}
			}
			else
			{
				local r = this.Math.rand(1, 2);

				if (r == 1)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_wooden_club");
				}
				else if (r == 2)
				{
					weapon = this.new("scripts/items/weapons/greenskins/orc_metal_club");
				}
			}
		}
		else
		{
			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				weapon = this.new("scripts/items/weapons/greenskins/goblin_falchion");
			}
			else if (r == 2)
			{
				weapon = this.new("scripts/items/weapons/hand_axe");
			}
			else if (r == 3)
			{
				weapon = this.new("scripts/items/weapons/morning_star");
			}
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(weapon);
		}
		else
		{
			this.m.Items.addToBag(weapon);
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_light_shield"));
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
		{
			r = this.Math.rand(1, 5);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_young_very_light_armor"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_young_light_armor"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_young_medium_armor"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_young_heavy_armor"));
			}
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		{
			r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_young_very_light_armor"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_young_light_armor"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_young_medium_armor"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_young_heavy_armor"));
			}
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
		{
			r = this.Math.rand(1, 4);

			if (r == 1)
			{
			this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_light_helmet"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_medium_helmet"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_heavy_helmet"));
			}
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		{
			r = this.Math.rand(1, 10);

			if (r == 1)
			{
			this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_light_helmet"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_medium_helmet"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_heavy_helmet"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_light_helmet"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_medium_helmet"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_heavy_helmet"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_light_helmet"));
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_medium_helmet"));
			}
			else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_young_heavy_helmet"));
			}
		}
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

		if (this.m.Type == this.Const.EntityType.OrcYoung)
		{
			local b = this.m.BaseProperties;
			this.m.Skills.add(this.new("scripts/skills/effects/ripostes_effect"));
			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				b.RangedSkill += 5;
			}
		}
	};
});
})