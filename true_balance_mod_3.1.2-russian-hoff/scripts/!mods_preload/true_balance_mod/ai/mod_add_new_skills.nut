::mods_registerMod("mod_mod_add_new_skills", 1.8, "True Balance Mod mod add new skills");
::mods_queue("mod_mod_add_new_skills", "mod_hooks(>=17)", function() {
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_throw_net", function ( o )
{
	o.m.PossibleSkills.push("actives.web_all");
});
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_default", function ( o )
{
	o.m.PossibleSkills.push("actives.handorcs");
	o.m.PossibleSkills.push("actives.hive_queen_bite");
	o.m.PossibleSkills.push("actives.warbrand_slash");
	o.m.PossibleSkills.push("actives.throw_sper");
	o.m.PossibleSkills.push("actives.penetrate");
	o.m.PossibleSkills.push("actives.penetrate_goedendag");

	o.queryBestMeleeTarget <- function( _entity, _skill, _targets )
	{
		if (_entity.getSkills().hasSkill("actives.deathblow"))
		{
			for( local i = _targets.len() - 1; i >= 0; i = --i )
			{
				local targetStatus = _targets[i].getSkills();

				if (targetStatus.hasSkill("effects.insect_swarm") || targetStatus.hasSkill("effects.dazed") || targetStatus.hasSkill("effects.stunned") || targetStatus.hasSkill("effects.sleeping") || _targets[i].getCurrentProperties().IsRooted)
				{
					_targets.remove(i);
				}
			}
		}
		
		return this.behavior.queryBestMeleeTarget(_entity, _skill, _targets);
	}
});
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_knock_out", function ( o )
{
	o.m.PossibleSkills.push("actives.goedendag_knock_out");
	o.onEvaluate = function( _entity )
	{
		// Function is a generator.
		this.m.TargetTile = null;
		this.m.Skill = null;
		this.m.BestTarget = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local myTile = _entity.getTile();
		local targets = this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange() + (this.m.Skill.isRanged() ? myTile.Level : 0), this.m.Skill.getMaxLevelDifference());

		if (targets.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local func = this.getBestTarget(_entity, this.m.Skill, targets);

		while (resume func == null)
		{
			yield null;
		}

		if (this.m.BestTarget.Target == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.m.BestTarget.Target.getCurrentProperties().StunResist >= 50 && (this.m.Skill.getID() == "actives.goedendag_knock_out" || this.m.Skill.getID() == "actives.knock_out"))
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.m.BestTarget.Target.getCurrentProperties().DisarmResist >= 50 && (this.m.Skill.getID() == "actives.disarm" || this.m.Skill.getID() == "actives.serpent_disarm"))
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = this.m.BestTarget.Target.getTile();
		score = score * this.m.BestTarget.Score;
		return this.Const.AI.Behavior.Score.KnockOut * score;
	}
});
::mods_hookNewObject("ai/tactical/behaviors/ai_raise_undead", function ( o )
{
	o.m.PossibleSkills.push("actives.raise_undead_champion");
});
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_split", function ( o )
{
	o.m.PossibleSkills.push("actives.run_through");
});
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_bow", function ( o )
{
	o.m.PossibleSkills.push("actives.sling_balls");
});
::mods_hookNewObject("ai/tactical/behaviors/ai_defend_spearwall", function ( o )
{
	o.m.PossibleSkills.push("actives.spearwalls");
});
::mods_hookNewObject("ai/tactical/behaviors/ai_recover", function ( o )
{
	o.m.PossibleSkills.push("actives.recovers");
});
::mods_hookNewObject("ai/tactical/behaviors/ai_engage_melee", function ( o )
{
	o.m.PossibleSkills.push("actives.darkflight");
});
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_deathblow", function ( o )
{
	o.onEvaluate = function( _entity )
	{
		this.m.TargetTile = null;
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local myTile = _entity.getTile();
		local targets = this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange() + (this.m.Skill.isRanged() ? myTile.Level : 0), this.m.Skill.getMaxLevelDifference());

		if (targets.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local bestTarget;

		if (this.m.Skill.isRanged())
		{
			bestTarget = this.queryBestRangedTarget(_entity, this.m.Skill, targets);
		}
		else
		{
			bestTarget = this.queryBestMeleeTarget(_entity, this.m.Skill, targets);
		}

		if (bestTarget.Target == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.getAgent().getIntentions().IsChangingWeapons)
		{
			score = score * this.Const.AI.Behavior.AttackAfterSwitchWeaponMult;
		}

		this.m.TargetTile = bestTarget.Target.getTile();
		return this.Math.max(0, this.Const.AI.Behavior.Score.Deathblow * bestTarget.Score * score);
	}

	o.queryBestMeleeTarget = function( _entity, _skill, _targets )
	{
		for( local i = _targets.len() - 1; i >= 0; i = --i )
		{
			local targetStatus = _targets[i].getSkills();

			if (!targetStatus.hasSkill("effects.insect_swarm") && !targetStatus.hasSkill("effects.dazed") && !targetStatus.hasSkill("effects.stunned") && !targetStatus.hasSkill("effects.sleeping") && !_targets[i].getCurrentProperties().IsRooted)
			{
				_targets.remove(i);
			}
		}

		return this.behavior.queryBestMeleeTarget(_entity, _skill, _targets);
	}

	o.queryBestRangedTarget = function( _entity, _skill, _targets, _maxRange = 0 )
	{
		for( local i = _targets.len() - 1; i >= 0; i = --i )
		{
			local targetStatus = _targets[i].getSkills();

			if (!targetStatus.hasSkill("effects.insect_swarm") && !targetStatus.hasSkill("effects.dazed") && !targetStatus.hasSkill("effects.stunned") && !targetStatus.hasSkill("effects.sleeping") && !_targets[i].getCurrentProperties().IsRooted)
			{
				_targets.remove(i);
			}
		}

		return this.behavior.queryBestRangedTarget(_entity, _skill, _targets, _maxRange);
	}
});
::mods_hookNewObject("ai/tactical/behaviors/ai_indomitable", function ( o )
{
	o.onEvaluate = function( _entity )
	{
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getCurrentProperties().IsStunned)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getActionPointsMax() - _entity.getActionPoints() < 2)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasKnownOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local dotDamage = 0;
		local effects = _entity.getSkills().getAllSkillsOfType(this.Const.SkillType.DamageOverTime);

		foreach( dot in effects )
		{
			dotDamage = dotDamage + dot.getDamage();
		}

		if (dotDamage >= _entity.getHitpoints())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local myTile = _entity.getTile();
		local targets = this.queryTargetsInMeleeRange(1, 1);

		if (targets.len() <= 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		foreach( target in targets )
		{
			if (target.getSkills().hasSkill("actives.puncture"))
			{
				score = score + 1.0;
			}

			if (target.getSkills().hasSkill("actives.knock_out") || target.getSkills().hasSkill("actives.strike_down"))
			{
				score = score + 1.0;
			}
		}

		score = score * (1.0 + _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) * this.Const.AI.Behavior.IndomitableSurrounded);
		score = score * (1.0 + 1.0 - _entity.getHitpointsPct());

		if (_entity.getAttackedCount() > 3)
		{
			score = score * (_entity.getAttackedCount() / 3.0);
		}

		return this.Const.AI.Behavior.Score.Indomitable * score;
	}
});
::mods_hookNewObject("ai/tactical/behaviors/ai_defend_rotation", function ( o )
{
	o.onEvaluate = function( _entity )
	{
		// Function is a generator.
		this.m.TargetTile = null;
		this.m.Skill = null;
		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];
		local time = this.Time.getExactTime();

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (this.getAgent().getIntentions().IsChangingWeapons && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax() > 2)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		scoreMult = scoreMult * this.getFatigueScoreMult(this.m.Skill);
		local allies = this.queryAlliesInMeleeRange();

		if (allies.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local myTile = _entity.getTile();
		local zoc = _entity.getTile().getZoneOfOccupationCountOtherThan(_entity.getAlliedFactions());
		local isOffensive = this.m.Skill.getID() == "actives.barbarian_fury";
		local hitpointRatio = (_entity.getHitpoints() + _entity.getArmor(this.Const.BodyPart.Body) + _entity.getArmor(this.Const.BodyPart.Head)) / (_entity.getHitpointsMax() + _entity.getArmorMax(this.Const.BodyPart.Body) + _entity.getArmorMax(this.Const.BodyPart.Head));
		local isEntityWounded = false;

		if (hitpointRatio <= 0.5)
		{
			isEntityWounded = true;
		}

		local isEntityArmedWithShield = _entity.isArmedWithShield();
		local isEntityExpendable = _entity.getCurrentProperties().TargetAttractionMult <= 0.5;
		local isEntityRangedUnit = this.isRangedUnit(_entity);
		local isEntityArmedWithMeleeWeapon = true;
		local item = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (isEntityRangedUnit)
		{
			isEntityArmedWithMeleeWeapon = false;
		}
		else if (_entity.isArmedWithMeleeWeapon() && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax() > 1 && item != null && item.getID() != "weapon.estoc" && item.getID() != "weapon.named_estoc" && item.getID() != "weapon.fencing_sword" && item.getID() != "weapon.named_fencing_sword" && item.getID() != "weapon.goedendag")
		{
			isEntityArmedWithMeleeWeapon = false;
		}

		local isEntitySupport = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Misc);
		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		local apRequiredForAttack = attackSkill != null ? attackSkill.getActionPointCost() : 4;
		local isEntityAOE = isEntityArmedWithMeleeWeapon && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Weapon) && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE();
		local isEntityTwoHanded = isEntityArmedWithMeleeWeapon && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Weapon) && _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.TwoHanded);
		local currentPotentialTargets = this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.Math.max(_entity.getIdealRange(), this.getProperties().EngageRangeMax), 1, myTile);
		local currentBestTarget = this.queryBestMeleeTarget(_entity, null, currentPotentialTargets);
		local targets = this.getAgent().getKnownOpponents();
		local dirs = [
			0,
			0,
			0,
			0,
			0,
			0
		];

		foreach( opponent in targets )
		{
			local dir = myTile.getDirection8To(opponent.Actor.getTile());
			local mult = this.isRangedUnit(opponent.Actor) ? 2 : 1;
			mult = mult * (7.0 / myTile.getDistanceTo(opponent.Actor.getTile()));

			switch(dir)
			{
			case this.Const.Direction8.W:
				dirs[this.Const.Direction.NW] += 4 * mult;
				dirs[this.Const.Direction.SW] += 4 * mult;
				break;

			case this.Const.Direction8.E:
				dirs[this.Const.Direction.NE] += 4 * mult;
				dirs[this.Const.Direction.SE] += 4 * mult;
				break;

			default:
				local dir = myTile.getDirectionTo(opponent.Actor.getTile());
				local dir_left = dir - 1 >= 0 ? dir - 1 : 6 - 1;
				local dir_right = dir + 1 < 6 ? dir + 1 : 0;
				dirs[dir] += 4 * mult;
				dirs[dir_left] += 3 * mult;
				dirs[dir_right] += 3 * mult;
				break;
			}
		}

		local entityCover = 0.0;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local adjacentTile = myTile.getNextTile(i);

				if (dirs[i] >= 8 && !adjacentTile.IsEmpty)
				{
					entityCover = entityCover + dirs[i] / targets.len() * this.Const.AI.Behavior.DefendSeekCoverMult;
				}
			}
		}

		local isEntityAtIdealWeaponRange = true;

		if (zoc != 0 && !isEntityArmedWithMeleeWeapon)
		{
			isEntityAtIdealWeaponRange = false;
		}

		local bestTile;
		local bestScore = 1.0;

		foreach( ally in allies )
		{
			if (!this.m.Skill.onVerifyTarget(myTile, ally.getTile()))
			{
				continue;
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local score = 1.0;
			local reverseScore = 1.0;
			local allyTile = ally.getTile();
			local allyZOC = allyTile.getZoneOfOccupationCountOtherThan(ally.getAlliedFactions());
			local isAllyExpendable = ally.getCurrentProperties().TargetAttractionMult <= 0.5;
			local isAllyValuable = ally.getCurrentProperties().TargetAttractionMult > _entity.getCurrentProperties().TargetAttractionMult;
			local isEntityValuable = _entity.getCurrentProperties().TargetAttractionMult > ally.getCurrentProperties().TargetAttractionMult;
			local isAllyArmedWithMeleeWeapon = true;
			local isAllyRangedUnit = this.isRangedUnit(ally);
			local itema = ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (isAllyRangedUnit)
			{
				isAllyArmedWithMeleeWeapon = false;
			}
			else if (ally.isArmedWithMeleeWeapon() && ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getRangeMax() > 1 && itema != null && itema.getID() != "weapon.estoc" && itema.getID() != "weapon.named_estoc" && itema.getID() != "weapon.fencing_sword" && itema.getID() != "weapon.named_fencing_sword" && itema.getID() != "weapon.goedendag")
			{
				isAllyArmedWithMeleeWeapon = false;
			}

			local isAllySupport = ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Misc);
			local isAllyAOE = isAllyArmedWithMeleeWeapon && ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Weapon) && ally.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE();
			local isAllyAtIdealWeaponRange = true;

			if (allyZOC != 0 && !isAllyArmedWithMeleeWeapon)
			{
				isAllyAtIdealWeaponRange = false;
			}

			local isAllyFleeing = ally.getMoraleState() == this.Const.MoraleState.Fleeing;
			local isAllyDone = isAllyFleeing || ally.isTurnDone() || ally.getFatiguePct() >= 0.8 && _entity.getFatiguePct() <= 0.5 || ally.getCurrentProperties().IsStunned || !ally.getCurrentProperties().IsAbleToUseWeaponSkills;
			local isAllyTurnDone = isAllyFleeing || ally.isTurnDone() || ally.getCurrentProperties().IsStunned || !ally.getCurrentProperties().IsAbleToUseWeaponSkills;
			local isAllyArmedWithShield = ally.isArmedWithShield();
			local allyHitpointRatio = (ally.getHitpoints() + ally.getArmor(this.Const.BodyPart.Body) + ally.getArmor(this.Const.BodyPart.Head)) / (ally.getHitpointsMax() + ally.getArmorMax(this.Const.BodyPart.Body) + ally.getArmorMax(this.Const.BodyPart.Head));
			local dirs = [
				0,
				0,
				0,
				0,
				0,
				0
			];

			foreach( opponent in targets )
			{
				local dir = allyTile.getDirection8To(opponent.Actor.getTile());
				local mult = this.isRangedUnit(opponent.Actor) ? 2 : 1;
				mult = mult * (7.0 / allyTile.getDistanceTo(opponent.Actor.getTile()));

				switch(dir)
				{
				case this.Const.Direction8.W:
					dirs[this.Const.Direction.NW] += 4 * mult;
					dirs[this.Const.Direction.SW] += 4 * mult;
					break;

				case this.Const.Direction8.E:
					dirs[this.Const.Direction.NE] += 4 * mult;
					dirs[this.Const.Direction.SE] += 4 * mult;
					break;

				default:
					local dir = allyTile.getDirectionTo(opponent.Actor.getTile());
					local dir_left = dir - 1 >= 0 ? dir - 1 : 6 - 1;
					local dir_right = dir + 1 < 6 ? dir + 1 : 0;
					dirs[dir] += 4 * mult;
					dirs[dir_left] += 3 * mult;
					dirs[dir_right] += 3 * mult;
					break;
				}
			}

			local allyCover = 0.0;

			for( local i = 0; i < 6; i = ++i )
			{
				if (!allyTile.hasNextTile(i))
				{
				}
				else
				{
					local adjacentTile = allyTile.getNextTile(i);

					if (dirs[i] >= 8 && !adjacentTile.IsEmpty)
					{
						allyCover = allyCover + dirs[i] / targets.len() * this.Const.AI.Behavior.DefendSeekCoverMult;
					}
				}
			}

			if (!isAllyFleeing && isEntityArmedWithMeleeWeapon && !isAllyArmedWithMeleeWeapon && allyZOC != 0 && zoc == 0)
			{
				score = score * this.Const.AI.Behavior.RotationWrongWeaponMult;
			}
			else if (!isAllyValuable && !isAllyFleeing && !isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && allyZOC == 0 && zoc != 0)
			{
				score = score * this.Const.AI.Behavior.RotationWrongWeaponMult;

				if (isEntityRangedUnit)
				{
					score = score * (this.Const.AI.Behavior.RotationWrongWeaponMult * 3.0);
				}
			}

			if (!isAllyExpendable && !isAllyFleeing && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && isEntityArmedWithShield && !isAllyArmedWithShield && !isAllyAOE && allyZOC > zoc + 2)
			{
				score = score * this.Const.AI.Behavior.RotationShieldInFrontMult;
			}
			else if (!isAllyValuable && !isAllyFleeing && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && !isEntityArmedWithShield && isAllyArmedWithShield && !isEntityAOE && zoc > allyZOC + 2)
			{
				score = score * this.Const.AI.Behavior.RotationShieldInFrontMult;
			}

			if (!isOffensive && !isAllyExpendable && isEntityArmedWithMeleeWeapon && allyHitpointRatio < 0.5 && allyHitpointRatio < hitpointRatio - 0.2 && allyZOC > zoc + 1)
			{
				score = score * (this.Const.AI.Behavior.RotationSaveWoundedMult * (1.0 + (hitpointRatio - allyHitpointRatio)));
			}
			else if (!isOffensive && !isAllyValuable && !isAllyFleeing && isAllyArmedWithMeleeWeapon && hitpointRatio < 0.5 && allyHitpointRatio > hitpointRatio + 0.2 && zoc > allyZOC + 1)
			{
				score = score * (this.Const.AI.Behavior.RotationSaveWoundedMult * (1.0 + (allyHitpointRatio - hitpointRatio)));
			}

			if (!isAllyExpendable && isAllyFleeing && allyZOC > 0 && zoc == 0 && isEntityArmedWithMeleeWeapon)
			{
				score = score * this.Const.AI.Behavior.RotationSaveFleeingAlly;
			}

			if (ally.getCurrentProperties().TargetAttractionMult > _entity.getCurrentProperties().TargetAttractionMult * this.Const.AI.Behavior.RotationPriorityTargetMinPct && zoc < allyZOC)
			{
				score = score * this.Const.AI.Behavior.RotationPriorityTargetMult;
			}
			else if (_entity.getCurrentProperties().TargetAttractionMult > ally.getCurrentProperties().TargetAttractionMult * this.Const.AI.Behavior.RotationPriorityTargetMinPct && zoc > allyZOC && isAllyArmedWithMeleeWeapon)
			{
				score = score * this.Const.AI.Behavior.RotationPriorityTargetMult;
			}

			if (zoc == 0 && allyZOC >= 3 && isEntityAOE && !isAllyAOE && _entity.getActionPoints() >= 9 && isAllyTurnDone)
			{
				score = score * this.Const.AI.Behavior.RotationAOEMult;
			}
			else if (zoc >= 3 && allyZOC == 0 && !isEntityAOE && isAllyAOE && !isAllyTurnDone && !isAllyFleeing)
			{
				score = score * this.Const.AI.Behavior.RotationAOEMult;
			}

			if (isOffensive && _entity.getActionPoints() >= 9 && !isEntitySupport && !(allyZOC > zoc && !isEntityArmedWithMeleeWeapon) && !(zoc > allyZOC && !isAllyArmedWithMeleeWeapon) && !(isAllyFleeing && zoc != 0) && _entity.getCurrentProperties().IsAbleToUseWeaponSkills)
			{
				local potentialTargets = this.queryTargetsInMeleeRange(this.getProperties().EngageRangeMin, this.Math.max(_entity.getIdealRange(), this.getProperties().EngageRangeMax), 1, ally.getTile());
				local bestTarget = this.queryBestMeleeTarget(_entity, null, potentialTargets);

				if (!(zoc == 0 && bestTarget.Target != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee) != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee).m.TargetActor != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee).m.TargetActor.getID() == bestTarget.Target.getID()))
				{
					if (isAllyDone && !isEntityTwoHanded && bestTarget.Score > currentBestTarget.Score * 2.0 || isAllyDone && isEntityTwoHanded && bestTarget.Score > currentBestTarget.Score * 1.5 || bestTarget.Score > currentBestTarget.Score * 3.0)
					{
						score = score * (this.Const.AI.Behavior.RotationOffensiveMult + bestTarget.Score);
					}
				}
			}
			else if ((isOffensive || _entity.getXPValue() >= ally.getXPValue() * this.Const.AI.Behavior.RotationEliteAllyXPMult) && _entity.getActionPoints() <= 3 && ally.getActionPoints() >= 9 && !isAllyFleeing && !isAllySupport && ally.getCurrentProperties().IsAbleToUseWeaponSkills && (isAllyArmedWithMeleeWeapon || zoc == 0))
			{
				local potentialTargets = this.queryTargetsInMeleeRange(ally.getAIAgent().getProperties().EngageRangeMin, this.Math.max(ally.getIdealRange(), ally.getAIAgent().getProperties().EngageRangeMax), 1, myTile);
				local bestTarget = this.queryBestMeleeTarget(ally, null, potentialTargets);
				local allyPotentialTargets = this.queryTargetsInMeleeRange(ally.getAIAgent().getProperties().EngageRangeMin, this.Math.max(ally.getIdealRange(), ally.getAIAgent().getProperties().EngageRangeMax), 1, ally.getTile());
				local allyBestTarget = this.queryBestMeleeTarget(ally, null, allyPotentialTargets);

				if (bestTarget.Score > allyBestTarget.Score * 2.0)
				{
					score = score * (this.Const.AI.Behavior.RotationOffensiveMult + bestTarget.Score);
				}
			}

			if (this.getStrategy().isDefending() && isEntityArmedWithShield && !isAllyArmedWithShield && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && !isAllyRangedUnit && !isEntityRangedUnit && entityCover > allyCover * 2.0)
			{
				score = score * this.Const.AI.Behavior.RotationCoverMult;
			}
			else if (this.getStrategy().isDefending() && !isEntityArmedWithShield && isAllyArmedWithShield && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && !isAllyRangedUnit && !isEntityRangedUnit && allyCover > entityCover * 2.0)
			{
				score = score * this.Const.AI.Behavior.RotationCoverMult;
			}

			if (!isAllyFleeing && isEntityArmedWithMeleeWeapon && !isAllyArmedWithMeleeWeapon && allyZOC == 0 && zoc != 0)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationWrongWeaponMult;
			}
			else if (!isAllyValuable && !isAllyFleeing && !isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && allyZOC != 0 && zoc == 0)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationWrongWeaponMult;

				if (isEntityRangedUnit)
				{
					reverseScore = reverseScore * (this.Const.AI.Behavior.RotationWrongWeaponMult * 3.0);
				}
			}

			if (!isAllyExpendable && !isAllyFleeing && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && isEntityArmedWithShield && !isAllyArmedWithShield && !isAllyAOE && allyZOC <= zoc + 2)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationShieldInFrontMult;
			}
			else if (!isAllyValuable && !isAllyFleeing && isEntityArmedWithMeleeWeapon && isAllyArmedWithMeleeWeapon && !isEntityArmedWithShield && isAllyArmedWithShield && !isEntityAOE && zoc <= allyZOC + 2)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationShieldInFrontMult;
			}

			if (!isOffensive && !isAllyExpendable && isEntityArmedWithMeleeWeapon && allyHitpointRatio < 0.5 && allyHitpointRatio < hitpointRatio - 0.2 && allyZOC <= zoc + 1)
			{
				reverseScore = reverseScore * (this.Const.AI.Behavior.RotationSaveWoundedMult * (1.0 + (hitpointRatio - allyHitpointRatio)));
			}
			else if (!isOffensive && !isAllyValuable && !isAllyFleeing && isAllyArmedWithMeleeWeapon && hitpointRatio < 0.5 && allyHitpointRatio > hitpointRatio + 0.2 && zoc <= allyZOC + 1)
			{
				reverseScore = reverseScore * (this.Const.AI.Behavior.RotationSaveWoundedMult * (1.0 + (allyHitpointRatio - hitpointRatio)));
			}

			if (ally.getCurrentProperties().TargetAttractionMult > _entity.getCurrentProperties().TargetAttractionMult * this.Const.AI.Behavior.RotationPriorityTargetMinPct && zoc >= allyZOC)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationPriorityTargetMult;
			}
			else if (_entity.getCurrentProperties().TargetAttractionMult > ally.getCurrentProperties().TargetAttractionMult * this.Const.AI.Behavior.RotationPriorityTargetMinPct && zoc <= allyZOC && isEntityArmedWithMeleeWeapon)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationPriorityTargetMult;
			}

			if (allyZOC == 0 && zoc >= 3 && isEntityAOE && !isAllyAOE && !isAllyFleeing && _entity.getActionPoints() >= 9)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationAOEMult;
			}
			else if (allyZOC >= 3 && zoc == 0 && !isEntityAOE && isAllyAOE && !isAllyFleeing)
			{
				reverseScore = reverseScore * this.Const.AI.Behavior.RotationAOEMult;
			}

			if (score > reverseScore && score > bestScore)
			{
				bestTile = ally.getTile();
				bestScore = score;
			}
		}

		if (bestTile == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTile;
		scoreMult = scoreMult * bestScore;

		if (this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee) != null && this.getAgent().getBehavior(this.Const.AI.Behavior.ID.EngageMelee).getScore() * 1.5 >= this.Const.AI.Behavior.Score.Rotation * scoreMult)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		return this.Const.AI.Behavior.Score.Rotation * scoreMult;
	}

	o.onExecute = function( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": использовал умение 'Рокировка'!");
		}

		this.m.Skill.use(this.m.TargetTile);

		if (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer)
		{
			this.getAgent().declareEvaluationDelay(1000);
			this.getAgent().declareAction();
		}

		this.m.TargetTile = null;
		this.m.Skill = null;
		return true;
	}
});
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_thresh", function ( o )
{
	o.getBestTarget = function( _entity, _skill )
	{
		local ourTile = _entity.getTile();
		local bestTarget;
		local score = 0;
		local numTargets = 0;
		local numAllies = 0;

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ourTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ourTile.getNextTile(i);

				if (!tile.IsOccupiedByActor)
				{
				}
				else if (this.Math.abs(tile.Level - ourTile.Level) > 1)
				{
				}
				else
				{
					local target = tile.getEntity();

					if (target.isAlliedWith(_entity))
					{
						local relief = target.getCurrentProperties().getMeleeDefense() * 0.01;
						score = score - this.Math.max(0, 1.0 - this.getProperties().TargetPriorityHittingAlliesMult - relief) * target.getCurrentProperties().TargetAttractionMult;
						numAllies = ++numAllies;
					}
					else
					{
						score = (score + this.queryTargetValue(_entity, target, _skill)) * 2;
						numTargets = ++numTargets;

						if (bestTarget == null && _skill.onVerifyTarget(ourTile, tile))
						{
							bestTarget = tile;
						}
					}
				}
			}
		}

		if (numTargets < this.m.MinTargets || numAllies >= numTargets || numAllies >= 2 || (numAllies >= 1 && numTargets <= 2))
		{
			return {
				Target = null,
				Score = 0.0
			};
		}
		else
		{
			return {
				Target = bestTarget,
				Score = score
			};
		}
	}
});
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_splitshield", function ( o )
{
	o.onEvaluate = function( _entity )
	{
		this.m.TargetTile = null;
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local targets = this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference());

		if (targets.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local shieldDamage = _entity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage() * 1.0;

		if (_entity.getCurrentProperties().IsSpecializedInAxes && this.m.Skill.isAxeMasteryApplied())
		{
			shieldDamage = shieldDamage + this.Math.max(1, shieldDamage / 2) * 1.0;
		}

		local myTile = _entity.getTile();
		local bestTarget;
		local bestScore = -9000.0;

		foreach( t in targets )
		{
			if (!t.isArmedWithShield() || !this.m.Skill.isUsableOn(t.getTile()))
			{
				continue;
			}

			local possibleScore = 1.0;
			local possibleShieldDamage = shieldDamage;
			local targetValue = this.queryTargetValue(_entity, t, null);
			possibleScore = possibleScore * targetValue;
			local meleeDefense = t.getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.SplitShieldDefenseMult * 0.01;
			possibleScore = possibleScore + meleeDefense;
			possibleScore = possibleScore * (t.getHitpoints() / t.getHitpointsMax());

			if (t.getSkills().hasSkill("perk.shield_expert"))
			{
				shieldDamage = shieldDamage - this.Math.max(1, shieldDamage / 2) * 1.0;
			}

			local shieldCondition = t.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).getCondition() * 1.0;

			if (shieldCondition > 500)
			{
				continue;
			}

			local destroyShieldValue = this.Math.maxf(1.0, shieldDamage) * this.Const.AI.Behavior.SplitShieldDamageValueMult / shieldCondition;
			possibleScore = possibleScore * this.Math.pow(this.Math.minf(1.0, destroyShieldValue), 2);

			if (shieldDamage >= shieldDamage)
			{
				possibleScore = possibleScore * this.Const.AI.Behavior.SplitShieldDestroyBonusMult;
			}

			possibleScore = possibleScore * (1.0 - (targets.len() - 1) / 6.0);
			local ZoC = t.getTile().getZoneOfControlCountOtherThan(t.getAlliedFactions());

			if (ZoC > 1)
			{
				possibleScore = possibleScore * this.Math.pow(this.Const.AI.Behavior.SplitShieldAlliesAlsoEngagedMult, ZoC - 1);
			}

			foreach( other in targets )
			{
				if (!other.isArmedWithShield() && this.queryTargetValue(_entity, other, null) >= targetValue * this.Const.AI.Behavior.SplitShieldAlternativeTargetValuePct)
				{
					possibleScore = possibleScore * this.Const.AI.Behavior.SplitShieldAlternativeTargetMult;
				}
			}

			if (possibleScore > bestScore)
			{
				bestTarget = t;
				bestScore = possibleScore;
			}
		}

		if (bestTarget == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTarget.getTile();
		return this.Const.AI.Behavior.Score.SplitShield * score * bestScore;
	}
});
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_puncture", function ( o )
{
	o.onEvaluate = function( _entity )
	{
		this.m.TargetTile = null;
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local targets = this.queryTargetsInMeleeRange();

		if (targets.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local bestTarget = this.getBestTarget(_entity, this.m.Skill, targets);

		if (bestTarget.Target == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTarget.Target.getTile();
		score = score * bestTarget.Score;
		return this.Const.AI.Behavior.Score.Puncture * score;
	}

	o.getBestTarget = function( _entity, _skill, _targets )
	{
		local bestTarget;
		local bestScore = 0.0;

		foreach( target in _targets )
		{
			if (!_skill.isUsableOn(target.getTile()))
			{
				continue;
			}

			if (_skill.getHitchance(target) <= 69 && !_entity.getSkills().hasSkill("effects.backstabber") && !_entity.getSkills().hasSkill("effects.y_dagger"))
			{
				if (!target.getCurrentProperties().IsStunned && !target.getSkills().hasSkill("effects.disarmed"))
				{
					continue;
				}
			}

			if (target.getArmor(this.Const.BodyPart.Body) <= 60)
			{
				continue;
			}

			if (target.getSkills().hasSkill("perk.nimble"))
			{
				continue;
			}

			local p = _entity.getCurrentProperties();
			local armor = target.getArmor(this.Const.BodyPart.Body) * (p.getHitchance(this.Const.BodyPart.Body) / 100.0) + target.getArmor(this.Const.BodyPart.Head) * (p.getHitchance(this.Const.BodyPart.Head) / 100.0);

			if (armor <= 40 && target.getHitpoints() > _entity.getCurrentProperties().getRegularDamageAverage())
			{
				continue;
			}

			local score = this.queryTargetValue(_entity, target, _skill);
			score = score * this.Math.pow(armor / 100.0, 1.1);

			if (score > bestScore)
			{
				bestTarget = target;
				bestScore = score;
			}
		}

		return {
			Target = bestTarget,
			Score = bestScore
		};
	}
});
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_swing", function ( o )
{
	o.onEvaluate = function( _entity )
	{
		this.m.TargetTile = null;
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local targets = this.queryTargetsInMeleeRange();

		if (targets.len() < this.m.MinTargets)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local bestTarget = this.getBestTarget(_entity, this.m.Skill, targets);

		if (bestTarget.Target == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTarget.Target.getTile();
		return this.Const.AI.Behavior.Score.Swing * bestTarget.Score * score * 3;
	}
});
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_spilt", function ( o )
{
	o.onEvaluate = function( _entity )
	{
		this.m.TargetTile = null;
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local bestTarget = this.getBestTarget(_entity, this.m.Skill);

		if (bestTarget.Target == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTarget.Target;
		return this.Const.AI.Behavior.Score.Split * bestTarget.Score * score * 5;
	}
});
::mods_hookNewObject("ai/tactical/behaviors/ai_attack_crush_armor", function ( o )
{
	o.onEvaluate = function( _entity )
	{
		this.m.TargetTile = null;
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local targets = this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference());

		if (targets.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local bestTarget = this.getBestTarget(_entity, this.m.Skill, targets);

		if (bestTarget.Target == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTarget.Target.getTile();
		score = score * bestTarget.Score;
		local armors = bestTarget.Target.getArmor(this.Const.BodyPart.Body)
		if (armors < 120)
		{
			score = score * 0;
		}

		if (targets.len() > 1)
		{
			local targetValue = this.queryTargetValue(_entity, bestTarget.Target, null);

			foreach( t in targets )
			{
				if (this.queryTargetValue(_entity, t, null) >= targetValue * this.Const.AI.Behavior.CrushArmorBetterTargetPct)
				{
					score = score * this.Const.AI.Behavior.CrushArmorBetterTargetMult;
				}
			}
		}

		return this.Const.AI.Behavior.Score.CrushArmor * score;
	}
});
})
