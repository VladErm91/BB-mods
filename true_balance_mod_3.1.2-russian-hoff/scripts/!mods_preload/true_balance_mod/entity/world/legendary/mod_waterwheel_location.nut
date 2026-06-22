::mods_registerMod("mod_waterwheel_location", 1.8, "True Balance Mod Waterwheel Location");
::mods_queue("mod_waterwheel_location", "mod_true_balance", function() {
::mods_hookExactClass("entity/world/locations/legendary/waterwheel_location", function(o) 
{
	o.onSpawned = function()
	{
		this.logInfo("Захукен! ААААААААААААААААААААААА")
		this.m.Name = "Водная мельница";
		this.location.onSpawned();
		this.Const.World.Common.addTroop(this, {
			Type = this.Const.World.Spawn.Troops.ZombieBoss
		}, false);

		for( local i = 0; i < 11; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.ZombieBetrayer
			}, false);
		}

		for( local i = 0; i < 2; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.Ghost
			}, false);
		}
	}
});
})
