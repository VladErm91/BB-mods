::mods_registerMod("mod_undead_ruins_location", 1.8, "True Balance Mod undead_ruins_location");
::mods_queue("mod_undead_ruins_location", "mod_true_balance", function() {
::mods_hookExactClass("entity/world/locations/undead_ruins_location", function(o) 
{
	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		local treasure = [
			"loot/silver_bowl_item",
			"loot/gemstones_item",
			"loot/signet_ring_item",
			"loot/signet_ring_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item",
			"loot/golden_chalice_item"
		];

		if (this.Const.DLC.Unhold)
		{
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

		this.dropMoney(this.Math.rand(0, 200), _lootTable);
		this.dropTreasure(this.Math.rand(2, 3), treasure, _lootTable);

		if (this.World.Assets.getOrigin().getID() == "scenario.graverobbers")
		{
			local r = this.Math.rand(0, 100);

			if (r <= 25)
			{
				_lootTable.push(this.new("scripts/items/loot/signet_ring_item"));
			}
			else if (r <= 50)
			{
				_lootTable.push(this.new("scripts/items/loot/silver_bowl_item"));
			}
			else if (r <= 75)
			{
				_lootTable.push(this.new("scripts/items/loot/silverware_item"));
			}
			else if (r <= 100)
			{
				_lootTable.push(this.new("scripts/items/loot/ornate_tome_item"));
			}
		}
	}
});
})