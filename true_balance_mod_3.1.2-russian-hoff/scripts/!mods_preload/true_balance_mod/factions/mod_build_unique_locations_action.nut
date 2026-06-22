::mods_registerMod("mod_build_unique_locations_action", 1.8, "True Balance Mod Build Unique Locations Action");
::mods_queue("mod_build_unique_locations_action", "mod_true_balance", function() {	
::mods_hookExactClass("factions/actions/build_unique_locations_action", function(o)
{
	o.m.BuildGreenskinsFortress <- true;
	local updateBuildings = o.updateBuildings
	o.updateBuildings = function()
	{
		updateBuildings()
		if (::TrueBalance.Mod.ModSettings.getSetting("GreenCastle").getValue())
		{
			local locations = this.World.EntityManager.getLocations();
			foreach( v in locations )
			{
				if (v.getTypeID() == "location.mod_orc_fortress")
				{
					this.m.BuildGreenskinsFortress = false;
					break
				}
			}
		}
	}
	local onExecute = o.onExecute
	o.onExecute = function(_faction)
	{
		if (::TrueBalance.Mod.ModSettings.getSetting("GreenCastle").getValue())
		{
			if (this.m.BuildGreenskinsFortress)
			{
				local camp;
				local distanceToOthers = 15;
				local avoidTerrain = [
				this.Const.World.TerrainType.Mountains, 
				this.Const.World.TerrainType.Swamp,	
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.AutumnForest
				]
				local legendarySpawned = false;
				local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries * 100, avoidTerrain, 30, 1000, 1001, 15, 15);
				if (tile != null)
				{
					camp = this.World.spawnLocation("scripts/entity/world/locations/legendary/mod_orc_fortress_location", tile.Coords);
				}
				if (camp != null)
				{
					local orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs);
					local banner = this.getAppropriateBanner(camp, orcs.getSettlements(), 15, this.Const.OrcBanners);
					camp.onSpawned();
					camp.setBanner(banner);
					orcs.addSettlement(camp, false);
				}
			}
		}
		onExecute(_faction)
	}
});
})