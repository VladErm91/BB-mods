::mods_registerMod("mod_perks", 1.8, "True Balance Mod Perks");
::mods_queue("mod_perks", "mod_hooks(>=17)", function() {
::mods_hookNewObject("skills/perks/perk_anticipation", function(o) 
{
	o.onBeingAttacked = function( _attacker, _skill, _properties )
	{
		local dist = _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile());
		_properties.RangedDefense += this.Math.max(5, this.Math.floor(dist * (1 + this.getContainer().getActor().getBaseProperties().getRangedDefense() * 0.1)));
	}

	o.onUpdate = function( _properties )
	{
        _properties.MeleeDefense += this.getContainer().getActor().getBaseProperties().RangedDefense * 0.25;
	}
});
::mods_hookNewObject("skills/perks/perk_backstabber", function(o) 
{
	o.onUpdate = function( _properties )
	{
		_properties.SurroundedBonus = 10;
		this.m.Container.add(this.new("scripts/skills/effects/perk_backstabber_effect"));
	}
});
::mods_hookNewObject("skills/perks/perk_berserk", function(o) 
{
	o.onTargetKilled = function( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();
		if (this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == actor.getID())
		{
			actor.getSkills().add(this.new("scripts/skills/effects/bersrs_effect"));
		}

		if (actor.isAlliedWith(_targetEntity))
		{
			return;
		}

		if (!this.m.IsSpent && this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == actor.getID())
		{
			this.m.IsSpent = true;
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 4));
			actor.setDirty(true);
			this.spawnIcon("perk_35", this.m.Container.getActor().getTile());
		}
	}
});
::mods_hookNewObject("skills/perks/perk_bullseye", function(o) 
{
	o.onUpdate = function( _properties )
	{
		_properties.RangedAttackBlockedChanceMult *= 0.54;
	}
});
::mods_hookNewObject("skills/perks/perk_coup_de_grace", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		if (_skill.isAttack() && (_targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury) || _targetEntity.getSkills().hasSkill("effects.broken_bones")))
		{
			_properties.DamageTotalMult *= 1.2;
		}

		if (_skill.isAttack() && (_targetEntity.getSkills().hasSkill("effects.stunned") || _targetEntity.getSkills().hasSkill("effects.dazed") || _targetEntity.getSkills().hasSkill("effects.net") || _targetEntity.getSkills().hasSkill("effects.distracted") || _targetEntity.getSkills().hasSkill("effects.staggered") && !_targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury) && !_targetEntity.getSkills().hasSkill("effects.broken_bones")))
		{
			_properties.DamageTotalMult *= 1.1;
		}
	}
});
::mods_hookNewObject("skills/perks/perk_duelist", function(o) 
{
	o.onUpdate = function( _properties )
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (this.getContainer().getActor().isArmedWithMeleeWeapon())
		{
			if (off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand) || off != null && off.isItemType(this.Const.Items.ItemType.Tool) || off != null && (off.getID() == "shield.goblin_light_shield" || off.getID() == "shield.goblin_heavy_shield" || off.getID() == "shield.buckler"))
			{
				_properties.DamageDirectAdd += 0.25;
			}
        }
	}
});
::mods_hookNewObject("skills/perks/perk_fast_adaption", function(o) 
{
	o.m.IsSpent <- false;
	o.onUpdate = function( _properties )
	{
		this.m.IsHidden = this.m.Stacks == 0;

		local actor = this.getContainer().getActor();

		if (actor.getSkills().hasSkill("effects.shieldwall") && this.Time.getFrame() != this.m.Frame && this.m.SkillCount != this.Const.SkillCounter && !this.m.IsSpent)
		{
			++this.m.Stacks;
			this.m.Frame = this.Time.getFrame();
			this.m.SkillCount = this.Const.SkillCounter;
			this.m.IsHidden = false;
			this.m.IsSpent = true;

			if (this.m.Stacks == 1)
			{
				this.getContainer().getActor().setDirty(true);
			}
		}
	}

	o.onCombatStarted = function()
	{
		this.m.Stacks = 0;
		this.m.Frame = 0;
		this.m.SkillCount = 0;
		this.m.IsHidden = true;
		this.m.IsSpent = false;
	}

	o.onTurnStart = function()
	{
		this.m.IsSpent = false;
	}

	o.onCombatFinished = function()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
		this.m.Frame = 0;
		this.m.SkillCount = 0;
		this.m.IsHidden = true;
		this.m.IsSpent = false;
	}
});
::mods_hookNewObject("skills/perks/perk_fearsome", function(o) 
{
	o.onUpdate = function( _properties )
	{
		_properties.IsAffectedByFleeingAllies = false;
	}
});
::mods_hookNewObject("skills/perks/perk_fortified_mind", function(o) 
{
	o.onDamageReceived = function( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker == null)
		{
			return;
		}

		local a = this.getContainer().getActor();

		if (!a.getSkills().hasSkill("effects.rallied"))
		{
			local difficulty = a.getCurrentProperties().getBravery() + 15;
			local morale = a.getMoraleState();

			if (a.getMoraleState() == this.Const.MoraleState.Fleeing)
			{
				a.checkMorale(this.Const.MoraleState.Wavering - this.Const.MoraleState.Fleeing, difficulty, this.Const.MoraleCheckType.Default, "status_effect_56");
			}

			if (morale != a.getMoraleState())
			{
				a.getSkills().add(this.new("scripts/skills/effects/rallied_effect"));
			}
		}
	}
});
::mods_hookNewObject("skills/perks/perk_head_hunter", function(o) 
{
	o.onAdded = function()
	{
		if (!this.m.Container.hasSkill("actives.hunt"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/hunt_skill"));
		}
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_bodyPart == this.Const.BodyPart.Head && !this.getContainer().hasSkill("effects.hunt"))
		{
			if (!this.m.Container.hasSkill("actives.hunt"))
			{
				this.m.Container.add(this.new("scripts/skills/actives/hunt_skill"));
			}

			this.m.Container.add(this.new("scripts/skills/effects/hunt_effect"));
		}
		else
		{
			this.m.Container.removeByID("actives.hunt");
			this.m.Container.removeByID("effects.hunt");
		}

		this.getContainer().getActor().setDirty(true);
	}

	o.onRemoved = function()
	{
		this.m.Container.removeByID("actives.hunt");
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
	}

	o.onCombatFinished = function()
	{
	}

	o.onUpdate = function( _properties )
	{
	}
});
::mods_hookNewObject("skills/perks/perk_hold_out", function(o) 
{
o.m.IsSpent <- false;

	o.onUpdate = function( _properties )
	{
		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
		}
		else
		{
			return;
		}
		
		_properties.NegativeStatusEffectDuration += -5;
		local actor = this.getContainer().getActor();
		local maxHP = actor.getHitpointsMax();
		local currentHP = actor.getHitpoints();

		if (currentHP < maxHP / 1.7)
		{
			if (!actor.getSkills().hasSkill("effects.second_wind") && !this.m.IsSpent)
			{
				if (actor.getFaction() == this.Const.Faction.Player && actor.getPlaceInFormation() > 17)
				{

				}
				else
				{	
					this.m.IsSpent = true;
                	this.getContainer().removeByType(this.Const.SkillType.DamageOverTime);
					actor.getSkills().add(this.new("scripts/skills/effects/second_wind_effect"));
			    	this.spawnIcon("perk_04", this.m.Container.getActor().getTile());

					if (this.m.Container.hasSkill("effects.stunned"))
					{
						this.m.Container.removeByID("effects.stunned");
						local actor = this.getContainer().getActor();
						actor.getSkills().add(this.new("scripts/skills/effects/stun_helper_effect"))
					}

					if (this.m.Container.hasSkill("effects.goblin_poison"))
					{
						this.m.Container.removeByID("effects.goblin_poison");
					}

					if (this.m.Container.hasSkill("effects.dazed"))
					{
						this.m.Container.removeByID("effects.dazed");
					}

					if (this.m.Container.hasSkill("effects.staggered"))
					{
					this.m.Container.removeByID("effects.staggered");
					}

					if (this.m.Container.hasSkill("effects.charmed"))
					{
						this.m.Container.removeByID("effects.charmed");
					}

					if (this.m.Container.hasSkill("effects.sleeping"))
					{
						this.m.Container.removeByID("effects.sleeping");
					}
				}
			}
		}
	}

	o.onCombatStarted = function()
	{
		this.m.IsSpent = false;
	}
	
	o.onRemoved = function()
	{
		this.getContainer().removeByID("effects.second_wind");
	}

	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		local actor = this.getContainer().getActor();

		if (actor.getSkills().hasSkill("effects.second_wind") && this.m.IsSpent)
		{
	        this.getContainer().removeByID("effects.second_wind");
		}
	}
});
::mods_hookNewObject("skills/perks/perk_killing_frenzy", function(o) 
{
	o.onTargetKilled = function( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();
		actor.getSkills().add(this.new("scripts/skills/effects/bersr_effect"));

		if (!_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			local effect = this.getContainer().getActor().getSkills().getSkillByID("effects.killing_frenzy");

			if (effect != null)
			{
				effect.reset();
			}
			else
			{
				this.getContainer().add(this.new("scripts/skills/effects/killing_frenzy_effect"));
			}
		}
	}

	o.onTurnStart = function()
	{
		this.m.Container.removeByID("effects.bersr");
	}

	o.onRemoved = function()
	{
		this.m.Container.removeByID("effects.berserk");
		this.m.Container.removeByID("effects.bersr");
	}
});
::mods_hookNewObject("skills/perks/perk_mastery_throwing", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		if (_skill.isRanged() && (_skill.getID() == "actives.throw_axe" || _skill.getID() == "actives.throw_balls" || _skill.getID() == "actives.throw_javelin" || _skill.getID() == "actives.throw_spear" || _skill.getID() == "actives.sling_stone" || _skill.getID() == "actives.sling_ball" || _skill.getID() == "actives.sling_balls"))
		{
			local d = this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile());

			if (!this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
			{
				if (d <= 2)
				{
					_properties.DamageTotalMult *= 1.4;
				}
				else if (d <= 3)
				{
					_properties.DamageTotalMult *= 1.3;
				}
				else if (d <= 4)
				{
					_properties.DamageTotalMult *= 1.2;
				}
				else if (d <= 5)
				{
					_properties.DamageTotalMult *= 1.2;
				}
				else if (d <= 6)
				{
					_properties.DamageTotalMult *= 1.2;
				}
				else if (d <= 7)
				{
					_properties.DamageTotalMult *= 1.2;
				}
				else if (d <= 8)
				{
					_properties.DamageTotalMult *= 1.2;
				}
				else if (d <= 9)
				{
					_properties.DamageTotalMult *= 1.2;
				}
				else if (d <= 10)
				{
					_properties.DamageTotalMult *= 1.2;
				}
			}
		}
	}
});
::mods_hookNewObject("skills/perks/perk_nimble", function(o) 
{
o.m.Stacks <- 0;
o.m.Frame <- 0;
o.m.SkillCount <- 0;

	o.isHidden = function()
	{
		local fm = this.Math.floor(this.getChance() * 100);
		return fm >= 100;
	}

	o.getDescription = function()
	{
		return "Ловкий, как кошка! Этот персонаж способен уклониться или отразить атаку в последний момент, превращая её в скользящий удар. Чем легче броня, тем выше этот шанс.";
	}

	o.getTooltip = function()
	{
		local initiatives = this.getContainer().getActor().getInitiative() * 0.1;
		local initiative = this.Math.max(1, initiatives);
		local chances;

		if (initiatives >= 10)
		{
			chances = 0;
		}

		if (initiatives < 10)
		{
			chances = 0.01;
		}

		if (initiatives < 8)
		{
			chances = 0.02;
		}

		if (initiatives < 6)
		{
			chances = 0.03;
		}

		if (initiatives < 4)
		{
			chances = 0.04;
		}

		if (initiatives < 2)
		{
			chances = 0.05;
		}

		local fma = this.Math.round(this.m.Stacks * chances * 100);
		local fm = this.Math.round(this.getChance() * 100);
		local tooltip = this.skill.getTooltip();

		if ((fm + fma) < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Атаки противников наносят здоровью этого персонажа лишь [color=" + this.Const.UI.Color.PositiveValue + "]" + (fm + fma) + "%[/color] урона"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Атаки противников наносят здоровью этого персонажа лишь [color=" + this.Const.UI.Color.PositiveValue + "]" + 100 + "%[/color] урона"
			});
		}

		return tooltip;
	}

	o.getChance = function()
	{
		local fat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
		}

		fat = this.Math.min(0, fat + 15);
		local ret = this.Math.minf(1.0, 1.0 - 0.6 + this.Math.pow(this.Math.abs(fat), 1.5) * 0.01);
		return ret;
	}

	o.onCombatStarted = function()
	{
		this.m.Stacks = 0;
		this.m.Frame = 0;
		this.m.SkillCount = 0;
	}

	o.onCombatFinished = function()
	{
		this.m.Stacks = 0;
		this.m.Frame = 0;
		this.m.SkillCount = 0;
	}

	o.onTurnStart = function()
	{
		this.m.Stacks = 0;
		this.m.Frame = 0;
		this.m.SkillCount = 0;
	}

	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		if (this.Time.getFrame() != this.m.Frame && this.m.SkillCount != this.Const.SkillCounter)
		{
			++this.m.Stacks;
			this.m.Frame = this.Time.getFrame();
			this.m.SkillCount = this.Const.SkillCounter;
			this.m.IsHidden = false;

			if (this.m.Stacks == 1)
			{
				this.getContainer().getActor().setDirty(true);
			}
		}

		local initiatives = this.getContainer().getActor().getInitiative() * 0.1;
		local initiative = this.Math.max(1, initiatives);
		local chance = this.getChance();
		local chances;

		if (initiatives >= 10)
		{
			chances = 0;
		}

		if (initiatives < 10)
		{
			chances = 0.01;
		}

		if (initiatives < 8)
		{
			chances = 0.02;
		}

		if (initiatives < 6)
		{
			chances = 0.03;
		}

		if (initiatives < 4)
		{
			chances = 0.04;
		}

		if (initiatives < 2)
		{
			chances = 0.05;
		}

		_properties.DamageReceivedRegularMult *= this.Math.minf(1.0, (chance + this.m.Stacks * chances));
	}
});
::mods_hookNewObject("skills/perks/perk_pathfinder", function(o) 
{
	o.onUpdate = function( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.PathfinderMovementAPCost;
		actor.m.FatigueCosts = clone this.Const.PathfinderMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
		_properties.FatigueRecoveryRate += 1;
	}
});
::mods_hookNewObject("skills/perks/perk_reach_advantage", function(o) 
{
o.m.Stacks <- 0;
o.m.Stack <- 0;

	o.getDescription = function()
	{
		return "Этот персонаж использует превосходство в дальности атаки своего оружия ближнего боя, чтобы держать врагов на расстоянии, увеличивая защиту в ближнем бою на [color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.Stacks * 5 + this.m.Stack * 2) + "[/color] до своего следующего хода.";
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!this.getContainer().getActor().getCurrentProperties().IsAbleToUseWeaponSkills)
		{
			return;
		}

		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
		{
			this.m.Stacks = this.Math.min(this.m.Stacks + 1, 5);
		}
	}

	o.onTargetMissed = function( _skill, _targetEntity )
	{
		if (!this.getContainer().getActor().getCurrentProperties().IsAbleToUseWeaponSkills)
		{
			return;
		}

		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
		{
			this.m.Stack = this.Math.min(this.m.Stack + 1, 3);
		}
	}

	o.onUpdate = function( _properties )
	{
		this.m.IsHidden = this.m.Stacks == 0 && this.m.Stack == 0;
		local weapon = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
		{
			_properties.MeleeDefense += this.m.Stacks * 5;
		}
		else
		{
			this.m.Stacks = 0;
		}

		if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.MeleeWeapon) && weapon.isItemType(this.Const.Items.ItemType.TwoHanded))
		{
			_properties.MeleeDefense += this.m.Stack * 2;
		}
		else
		{
			this.m.Stack = 0;
		}
	}

	o.onTurnStart = function()
	{
		this.m.Stacks = 0;
		this.m.Stack = 0;
		this.m.IsHidden = true;
	}

	o.onCombatStarted = function()
	{
		this.m.Stacks = 0;
		this.m.Stack = 0;
		this.m.IsHidden = true;
	}

	o.onCombatFinished = function()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
		this.m.Stack = 0;
		this.m.IsHidden = true;
	}
});
::mods_hookNewObject("skills/perks/perk_recover", function(o) 
{
	o.onAdded = function()
	{
		this.m.Container.removeByID("actives.recovers");

		if (!this.m.Container.hasSkill("actives.recover"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/recover_skill"));
		}
	}

	o.onRemoved = function()
	{
		this.m.Container.removeByID("actives.recover");

		if (!this.m.Container.hasSkill("actives.recovers"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/recovers_skill"));
		}
	}
});
::mods_hookNewObject("skills/perks/perk_relentless", function(o) 
{
	o.onUpdate = function( _properties )
	{
		_properties.FatigueToInitiativeRate *= 0.5;
		_properties.InitiativeAfterWaitMult = 1.0;
		_properties.FatigueReceivedPerHitMult *= 0.4;
	}
});
})
