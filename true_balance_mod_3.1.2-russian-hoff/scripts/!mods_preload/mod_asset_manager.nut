::mods_registerMod("mod_asset_manager", 1.8, "True Balance Mod Asset Manager");
::mods_queue("mod_asset_manager", "mod_true_balance", function() {
::mods_hookNewObject("states/world/asset_manager", function(o) 
{
	o.m.RecruitsMult <- 1;

	if (::TrueBalance.Mod.ModSettings.getSetting("Champions").getValue())
	{
		o.m.ChampionChanceAdditional <- 5;
	}

	while (!("resetToDefaults" in o)) o = o[o.SuperName];
	local resetToDefaults = o.resetToDefaults;		
	o.resetToDefaults = function()
	{
		resetToDefaults()
		if (::TrueBalance.Mod.ModSettings.getSetting("Champions").getValue())
		{
			this.m.ChampionChanceAdditional = 5;
		}
	}

	o.update = function( _worldState )
	{
		if (this.World.getTime().Days > this.m.LastDayPaid && this.World.getTime().Hours > 8 && this.m.IsConsumingAssets)
		{
			this.m.LastDayPaid = this.World.getTime().Days;

			if (this.m.BusinessReputation > 0)
			{
				this.m.BusinessReputation = this.Math.max(0, this.m.BusinessReputation + this.Const.World.Assets.ReputationDaily);
			}

			this.World.Retinue.onNewDay();

			if (this.World.Flags.get("IsGoldenGoose") == true)
			{
				this.addMoney(15);
			}

			local roster = this.World.getPlayerRoster().getAll();
			local mood = 0;
			local slaves = 1;
			local nonSlaves = 0;

			if (this.m.Origin.getID() == "scenario.manhunters")
			{
				foreach( bro in roster )
				{
					if (bro.getBackground().getID() == "background.slave")
					{
						slaves = ++slaves;
					}
					else
					{
						nonSlaves = ++nonSlaves;
					}
				}
			}

			foreach( bro in roster )
			{
				bro.getSkills().onNewDay();
				bro.updateInjuryVisuals();

				if (bro.getDailyCost() > 0 && this.m.Money < bro.getDailyCost())
				{
					if (bro.getSkills().hasSkill("trait.greedy"))
					{
						bro.worsenMood(this.Const.MoodChange.NotPaidGreedy, "Не заплатили");
					}
					else
					{
						bro.worsenMood(this.Const.MoodChange.NotPaid, "Не заплатили");
					}
				}

				if (this.m.IsUsingProvisions && this.m.Food < bro.getDailyFood())
				{
					if (bro.getSkills().hasSkill("trait.spartan"))
					{
						bro.worsenMood(this.Const.MoodChange.NotEatenSpartan, "Не накормили");
					}
					else if (bro.getSkills().hasSkill("trait.gluttonous"))
					{
						bro.worsenMood(this.Const.MoodChange.NotEatenGluttonous, "Не накормили");
					}
					else
					{
						bro.worsenMood(this.Const.MoodChange.NotEaten, "Не накормили");
					}
				}

				if (this.m.Origin.getID() == "scenario.manhunters" && slaves < nonSlaves)
				{
					if (bro.getBackground().getID() != "background.slave")
					{
						bro.worsenMood(this.Const.MoodChange.TooFewSlaves, "Слишком мало непрощённых в отряде");
					}
				}

				this.m.Money -= bro.getDailyCost();
				mood = mood + bro.getMoodState();
			}

			this.Sound.play(this.Const.Sound.MoneyTransaction[this.Math.rand(0, this.Const.Sound.MoneyTransaction.len() - 1)], this.Const.Sound.Volume.Inventory);
			this.m.AverageMoodState = this.Math.round(mood / roster.len());
			_worldState.updateTopbarAssets();

			if (this.World.getPlayerRoster().getSize() == this.m.BrothersMax && this.m.Origin.getID() == "scenario.militia")
			{
				this.updateAchievement("HumanWave", 1, 1);
			}

			if (this.m.EconomicDifficulty >= 1 && this.m.CombatDifficulty >= 1)
			{
				if (this.World.getTime().Days >= 365)
				{
					this.updateAchievement("Anniversary", 1, 1);
				}
				else if (this.World.getTime().Days >= 100)
				{
					this.updateAchievement("Campaigner", 1, 1);
				}
				else if (this.World.getTime().Days >= 10)
				{
					this.updateAchievement("Survivor", 1, 1);
				}
			}
		}

		if (this.World.getTime().Hours != this.m.LastHourUpdated && this.m.IsConsumingAssets)
		{
			this.m.LastHourUpdated = this.World.getTime().Hours;
			this.consumeFood();
			local roster = this.World.getPlayerRoster().getAll();
			local campMultiplier = this.isCamping() ? 1.5 : 1.0;

			foreach( bro in roster )
			{
				local d = bro.getHitpointsMax() - bro.getHitpoints();

				if (bro.getHitpoints() < bro.getHitpointsMax())
				{
					bro.setHitpoints(this.Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + this.Const.World.Assets.HitpointsPerHour * campMultiplier * this.m.HitpointsPerHourMult));
				}
			}

			foreach( bro in roster )
			{
				if (this.m.ArmorParts == 0)
				{
					break;
				}

				local items = bro.getItems().getAllItems();
				local updateBro = false;

				foreach( item in items )
				{
					if (item.getCondition() < item.getConditionMax())
					{
						local d = this.Math.minf(this.Const.World.Assets.ArmorPerHour * campMultiplier * this.m.RepairSpeedMult, item.getConditionMax() - item.getCondition());
						item.setCondition(item.getCondition() + d);
						this.m.ArmorParts = this.Math.maxf(0, this.m.ArmorParts - d * this.m.ArmorPartsPerArmor);
						updateBro = true;
					}

					if (item.getCondition() >= item.getConditionMax())
					{
						item.setToBeRepaired(false);
					}

					if (this.m.ArmorParts == 0)
					{
						break;
					}
				}

				if (updateBro)
				{
					bro.getSkills().update();
				}
			}

			local items = this.m.Stash.getItems();

			foreach( item in items )
			{
				if (this.m.ArmorParts == 0)
				{
					break;
				}

				if (item == null)
				{
					continue;
				}

				if (item.isToBeRepaired())
				{
					if (item.getCondition() < item.getConditionMax())
					{
						local d = this.Math.minf(this.Const.World.Assets.ArmorPerHour * campMultiplier, item.getConditionMax() - item.getCondition());
						item.setCondition(item.getCondition() + d);
						this.m.ArmorParts = this.Math.maxf(0, this.m.ArmorParts - d * this.m.ArmorPartsPerArmor);
					}

					if (item.getCondition() >= item.getConditionMax())
					{
						item.setToBeRepaired(false);
					}
				}
			}

			if (this.World.getTime().Hours % 4 == 0)
			{
				this.checkDesertion();
				local towns = this.World.EntityManager.getSettlements();
				local playerTile = this.World.State.getPlayer().getTile();
				local town;

				foreach( t in towns )
				{
					if (t.getSize() >= 2 && !t.isMilitary() && t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
					{
						town = t;
						break;
					}
				}

				foreach( bro in roster )
				{
					bro.recoverMood();

					if (town != null && bro.getMoodState() <= this.Const.MoodState.Neutral)
					{
						bro.improveMood(this.Const.MoodChange.NearCity, "Рад, что посетил " + town.getName());
					}
				}
			}

			_worldState.updateTopbarAssets();
		}
	}
});
})
