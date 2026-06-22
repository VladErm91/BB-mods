::mods_registerMod("mod_undead_buried_castle_location", 1.8, "True Balance Mod Undead Buried Castle Location");
::mods_queue("mod_undead_buried_castle_location", "mod_true_balance", function() {
::mods_hookExactClass("entity/world/locations/undead_buried_castle_location", function(o) 
{
	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropTreasure(this.Math.rand(3, 4), [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/white_pearls_item",
			"loot/golden_chalice_item",
			"loot/gemstones_item",
			"loot/ancient_gold_coins_item",
			"loot/jeweled_crown_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item"
		], _lootTable);

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
::mods_hookExactClass("entity/world/locations/undead_buried_castle_location", function(o) 
{
	o.createDefenders <- function()
	{
		this.location.createDefenders()
		
		local Undead = {
		ID = this.Const.EntityType.SkeletonHeavy,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/skeleton_heavy_bodyguard"
		}
		
		if (this.World.getTime().Days >= 100)
		{
			this.Const.World.Common.addTroop(this, {
				Type = Undead
			}, false, 100);
		}
	}
});
})