::mods_registerMod("mod_witch_hut_location", 1.8, "True Balance Mod Witch Hut Location");
::mods_queue("mod_witch_hut_location", "mod_true_balance", function() {
::mods_hookExactClass("entity/world/locations/legendary/witch_hut_location", function(o) 
{
	o.onSpawned = function()
	{
		this.m.Name = "Хижина ведьмы";
		this.location.onSpawned();

		for( local i = 0; i < 4; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.Hexe
			}, false);
		}

		for( local i = 0; i < 2; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.DirewolfBodyguard
			}, false);
		}

		for( local i = 0; i < 3; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.SpiderBodyguard
			}, false);
		}

		for( local i = 0; i < 5; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.DirewolfHIGH
			}, false);
		}

		for( local i = 0; i < 1; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.UnholdBog
			}, false);
		}

		for( local i = 0; i < 1; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.Unhold
			}, false);
		}

		for( local i = 0; i < 2; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.Ghoul
			}, false);
		}

		for( local i = 0; i < 2; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.Serpent
			}, false);
		}

		for( local i = 0; i < 1; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.GhoulHIGH
			}, false);
		}

		for( local i = 0; i < 1; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.Lindwurm
			}, false);
		}
	}
});
})
