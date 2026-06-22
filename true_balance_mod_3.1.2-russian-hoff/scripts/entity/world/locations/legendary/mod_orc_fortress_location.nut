this.mod_orc_fortress_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "Могучая крепость, построенная из массивных бревен железного дерева и покрытая родовыми рисунками войны. Кровожадные крики орков, раздающиеся за стенами, слышны издалека.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.mod_orc_fortress";
		this.m.LocationType = this.Const.World.LocationType.Lair | this.Const.World.LocationType.Unique;
		this.m.CombatLocation.Template[0] = "tactical.orc_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsDespawningDefenders = false;
		this.m.IsAttackable = false;
		this.m.VisibilityMult = 1.0;
		this.m.OnEnter = "event.location.orcfortress_enter";
		this.m.OnDestroyed = "event.location.orcfortress_destroyed";
		this.m.Resources = 500;
	}

	function onSpawned()
	{
		this.m.Name = "Крепость орков";
		this.location.onSpawned();

		for( local i = 0; i < 20; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.OrcYoung
			}, false);
		}

		for( local i = 0; i < 12; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.OrcBerserker
			}, false);
		}

		for( local i = 0; i < 12; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.OrcWarrior
			}, false);
		}

		for( local i = 0; i < 2; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.Lindwurm
			}, false);
		}

		for( local i = 0; i < 1; i = ++i )
		{
			this.Const.World.Common.addTroop(this, {
				Type = this.Const.World.Spawn.Troops.YuuGod
			}, false);
		}
	}

	function onDiscovered()
	{
		this.location.onDiscovered();
		this.World.Flags.increment("LegendaryLocationsDiscovered", 1);

		if (this.World.Flags.get("LegendaryLocationsDiscovered") >= 10)
		{
			this.updateAchievement("FamedExplorer", 1, 1);
		}
	}

	function onBeforeCombatStarted()
	{
		this.location.onBeforeCombatStarted();
	}
	
	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(25, 50), _lootTable);
		this.dropMedicine(this.Math.rand(0, 6), _lootTable);
		this.dropFood(this.Math.rand(4, 8), [
			"strange_meat_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(3, 4), [
			"trade/furs_item",
			"trade/furs_item",
			"trade/uncut_gems_item",
			"trade/dies_item",
			"loot/white_pearls_item"
		], _lootTable);
		_lootTable.push(this.new("scripts/items/weapons/legendary/flame_greatsword"));
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_orc_camp_03");
	}

	function onDeserialize( _in )
	{
		this.location.onDeserialize(_in);
		this.m.IsAttackable = false;
	}

});

