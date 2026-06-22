::mods_registerMod("mod_orc_fortress_location", 1.8, "True Balance Mod Orc Fortress Location");
::mods_queue("mod_orc_fortress_location", "mod_true_balance", function() {
::mods_hookExactClass("entity/world/locations/orc_fortress_location", function(o) 
{
	o.onSpawned = function()
	{
		this.m.Name = "Крепость военачальника";
		this.location.onSpawned();

		for( local i = 0; i < 16; i = ++i )
		{
			this.Const.World.Common.addTroop(this, this.Const.World.Spawn.Troops.OrcYoung, false);
		}

		for( local i = 0; i < 8; i = ++i )
		{
			this.Const.World.Common.addTroop(this, this.Const.World.Spawn.Troops.OrcBerserker, false);
		}

		for( local i = 0; i < 15; i = ++i )
		{
			this.Const.World.Common.addTroop(this, this.Const.World.Spawn.Troops.OrcWarrior, false);
		}

		for( local i = 0; i < 3; i = ++i )
		{
			this.Const.World.Common.addTroop(this, this.Const.World.Spawn.Troops.OrcWarlord, false);
		}
		
		local OrcWarlord = {
		ID = this.Const.EntityType.OrcWarlord,
		Variant = 10,
		Strength = 45,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/orc_warlord",
		NameList = this.Const.Strings.OrcWarlordNames,
		TitleList = null
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100)
		{
			this.Const.World.Common.addTroop(this, {
				Type = OrcWarlord
			}, false, 100);
		}
	}
});
})
