::mods_registerMod("mod_undead_hideout_location", 1.8, "True Balance Mod undead_hideout_location");
::mods_queue("mod_undead_hideout_location", "mod_true_balance", function() {
::mods_hookExactClass("entity/world/locations/undead_hideout_location", function(o) 
{
	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(0, 100), _lootTable);
		this.dropArmorParts(this.Math.rand(0, 5), _lootTable);
		this.dropAmmo(this.Math.rand(0, 5), _lootTable);
		this.dropFood(this.Math.rand(1, 2), [
			"strange_meat_item",
			"strange_meat_item",
			"ground_grains_item",
			"dried_fruits_item"
		], _lootTable);
		this.dropTreasure(1, [
			"loot/signet_ring_item",
			"loot/signet_ring_item",
			"loot/silverware_item"
		], _lootTable);

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