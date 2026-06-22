::mods_registerMod("mod_militia_veteran", 1.8, "True Balance Mod Militia Veteran");
::mods_queue("mod_militia_veteran", "mod_true_balance", function() {
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

		if (this.ClassName == "militia_veteran")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
				local b = this.m.BaseProperties;
				b.IsSpecializedInSwords = true;
				b.IsSpecializedInAxes = true;
				b.IsSpecializedInMaces = true;
				b.IsSpecializedInFlails = true;
				b.IsSpecializedInPolearms = true;
				b.IsSpecializedInThrowing = true;
				b.IsSpecializedInHammers = true;
				b.IsSpecializedInSpears = true;
				b.IsSpecializedInCleavers = true;
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

		if (this.ClassName == "militia_veteran")
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

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
			{
				local weapons;

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
				{
					weapons = [
						"weapons/hooked_blade",
						"weapons/bludgeon",
						"weapons/hand_axe",
						"weapons/militia_spear",
						"weapons/boar_spear",
						"weapons/warfork",
						"weapons/goedendag"
					];
				}
				else
				{
					weapons = [
						"weapons/hooked_blade",
						"weapons/bludgeon",
						"weapons/hand_axe",
						"weapons/militia_spear",
						"weapons/boar_spear",
						"weapons/spetum",
						"weapons/goedendag"
					];
				}	
				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.Math.rand(1, 100) <= 100)
			{
				this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
			}

			r = this.Math.rand(2, 4);

			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/leather_lamellar"));
			}

			if (this.Math.rand(1, 100) <= 100)
			{
				local r = this.Math.rand(1, 3);

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
					this.m.Items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
				}
			}
		}	
	}
});
})