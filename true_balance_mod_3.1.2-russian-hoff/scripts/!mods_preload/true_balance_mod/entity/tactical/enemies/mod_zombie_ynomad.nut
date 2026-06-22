::mods_registerMod("mod_zombie_ynomad", 1.8, "True Balance Mod Zombie Nomad");
::mods_queue("mod_zombie_ynomad", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/enemies/zombie_yeoman", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.ClassName == "zombie_nomad")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local weapons = [
				"weapons/oriental/saif",
				"weapons/scimitar",
				"weapons/oriental/nomad_mace",
				"weapons/boar_spear",
				"weapons/bludgeon",
				"weapons/butchers_cleaver",
				"weapons/oriental/light_southern_mace",
				"weapons/oriental/two_handed_saif",
				"weapons/two_handed_wooden_hammer",
				"weapons/woodcutters_axe"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 50)
			{
					local shields = [
					"shields/oriental/southern_light_shield"
				];
				local shield = this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]);

				if (this.Math.rand(1, 100) <= 66)
				{
					shield.setCondition(shield.getConditionMax() / 2 - 1);
				}

				this.m.Items.equip(shield);
			}

			local armor = [
				"armor/oriental/stitched_nomad_armor",
				"armor/oriental/plated_nomad_mail",
				"armor/oriental/leather_nomad_robe",
				"armor/oriental/nomad_robe",
				"armor/oriental/thick_nomad_robe"
			];
			local armor = this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]);

			if (this.Math.rand(1, 100) <= 66)
			{
				armor.setArmor(armor.getArmorMax() / 2 - 1);
			}

			this.m.Items.equip(armor);
			local helmet = [
				"helmets/oriental/nomad_leather_cap",
				"helmets/oriental/nomad_light_helmet",
				"helmets/oriental/nomad_reinforced_helmet",
				"helmets/oriental/leather_head_wrap",
				"helmets/oriental/nomad_head_wrap",
				"helmets/oriental/nomad_head_wrap"
			];
			local helmet = this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]);

			if (this.Math.rand(1, 100) <= 66)
			{
				helmet.setArmor(helmet.getArmorMax() / 2 - 1);
			}

			this.m.Items.equip(helmet);
		}		
	};
});
})