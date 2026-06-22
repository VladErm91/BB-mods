::mods_registerMod("mod_orc_warlord", 1.8, "True Balance Mod Orc Warlord");
::mods_queue("mod_orc_warlord", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.OrcWarlord)
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
	
				if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
				{
					weapons.extend([
						"weapons/greenskins/orc_axe_2h",
						"weapons/greenskins/orc_axe_2h"
					]);
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
			{
				this.m.Items.equip(this.new("scripts/items/armor/greenskins/orc_warlord_armor"));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/greenskins/orc_warlord_helmet"));
			}
			
			if (this.m.IsMiniboss)
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					local weapons = [
						"weapons/named/named_orc_cleaver",
						"weapons/named/named_orc_axe"
					];
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
				}
				else
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					local shields = [
						"shields/named/named_orc_heavy_shield"
					];
					local weapons = [
						"weapons/greenskins/orc_axe",
						"weapons/greenskins/orc_cleaver"
					];
					this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
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

		if (this.m.Type == this.Const.EntityType.OrcWarlord)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/handorcs"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_false_believer"));
			this.m.Skills.add(this.new("scripts/skills/effects/ripostes_effect"));
		}
	};
});
})