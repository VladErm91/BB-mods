::mods_registerMod("mod_undead_mass_grave_location", 1.8, "True Balance Mod undead_mass_grave_location");
::mods_queue("mod_undead_mass_grave_location", "mod_true_balance", function() {
::mods_hookExactClass("entity/world/locations/undead_mass_grave_location", function(o) 
{
	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(200, 500), _lootTable);
		this.dropArmorParts(this.Math.rand(0, 40), _lootTable);
		this.dropAmmo(this.Math.rand(0, 20), _lootTable);
		local treasure = [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item"
		];

		if (this.Const.DLC.Unhold)
		{
			treasure.extend(treasure);
			treasure.extend(treasure);
			treasure.extend(treasure);
			treasure.extend(treasure);
			treasure.push("armor_upgrades/metal_plating_upgrade");
			treasure.push("armor_upgrades/metal_pauldrons_upgrade");
			treasure.push("armor_upgrades/mail_patch_upgrade");
			treasure.push("armor_upgrades/leather_shoulderguards_upgrade");
			treasure.push("armor_upgrades/leather_neckguard_upgrade");
			treasure.push("armor_upgrades/joint_cover_upgrade");
			treasure.push("armor_upgrades/heraldic_plates_upgrade");
			treasure.push("armor_upgrades/double_mail_upgrade");
		}

		this.dropTreasure(this.Math.rand(0, 1), treasure, _lootTable);
		
		if (this.World.Assets.getOrigin().getID() == "scenario.graverobbers")
		{
			local r = this.Math.rand(0, 100);

			if (r <= 33)
			{
				_lootTable.push(this.new("scripts/items/loot/ancient_gold_coins_item"));
			}
			else if (r <= 66)
			{
				_lootTable.push(this.new("scripts/items/loot/jeweled_crown_item"));
			}
			else if (r <= 100)
			{
				_lootTable.push(this.new("scripts/items/loot/golden_chalice_item"));
			}
		}
	}
});
})