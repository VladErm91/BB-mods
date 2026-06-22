this.matriarh_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.matriarh";
		this.m.Name = "Яд";
		this.m.Description = "TODO";
		this.m.Icon = "";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/giant_spider_poison_01.wav",
			"sounds/enemies/dlc2/giant_spider_poison_02.wav"
		];
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTurnStart()
	{
		if (this.Tactical.Entities.isEnemyRetreating())
		{
			return;
		}

		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local tile;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = myTile.getNextTile(i);

				if (!nextTile.IsEmpty || this.Math.abs(nextTile.Level - myTile.Level) > 1)
				{
				}
				else
				{
					tile = nextTile;
					break;
				}
			}
		}

		if (tile != null)
		{
			local spawn = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/spider_eggs", tile.Coords);
			spawn.setFaction(actor.getFaction());
			spawn.m.XP = spawn.m.XP / 2;
			local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());

			foreach( a in allies )
			{
				if (a.getType() == this.Const.EntityType.Hexe)
				{
					spawn.getSkills().add(this.new("scripts/skills/effects/fake_charmed_effect"));
					break;
				}
			}
		}
	}

});

