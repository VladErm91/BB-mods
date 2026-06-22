::mods_registerMod("mod_militia_ranged", 1.8, "True Balance Mod Militia Ranged");
::mods_queue("mod_militia_ranged", "mod_true_balance", function() {
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

		if (this.ClassName == "militia_ranged")
		{
			this.m.Skills.add(this.new("scripts/skills/effects/backstabber_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			
			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_bow"));
			}
		}	
	};
});
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

		if (this.ClassName == "militia_ranged" || this.ClassName == "militia_guest_ranged")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag) != null)
			{
				this.m.Items.removeFromBag(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag));
			}
			
			local r;

			if (this.Math.rand(1, 100) <= 65)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/short_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
			else
			{	
				this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}

			r = this.Math.rand(3, 4);

			if (r == 3)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/hatchet"));
			}
			else if (r == 4)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/bludgeon"));
			}

			r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/sackcloth"));
			}

			if (this.Math.rand(1, 100) <= 50)
			{
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/hood"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
				}
			}
		}
	}
});
})