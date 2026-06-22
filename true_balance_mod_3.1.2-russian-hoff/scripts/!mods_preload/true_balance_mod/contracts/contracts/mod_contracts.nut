::mods_registerMod("mod_contracts", 1.8, "True Balance Mod Contracts");
::mods_queue("mod_contracts", "mod_true_balance", function() {
::mods_hookBaseClass("contracts/contract", function(o) 
{
	::mods_override (o[o.SuperName], "create", function()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.bountyhunters")
		{
			local r;
			if (this.World.getTime().Days < 5)
			{
				r = this.Math.rand(1, 30);
			}
			else if (this.World.getTime().Days < 10)
			{
				r = this.Math.rand(1, 80);
			}
			else
			{
				r = this.Math.rand(1, 100);
			}

			if (r <= 30)
			{
				this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
			}
			else if (r <= 80)
			{
				this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
			}
			else if (r <= 100)
			{
				this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
			}
			
			this.m.PaymentMult = this.Math.rand(90, 110) * 0.01;
			this.m.Flags = this.new("scripts/tools/tag_collection");
			this.m.TempFlags = this.new("scripts/tools/tag_collection");
			this.createStates();
			this.createScreens();
		}
		else
		{
			local r;
			if (this.World.getTime().Days < 5)
			{
				r = this.Math.rand(1, 30);
			}
			else if (this.World.getTime().Days < 10)
			{
				r = this.Math.rand(1, 75);
			}
			else
			{
				r = this.Math.rand(1, 100);
			}

			if (r <= 30)
			{
				this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
			}
			else if (r <= 80)
			{
				this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
			}
			else
			{
				this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
			}

			this.m.PaymentMult = this.Math.rand(90, 110) * 0.01;
			this.m.Flags = this.new("scripts/tools/tag_collection");
			this.m.TempFlags = this.new("scripts/tools/tag_collection");
			this.createStates();
			this.createScreens();
		}
	})
});
::mods_hookExactClass("contracts/contracts/drive_away_nomads_contract", function(o) 
{
	o.createStates = function()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Изгнать кочевников из стойбища " + this.Flags.get("DestinationName") + ", что к %direction% от города %origin%"
				];
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				this.Contract.m.Destination.clearTroops();
				this.Contract.m.Destination.setLastSpawnTimeToNow();

				if (this.Contract.getDifficultyMult() <= 1.15 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
				{
					this.Contract.m.Destination.getLoot().clear();
				}

				this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.NomadDefenders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setLootScaleBasedOnResources(110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
				this.Contract.m.Destination.setDiscovered(true);
				this.Contract.m.Destination.resetDefenderSpawnDay();
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				local r = this.Math.rand(1, 100);

				if (r <= 10)
				{
					if (this.Contract.getDifficultyMult() >= 0.95 && this.World.Assets.getBusinessReputation() > 500)
					{
						this.Flags.set("IsSandGolems", true);
					}
				}
				else if (r <= 25)
				{
					if (this.Contract.getDifficultyMult() >= 0.95 && this.World.Assets.getBusinessReputation() > 300)
					{
						this.Flags.set("IsTreasure", true);
						this.Contract.m.Destination.clearTroops();
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.NomadDefenders, 150 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
				}
				else if (r <= 35)
				{
					if (this.World.Assets.getBusinessReputation() > 1200)
					{
						this.Flags.set("IsAssassins", true);
					}
				}
				else if (r <= 45)
				{
					if (this.World.getTime().Days >= 3)
					{
						this.Flags.set("IsNecromancer", true);
						this.Contract.m.Destination.clearTroops();
						local zombies = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies);
						this.World.FactionManager.getFaction(this.Contract.m.Destination.getFaction()).removeSettlement(this.Contract.m.Destination);
						this.Contract.m.Destination.setFaction(zombies.getID());
						zombies.addSettlement(this.Contract.m.Destination.get(), false);
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.NecromancerSouthern, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
				}
				else if (r <= 50)
				{
					this.Flags.set("IsFriendlyNomads", true);
				}

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));

					if (this.Flags.get("IsNecromancer"))
					{
						this.Contract.m.Destination.m.IsShowingDefenders = false;
					}
				}
			}

			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					if (this.Flags.get("IsTreasure"))
					{
						this.Flags.set("IsTreasure", false);
						this.Contract.setScreen("Treasure2");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setState("Return");
					}
				}
			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				if (this.Flags.get("IsSandGolems"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("SandGolems");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.Music = this.Const.Music.OrientalBanditTracks;
						properties.EnemyBanners.push(this.Contract.m.Destination.getBanner());
						local e = this.Math.max(1, 70 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult() / this.Const.World.Spawn.Troops.SandGolem.Cost);

						for( local i = 0; i < e; i = ++i )
						{
							properties.Entities.push({
								ID = this.Const.EntityType.SandGolem,
								Variant = 0,
								Row = -1,
								Script = "scripts/entity/tactical/enemies/sand_golem",
								Faction = this.Const.Faction.Enemy
							});
						}

						this.World.Contracts.startScriptedCombat(properties, true, true, true);
					}
				}
				else if (this.Flags.get("IsTreasure") && !this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					this.Contract.setScreen("Treasure1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsNecromancer") && !this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					this.Contract.setScreen("Necromancer");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsAssassins"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("Assassins");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.Music = this.Const.Music.OrientalBanditTracks;
						properties.EnemyBanners.push(this.Contract.m.Destination.getBanner());
						local e = this.Math.max(1, 30 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult() / this.Const.World.Spawn.Troops.Assassin.Cost);

						for( local i = 0; i < e; i = ++i )
						{
							properties.Entities.push({
								ID = this.Const.EntityType.Assassin,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/humans/assassin",
								Faction = this.Contract.m.Destination.getFaction()
							});
						}

						this.World.Contracts.startScriptedCombat(properties, true, true, true);
					}
				}
				else
				{
					this.World.Contracts.showCombatDialog();
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Вернуться в " + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success1");
					this.World.Contracts.showActiveContract();
				}
			}

		});
	}
});
::mods_hookExactClass("contracts/contracts/return_item_contract", function(o) 
{
	o.createStates = function()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Идите по следу возле поселения %townname%",
					"Вернуть %item% в %townname%"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 15)
				{
					if (this.Contract.getDifficultyMult() >= 0.95)
					{
						this.Flags.set("IsNecromancer", true);
					}
				}
				else if (r <= 30)
				{
					this.Flags.set("IsCounterOffer", true);
					this.Flags.set("Bribe", this.Contract.beautifyNumber(this.Contract.m.Payment.getOnCompletion() * this.Math.rand(125, 250) * 0.01));
				}
				else
				{
					this.Flags.set("IsBandits", true);
				}

				this.Flags.set("StartDay", this.World.getTime().Days);
				local playerTile = this.World.State.getPlayer().getTile();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 10, [
					this.Const.World.TerrainType.Mountains
				]);
				local party;
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(tile, "Воры", false, this.Const.World.Spawn.BanditRaiders, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.setDescription("Группа воров и разбойников");
				party.setFootprintType(this.Const.World.FootprintsType.Brigands);
				party.setAttackableByAI(false);
				party.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				party.setFootprintSizeOverride(0.75);
				this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Brigands, 0.75);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_bandits_0" + this.Math.rand(1, 6));
				local c = party.getController();
				local wait = this.new("scripts/ai/world/orders/wait_order");
				wait.setTime(9000.0);
				c.addOrder(wait);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Идите по следу к %direction% от города %townname%",
					"Вернуть %item% в %townname%"
				];

				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull())
				{
					if (this.Flags.get("IsCounterOffer"))
					{
						this.Contract.setScreen("CounterOffer1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("BattleDone");
						this.World.Contracts.showActiveContract();
						this.Contract.setState("Return");
					}
				}
				else if (this.World.getTime().Days - this.Flags.get("StartDay") >= 3 && this.Contract.m.Target.isHiddenToPlayer())
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					if (this.Flags.get("IsNecromancer"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
						this.Contract.setScreen("Necromancer");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
						this.Contract.setScreen("Bandits");
						this.World.Contracts.showActiveContract();
					}
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Вернуть %item% в %townname%"
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success1");
					this.World.Contracts.showActiveContract();
				}
			}

		});
	}
});
::mods_hookExactClass("contracts/contracts/intercept_raiding_parties_contract", function(o) 
{
	o.createStates = function()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Перехватить отряды южных налётчиков около поселения %objective%",
					"Не позволить им разорить окрестности"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 10)
				{
					this.Flags.set("IsAssassins", true);
				}
				else if (r <= 50)
				{
					this.Flags.set("IsSlavers", true);
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					this.Flags.set("IsThankfulVillagers", true);
				}

				local cityStates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

				foreach( c in cityStates )
				{
					c.addPlayerRelation(-99.0, "Выбрал не ту сторону в войне");
				}

				this.Contract.m.Destination.setLastSpawnTimeToNow();
				local locations = [];

				foreach( a in this.Contract.m.Destination.getActiveAttachedLocations() )
				{
					if (a.isUsable() && a.isActive())
					{
						locations.push(a);
					}
				}

				local cityState = cityStates[this.Math.rand(0, cityStates.len() - 1)];

				for( local i = 0; i < 2; i = ++i )
				{
					local r = this.Math.rand(0, locations.len() - 1);
					this.Contract.m.Objectives.push(locations[r].getID());
				}

				local g = this.Contract.getDifficultyMult() > 1.1 ? 3 : 2;

				for( local i = 0; i < g; i = ++i )
				{
					local tile = this.Contract.getTileToSpawnLocation(this.World.getTileSquare(this.Contract.m.Destination.getTile().SquareCoords.X, this.Contract.m.Destination.getTile().SquareCoords.Y - 12), 0, 10);
					local party;

					if (i == 0 && this.Flags.get("IsAssassins"))
					{
						party = cityState.spawnEntity(tile, "Полк " + cityState.getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(80, 90) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.addUnitsToEntity(party, this.Const.World.Spawn.Assassins, this.Math.rand(30, 40) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						party.getFlags().set("IsAssassins", true);
					}
					else if (i == 0 && this.Flags.get("IsSlavers"))
					{
						party = cityState.spawnEntity(tile, "Работорговцы", true, this.Const.World.Spawn.Southern, this.Math.rand(70, 80) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.addUnitsToEntity(party, this.Const.World.Spawn.NorthernSlaves, 40 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.addUnitsToEntity(party, this.Const.World.Spawn.Manhunters, 40 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						party.getFlags().set("IsSlavers", true);
					}
					else
					{
						party = cityState.spawnEntity(tile, "Полк " + cityState.getNameOnly(), true, this.Const.World.Spawn.Southern, this.Math.rand(110, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + cityState.getBannerString());

						if (this.Math.rand(1, 100) <= 33)
						{
							this.Contract.addUnitsToEntity(party, this.Const.World.Spawn.NorthernSlaves, this.Math.rand(20, 30));
							this.Contract.addUnitsToEntity(party, this.Const.World.Spawn.Manhunters, 10);
						}
					}

					party.setDescription("Ополчение из солдат, верных своему городу.");
					party.setAttackableByAI(false);
					party.getLoot().Money = this.Math.rand(50, 200);
					party.getLoot().ArmorParts = this.Math.rand(0, 25);
					party.getLoot().Medicine = this.Math.rand(0, 3);
					party.getLoot().Ammo = this.Math.rand(0, 30);
					local r = this.Math.rand(1, 4);

					if (r <= 2)
					{
						party.addToInventory("supplies/rice_item");
					}
					else if (r == 3)
					{
						party.addToInventory("supplies/dates_item");
					}
					else if (r == 4)
					{
						party.addToInventory("supplies/dried_lamb_item");
					}

					local c = party.getController();
					c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
					c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
					local wait = this.new("scripts/ai/world/orders/wait_order");
					wait.setTime(80.0 + i * 12.0);
					c.addOrder(wait);

					for( local j = 0; j < 2; j = ++j )
					{
						local raid = this.new("scripts/ai/world/orders/raid_order");
						raid.setTargetTile(j == 0 ? locations[0].getTile() : locations[1].getTile());
						raid.setTime(60.0);
						c.addOrder(raid);
					}

					this.Contract.m.UnitsSpawned.push(party.getID());
				}

				this.Flags.set("ObjectivesAlive", 2);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
				}

				foreach( i, id in this.Contract.m.UnitsSpawned )
				{
					local p = this.World.getEntityByID(id);

					if (p != null && p.isAlive())
					{
						p.getSprite("selection").Visible = true;
						p.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
					}
				}
			}

			function update()
			{
				local alive = 0;

				foreach( i, id in this.Contract.m.Objectives )
				{
					local p = this.World.getEntityByID(id);

					if (p != null && p.isAlive())
					{
						if (p.isActive())
						{
							alive = ++alive;
						}
						else
						{
							this.Flags.set("LastLocationDestroyed", p.getRealName());
						}
					}
				}

				if (alive < this.Flags.get("ObjectivesAlive"))
				{
					this.Flags.set("ObjectivesAlive", alive);
					this.Contract.setScreen("LocationDestroyed");
					this.World.Contracts.showActiveContract();
				}
				else if (alive == 0 || this.Contract.m.UnitsSpawned.len() == 0)
				{
					if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() < 4.0 && alive > 0)
					{
						if (this.Flags.get("IsThankfulVillagers") && this.Contract.isPlayerNear(this.Contract.m.Destination, 500))
						{
							this.Contract.setScreen("ThankfulVillagers");
						}
						else
						{
							this.Contract.setScreen("PartiesDefeated");
						}
					}
					else
					{
						this.Contract.setScreen("Lost");
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					foreach( i, id in this.Contract.m.UnitsSpawned )
					{
						local p = this.World.getEntityByID(id);

						if (p == null || !p.isAlive())
						{
							this.Contract.m.UnitsSpawned.remove(i);
							break;
						}
					}
				}
			}

			function onDestinationAttacked( _dest, _isPlayerInitiated )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerInitiated;

				if (!this.Flags.get("IsEngagementDialogShown"))
				{
					this.Flags.set("IsEngagementDialogShown", true);

					if (_dest.getFlags().has("IsAssassins"))
					{
						this.Contract.setScreen("Assassins");
					}
					else if (_dest.getFlags().has("IsSlavers"))
					{
						this.Contract.setScreen("Slavers");
					}
					else
					{
						this.Contract.setScreen("InterceptParty");
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerInitiated, true, true);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Вернуться в " + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					local alive = 0;

					foreach( id in this.Contract.m.Objectives )
					{
						local p = this.World.getEntityByID(id);

						if (p != null && p.isAlive() && p.isActive())
						{
							alive = ++alive;
						}
					}

					if (alive == 0)
					{
						this.Contract.setScreen("Lost");
					}
					else if (alive == 1)
					{
						this.Contract.setScreen("Success1");
					}
					else
					{
						this.Contract.setScreen("Success2");
					}

					this.World.Contracts.showActiveContract();
				}
			}

		});
	}
});
::mods_hookExactClass("contracts/contracts/privateering_contract", function(o) 
{
	o.createStates = function()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Flags.set("StartDay", this.World.getTime().Days);
				this.Contract.m.BulletpointsObjectives = [
					"Отправиться в земли дома %feudfamily%",
					"Опустошить и сжечь поселки, заработав [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() * 20 * 0.01 + "[/color] за каждый",
					"Уничтожить любые караваны или патрули",
					"Вернуться через 5 дней"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local f = this.World.FactionManager.getFaction(this.Flags.get("FeudingHouseID"));
				f.addPlayerRelation(-99.0, "Выбрал не ту сторону в войне");
				this.Flags.set("StartDay", this.World.getTime().Days);
				local nonIsolatedSettlements = [];

				foreach( s in f.getSettlements() )
				{
					if (s.isIsolated() || !s.isDiscovered())
					{
						continue;
					}

					nonIsolatedSettlements.push(s);
					local a = s.getActiveAttachedLocations();

					if (a.len() == 0)
					{
						continue;
					}

					local obj = a[this.Math.rand(0, a.len() - 1)];
					this.Contract.m.Objectives.push(this.WeakTableRef(obj));
					obj.clearTroops();

					if (s.isMilitary())
					{
						if (obj.isMilitary())
						{
							this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Noble, this.Math.rand(90, 120) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}
						else
						{
							local r = this.Math.rand(1, 100);

							if (r <= 10)
							{
								this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Mercenaries, this.Math.rand(90, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							}
							else
							{
								this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Noble, this.Math.rand(70, 100) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
							}
						}
					}
					else if (obj.isMilitary())
					{
						this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Militia, this.Math.rand(100, 130) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else
					{
						local r = this.Math.rand(1, 100);

						if (r <= 15)
						{
							this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Mercenaries, this.Math.rand(80, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}
						else if (r <= 30)
						{
							obj.getFlags().set("HasNobleProtection", true);
							this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Noble, this.Math.rand(80, 100) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}
						else
						{
							this.Contract.addUnitsToEntity(obj, this.Const.World.Spawn.Militia, this.Math.rand(90, 130) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						}
					}

					if (this.Contract.m.Objectives.len() >= 3)
					{
						break;
					}
				}

				local origin = nonIsolatedSettlements[this.Math.rand(0, nonIsolatedSettlements.len() - 1)];
				local party = f.spawnEntity(origin.getTile(), origin.getName() + " Company", true, this.Const.World.Spawn.Noble, 190 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
				party.setDescription("Опытные воины на службе у местной знати.");
				this.Contract.m.UnitsSpawned.push(party.getID());
				party.getLoot().Money = this.Math.rand(50, 200);
				party.getLoot().ArmorParts = this.Math.rand(0, 25);
				party.getLoot().Medicine = this.Math.rand(0, 3);
				party.getLoot().Ammo = this.Math.rand(0, 30);
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					party.addToInventory("supplies/bread_item");
				}
				else if (r == 2)
				{
					party.addToInventory("supplies/roots_and_berries_item");
				}
				else if (r == 3)
				{
					party.addToInventory("supplies/dried_fruits_item");
				}
				else if (r == 4)
				{
					party.addToInventory("supplies/ground_grains_item");
				}

				local c = party.getController();
				local wait = this.new("scripts/ai/world/orders/wait_order");
				wait.setTime(9000.0);
				c.addOrder(wait);
				local r = this.Math.rand(1, 100);

				if (r <= 15)
				{
					local rival = this.World.FactionManager.getFaction(this.Flags.get("RivalHouseID"));

					if (!f.getFlags().get("Betrayed"))
					{
						this.Flags.set("IsChangingSides", true);
						local i = this.Math.rand(1, 18);
						local item;

						if (i == 1)
						{
							item = this.new("scripts/items/weapons/named/named_axe");
						}
						else if (i == 2)
						{
							item = this.new("scripts/items/weapons/named/named_billhook");
						}
						else if (i == 3)
						{
							item = this.new("scripts/items/weapons/named/named_cleaver");
						}
						else if (i == 4)
						{
							item = this.new("scripts/items/weapons/named/named_crossbow");
						}
						else if (i == 5)
						{
							item = this.new("scripts/items/weapons/named/named_dagger");
						}
						else if (i == 6)
						{
							item = this.new("scripts/items/weapons/named/named_flail");
						}
						else if (i == 7)
						{
							item = this.new("scripts/items/weapons/named/named_greataxe");
						}
						else if (i == 8)
						{
							item = this.new("scripts/items/weapons/named/named_greatsword");
						}
						else if (i == 9)
						{
							item = this.new("scripts/items/weapons/named/named_javelin");
						}
						else if (i == 10)
						{
							item = this.new("scripts/items/weapons/named/named_longaxe");
						}
						else if (i == 11)
						{
							item = this.new("scripts/items/weapons/named/named_mace");
						}
						else if (i == 12)
						{
							item = this.new("scripts/items/weapons/named/named_spear");
						}
						else if (i == 13)
						{
							item = this.new("scripts/items/weapons/named/named_sword");
						}
						else if (i == 14)
						{
							item = this.new("scripts/items/weapons/named/named_throwing_axe");
						}
						else if (i == 15)
						{
							item = this.new("scripts/items/weapons/named/named_two_handed_hammer");
						}
						else if (i == 16)
						{
							item = this.new("scripts/items/weapons/named/named_warbow");
						}
						else if (i == 17)
						{
							item = this.new("scripts/items/weapons/named/named_warbrand");
						}
						else if (i == 18)
						{
							item = this.new("scripts/items/weapons/named/named_warhammer");
						}

						item.onAddedToStash("");
						this.Contract.m.Item = item;
					}
				}

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [];

				foreach( obj in this.Contract.m.Objectives )
				{
					if (obj != null && !obj.isNull() && obj.isActive())
					{
						this.Contract.m.BulletpointsObjectives.push("Уничтожить " + obj.getName() + " возле " + obj.getSettlement().getName());
						obj.getSprite("selection").Visible = true;
						obj.setAttackable(true);
						obj.setOnCombatWithPlayerCallback(this.onCombatWithLocation.bindenv(this));
					}
				}

				this.Contract.m.BulletpointsObjectives.push("Уничтожить любые караваны или патрули дома %feudfamily%");
				this.Contract.m.BulletpointsObjectives.push("Вернуться в течение %days%");
				this.Contract.m.CurrentObjective = null;
			}

			function update()
			{
				if (this.Flags.get("LastUpdateDay") != this.World.getTime().Days)
				{
					if (this.World.getTime().Days - this.Flags.get("StartDay") >= 5)
					{
						this.Contract.setScreen("TimeIsUp");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Flags.set("LastUpdateDay", this.World.getTime().Days);
						this.start();
						this.World.State.getWorldScreen().updateContract(this.Contract);
					}
				}

				if (this.Contract.m.UnitsSpawned.len() != 0 && this.Time.getVirtualTimeF() - this.Contract.m.LastOrderUpdateTime > 2.0)
				{
					this.Contract.m.LastOrderUpdateTime = this.Time.getVirtualTimeF();
					local party = this.World.getEntityByID(this.Contract.m.UnitsSpawned[0]);
					local playerTile = this.World.State.getPlayer().getTile();

					if (party != null && party.getTile().getDistanceTo(playerTile) > 3)
					{
						local f = this.World.FactionManager.getFaction(this.Flags.get("FeudingHouseID"));
						local nearEnemySettlement = false;

						foreach( s in f.getSettlements() )
						{
							if (s.getTile().getDistanceTo(playerTile) <= 6)
							{
								nearEnemySettlement = true;
								break;
							}
						}

						if (nearEnemySettlement)
						{
							local c = party.getController();
							c.clearOrders();
							local move = this.new("scripts/ai/world/orders/move_order");
							move.setDestination(this.World.State.getPlayer().getTile());
							c.addOrder(move);
							local wait = this.new("scripts/ai/world/orders/wait_order");
							wait.setTime(this.World.getTime().SecondsPerDay * 1);
							c.addOrder(wait);

							if (party.getTile().getDistanceTo(playerTile) <= 8 && this.Time.getVirtualTimeF() - this.Flags.get("SearchPartyLastNotificationTime") >= 300.0)
							{
								this.Flags.set("SearchPartyLastNotificationTime", this.Time.getVirtualTimeF());
								this.Contract.setScreen("SearchParty");
								this.World.Contracts.showActiveContract();
							}
						}
					}
				}

				if (this.Flags.get("IsChangingSides") && this.Contract.getDistanceToNearestSettlement() >= 5 && this.World.State.getPlayer().getTile().HasRoad && this.Math.rand(1, 1000) <= 1)
				{
					this.Flags.set("IsChangingSides", false);
					this.Contract.setScreen("ChangingSides");
					this.World.Contracts.showActiveContract();
				}

				foreach( i, obj in this.Contract.m.Objectives )
				{
					if (obj != null && !obj.isNull() && !obj.isActive() || obj.getSettlement().getOwner().isAlliedWithPlayer() || obj.isAlliedWithPlayer())
					{
						obj.getSprite("selection").Visible = false;
						obj.setAttackable(false);
						obj.getFlags().set("HasNobleProtection", false);
						obj.setOnCombatWithPlayerCallback(null);
					}

					if (obj == null || obj.isNull() || !obj.isActive() || obj.getSettlement().getOwner().isAlliedWithPlayer() || obj.isAlliedWithPlayer())
					{
						this.Contract.m.Objectives.remove(i);
						this.Flags.set("LastUpdateDay", 0);
						break;
					}
				}
			}

			function onCombatWithLocation( _dest, _isPlayerAttacking = true )
			{
				this.Contract.m.CurrentObjective = _dest;

				if (_dest.getTroops().len() == 0)
				{
					this.onCombatVictory("RazeLocation");
					return;
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "RazeLocation";
					p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
					p.LocationTemplate.Template[0] = "tactical.human_camp";
					p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.None;
					p.LocationTemplate.CutDownTrees = true;
					p.LocationTemplate.AdditionalRadius = 5;

					if (_dest.isMilitary())
					{
						p.Music = this.Const.Music.NobleTracks;
					}
					else
					{
						p.Music = this.Const.Music.CivilianTracks;
					}

					p.EnemyBanners = [];

					if (_dest.getSettlement().isMilitary() || _dest.getFlags().get("HasNobleProtection"))
					{
						p.EnemyBanners.push(_dest.getSettlement().getBanner());
					}
					else
					{
						p.EnemyBanners.push("banner_noble_11");
					}

					if (_dest.getFlags().get("HasNobleProtection"))
					{
						local f = this.Flags.get("FeudingHouseID");

						foreach( e in p.Entities )
						{
							if (e.Faction == _dest.getFaction())
							{
								e.Faction = f;
							}
						}
					}

					this.World.Contracts.startScriptedCombat(p, _isPlayerAttacking, true, true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "RazeLocation")
				{
					this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() * 20 * 0.01);
					this.Contract.m.CurrentObjective.setActive(false);
					this.Contract.m.CurrentObjective.spawnFireAndSmoke();
					this.Contract.m.CurrentObjective.clearTroops();
					this.Contract.m.CurrentObjective.getSprite("selection").Visible = false;
					this.Contract.m.CurrentObjective.setOnCombatWithPlayerCallback(null);
					this.Contract.m.CurrentObjective.setAttackable(false);
					this.Contract.m.CurrentObjective.getFlags().set("HasNobleProtection", false);
					this.Flags.set("Score", this.Flags.get("Score") + 5);

					foreach( i, obj in this.Contract.m.Objectives )
					{
						if (obj.getID() == this.Contract.m.CurrentObjective.getID())
						{
							this.Contract.m.Objectives.remove(i);
							break;
						}
					}

					this.Flags.set("LastUpdateDay", 0);
				}
			}

			function onPartyDestroyed( _party )
			{
				if (_party.getFaction() == this.Flags.get("FeudingHouseID") || this.World.FactionManager.isAllied(_party.getFaction(), this.Flags.get("FeudingHouseID")))
				{
					this.Flags.set("Score", this.Flags.get("Score") + 2);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Вернуться в " + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;

				foreach( obj in this.Contract.m.Objectives )
				{
					if (obj != null && !obj.isNull() && obj.isActive())
					{
						obj.getSprite("selection").Visible = false;
						obj.setOnCombatWithPlayerCallback(null);
					}
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("Score") <= 9)
					{
						this.Contract.setScreen("Failure1");
					}
					else if (this.Flags.get("Score") <= 15)
					{
						this.Contract.setScreen("Success1");
					}
					else
					{
						this.Contract.setScreen("Success2");
					}

					this.World.Contracts.showActiveContract();
				}
			}

		});
	}
});
::mods_hookExactClass("contracts/contracts/arena_tournament_contract", function(o) 
{
	o.getAmountToSpawn = function( _type, _resources, _min = 1, _max = 24 )
	{
		return this.Math.min(_max, this.Math.max(_min, _resources / (_type.Cost * 1.34)));
	}
});
::mods_hookExactClass("contracts/contracts/hunting_lindwurms_contract", function(o) 
{
	o.m.DifficultyMult <- this.Math.rand(120, 135) * 0.01;
});
})
