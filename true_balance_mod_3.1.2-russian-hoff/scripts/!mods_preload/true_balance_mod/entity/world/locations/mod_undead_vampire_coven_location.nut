::mods_registerMod("mod_undead_vampire_coven_location", 1.8, "True Balance Mod undead_vampire_coven_location");
::mods_queue("mod_undead_vampire_coven_location", "mod_true_balance", function() {
::mods_hookExactClass("entity/world/locations/undead_vampire_coven_location", function(o) 
{
	o.onDropLootForPlayer = function( _lootTable )
	{
	this.logInfo("Захукен! ООООООООООООООООООООООО")
		this.location.onDropLootForPlayer(_lootTable);
		this.dropFood(this.Math.rand(1, 3), [
			"strange_meat_item",
			"wine_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(2, 4), [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item"
		], _lootTable);
		
		if (this.World.Assets.getOrigin().getID() == "scenario.graverobbers")
		{
		this.logInfo("Захукен! ЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕЕ")
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
