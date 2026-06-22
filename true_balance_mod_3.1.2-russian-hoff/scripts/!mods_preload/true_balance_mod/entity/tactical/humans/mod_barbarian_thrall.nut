::mods_registerMod("mod_barbarian_thrall", 1.8, "True Balance Mod Barbarian Thrall");
::mods_queue("mod_barbarian_thrall", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/human", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.ClassName == "barbarian_thrall")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag) != null)
			{
				this.m.Items.removeFromBag(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag));
			}

			local r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/barbarians/antler_cleaver"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/barbarians/claw_club"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
			}

			if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 40)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
				}
				else if (r == 3)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/orc_javelin"));
				}
			}

			if (this.Math.rand(1, 100) <= 20)
			{
				this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
			}

			if (this.Math.rand(1, 100) <= 70)
			{
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/armor/barbarians/thick_furs_armor"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/armor/barbarians/animal_hide_armor"));
				}
			}
	
			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/barbarians/leather_headband"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/barbarians/bear_headpiece"));
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

		if (this.ClassName == "barbarian_thrall")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			}
		}
	};
});
})