::mods_registerMod("mod_direwolf", 1.8, "True Balance Mod Direwolf");
::mods_queue("mod_direwolf", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("onAfterInit" in a))
	{
		a = a[a.SuperName];
	}

	local onAfterInit = a.onAfterInit;
	a.onAfterInit = function ()
	{
		onAfterInit();

		if (this.m.Type == this.Const.EntityType.Direwolf)
		{
			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/racial/ghoul_racial"));
			}
		}
	};
});
::mods_hookNewObject("entity/tactical/enemies/direwolf_high", function ( a )
{
	a.getName = function()
	{
		if (!this.m.IsMiniboss)
		{
			return "Бешеный лютоволк";
		}
		else if (this.m.Skills.getSkillByID("effects.champion_type_2") != null)
		{
			return "Жуткий волк";
		}
		else if (this.m.Skills.getSkillByID("effects.champion_type_1") != null)
		{
			return "Альфа-лютоволк";
		}
	}

	a.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && !_skill.isRanged())
		{
			this.updateAchievement("Ulfhednar", 1, 1);
		}

		if(this.m.Skills.getSkillByID("effects.champion_type_2") != null)
		{
			if (_tile != null)
			{
				local flip = this.Math.rand(0, 100) < 50;
				local decal;
				this.m.IsCorpseFlipped = flip;
				local body = this.getSprite("body");
				local head = this.getSprite("head");
				decal = _tile.spawnDetail("bust_direvarg_02_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = body.Color;
				decal.Saturation = body.Saturation;
				decal.Scale = 0.95;

				if (_fatalityType != this.Const.FatalityType.Decapitated)
				{
					decal = _tile.spawnDetail("bust_direvarg_02_head_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = head.Color;
					decal.Saturation = head.Saturation;
					decal.Scale = 0.95;
				}
				else if (_fatalityType == this.Const.FatalityType.Decapitated)
				{
					local layers = [
						head.getBrush().Name + "_dead"
					];

					local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 0.0, 	"bust_direvarg_head_dead_body_bloodpool");
					decap[0].Color = head.Color;
					decap[0].Saturation = head.Saturation;
					decap[0].Scale = 0.95;
				}

				if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
				{
					decal = _tile.spawnDetail("bust_direwolf_01_body_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.95;
				}
				else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
				{
					decal = _tile.spawnDetail("bust_direwolf_01_body_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.95;
				}

				this.spawnTerrainDropdownEffect(_tile);
				this.spawnFlies(_tile);
				local corpse = clone this.Const.Corpse;
				corpse.CorpseName = "Жуткий волк";
				corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
				_tile.Properties.set("Corpse", corpse);
				this.Tactical.Entities.addCorpse(_tile);

				if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
				{
					local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

					for( local i = 0; i < n; i = ++i )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							if (this.Const.DLC.Unhold)
							{
								local r = this.Math.rand(1, 100);
							local loot;
	
								if (r <= 70)
								{
									loot = this.new("scripts/items/misc/werewolf_pelt_item");
								}
								else
								{
									loot = this.new("scripts/items/misc/adrenaline_gland_item");
								}

								loot.drop(_tile);
							}
							else
							{
								local loot = this.new("scripts/items/misc/werewolf_pelt_item");
								loot.drop(_tile);
							}
						}
						else if (this.Math.rand(1, 100) <= 33)
						{
							local loot = this.new("scripts/items/supplies/strange_meat_item");
							loot.drop(_tile);
						}

						if (this.isKindOf(this, "direwolf_high") && this.Math.rand(1, 100) <= 20)
						{
							local loot = this.new("scripts/items/loot/sabertooth_item");
							loot.drop(_tile);
						}
					}
				}
			}

			this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
		}
		else if (this.m.Skills.getSkillByID("effects.champion_type_1") != null)
		{
			if (_tile != null)
			{
				local flip = this.Math.rand(0, 100) < 50;
				local decal;
				this.m.IsCorpseFlipped = flip;
				local body = this.getSprite("body");
				local head = this.getSprite("head");
				decal = _tile.spawnDetail("bust_direvarg_01_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = body.Color;
				decal.Saturation = body.Saturation;
				decal.Scale = 0.95;

				if (_fatalityType != this.Const.FatalityType.Decapitated)
				{
					decal = _tile.spawnDetail("bust_direvarg_01_head_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = head.Color;
					decal.Saturation = head.Saturation;
					decal.Scale = 0.95;
				}
				else if (_fatalityType == this.Const.FatalityType.Decapitated)
				{
					local layers = [
						head.getBrush().Name + "_dead"
					];

					local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 0.0, 	"bust_direvarg_head_dead_body_bloodpool");
					decap[0].Color = head.Color;
					decap[0].Saturation = head.Saturation;
					decap[0].Scale = 0.95;
				}

				if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
				{
					decal = _tile.spawnDetail("bust_direwolf_01_body_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.95;
				}
				else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
				{
					decal = _tile.spawnDetail("bust_direwolf_01_body_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.95;
				}

				this.spawnTerrainDropdownEffect(_tile);
				this.spawnFlies(_tile);
				local corpse = clone this.Const.Corpse;
				corpse.CorpseName = "Альфа-лютоволк";
				corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
				_tile.Properties.set("Corpse", corpse);
				this.Tactical.Entities.addCorpse(_tile);

				if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
				{
					local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

					for( local i = 0; i < n; i = ++i )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							if (this.Const.DLC.Unhold)
							{
								local r = this.Math.rand(1, 100);
							local loot;
	
								if (r <= 70)
								{
									loot = this.new("scripts/items/misc/werewolf_pelt_item");
								}
								else
								{
									loot = this.new("scripts/items/misc/adrenaline_gland_item");
								}

								loot.drop(_tile);
							}
							else
							{
								local loot = this.new("scripts/items/misc/werewolf_pelt_item");
								loot.drop(_tile);
							}
						}
						else if (this.Math.rand(1, 100) <= 33)
						{
							local loot = this.new("scripts/items/supplies/strange_meat_item");
							loot.drop(_tile);
						}

						if (this.isKindOf(this, "direwolf_high") && this.Math.rand(1, 100) <= 20)
						{
							local loot = this.new("scripts/items/loot/sabertooth_item");
							loot.drop(_tile);
						}
					}
				}
			}
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
		
		}
		else
		{
		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			local head_frenzy = this.getSprite("head_frenzy");
			decal = _tile.spawnDetail("bust_direwolf_01_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail(head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.95;

				if (head_frenzy.HasBrush)
				{
					decal = _tile.spawnDetail(head_frenzy.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.95;
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					head.getBrush().Name + "_dead"
				];

				if (head_frenzy.HasBrush)
				{
					layers.push(head_frenzy.getBrush().Name + "_dead");
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 0.0, "bust_direwolf_head_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.95;

				if (head_frenzy.HasBrush)
				{
					decap[1].Scale = 0.95;
				}
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail("bust_direwolf_01_body_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail("bust_direwolf_01_body_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "Лютоволк";
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = ++i )
				{
					if (this.Math.rand(1, 100) <= 50)
					{
						if (this.Const.DLC.Unhold)
						{
							local r = this.Math.rand(1, 100);
							local loot;

							if (r <= 70)
							{
								loot = this.new("scripts/items/misc/werewolf_pelt_item");
							}
							else
							{
								loot = this.new("scripts/items/misc/adrenaline_gland_item");
							}

							loot.drop(_tile);
						}
						else
						{
							local loot = this.new("scripts/items/misc/werewolf_pelt_item");
							loot.drop(_tile);
						}
					}
					else if (this.Math.rand(1, 100) <= 33)
					{
						local loot = this.new("scripts/items/supplies/strange_meat_item");
						loot.drop(_tile);
					}

					if (this.isKindOf(this, "direwolf_high") && this.Math.rand(1, 100) <= 20)
					{
						local loot = this.new("scripts/items/loot/sabertooth_item");
						loot.drop(_tile);
					}
				}
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
		}
	}
});
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.m.Type == this.Const.EntityType.Direwolf)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_direwolf_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})
