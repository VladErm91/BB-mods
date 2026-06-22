::mods_registerMod("mod_effects", 1.8, "True Balance Mod Effects");
::mods_queue("mod_effects", "mod_true_balance", function() {
::mods_hookNewObject("skills/effects/adrenaline_effect", function(o) 
{
	o.getDescription = function()
	{
		return "Вперёд, вперёд! Этот персонаж испытывает прилив адреналина и его инициатива увеличивается на [color=" + this.Const.UI.Color.PositiveValue + "]150[/color] с учетом затрат выносливости на это умение.";
	}

	o.onUpdate = function( _properties )
	{
		if (this.m.TurnsLeft != 0)
		{
			_properties.InitiativeForTurnOrderAdditional += 170;
		}
	}
});
::mods_hookNewObject("skills/effects/indomitable_effect", function(o) 
{
	o.getTooltip = function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Получает лишь [color=" + this.Const.UI.Color.PositiveValue + "]75%[/color] входящего урона"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Невосприимчивость к оглушению"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Невосприимчивость к отталкиванию и захвату"
			}
		];
	}

	o.onUpdate = function( _properties )
	{
		_properties.DamageReceivedTotalMult *= 0.75;
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
		_properties.TargetAttractionMult *= 1.5;
	}
});
::mods_hookNewObject("skills/effects/killing_frenzy_effect", function(o) 
{
	o.onTurnEnd = function()
	{
		local actor = this.getContainer().getActor();

		if (!actor.getSkills().hasSkill("effects.bersr") && actor.getMoraleState() != this.Const.MoraleState.Breaking)
		{
			actor.checkMorale(-1, -15, this.Const.MoraleCheckType.MentalAttack);
		}

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
});
::mods_hookNewObject("skills/effects/lone_wolf_effect", function(o) 
{
	o.onUpdate = function( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.IsHidden = true;
			return;
		}

		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local isAlone = true;

		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}

			if (ally.getTile().getDistanceTo(myTile) <= 2)
			{
				isAlone = false;
				break;
			}
		}

		if (isAlone)
		{
			this.m.IsHidden = false;
			_properties.MeleeSkillMult *= 1.15;
			_properties.RangedSkillMult *= 1.15;
			_properties.MeleeDefenseMult *= 1.15;
			_properties.RangedDefenseMult *= 1.15;
			_properties.BraveryMult *= 1.15;
		}
		else
		{
			this.m.IsHidden = true;
		}
	}
});
::mods_hookNewObject("skills/effects/poison_coat_effect", function(o) 
{
o.m.AttacksLeft = 8;
	o.getDescription = function()
	{
		return "Оружие этого персонажа покрыто ядом. Следующие [color=" + this.Const.UI.Color.NegativeValue + "]" + 1 * this.m.AttacksLeft + "[/color] ударов нанесут не менее [color=" + this.Const.UI.Color.NegativeValue + "]" + this.Const.Combat.PoisonEffectMinDamage + "[/color] урона ОЗ. У поражённых целей помутнеет в глазах и потеряется координация движений, пока эффект не рассеется.\n\nНа продолжительность этого эффекта не влияет навык 'Выдержка'.";
	}

	o.getTooltip = function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	o.resetTime = function()
	{
		if (this.getContainer().getActor().isPlacedOnMap())
		{
			this.spawnIcon("status_effect_54", this._targetEntity.getTile());
		}

		this.m.AttacksLeft = 8;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0)
		{
			this.removeSelf();
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < this.Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (!_targetEntity.isAlive())
		{
			return;
		}

        if (_targetEntity.getSkills().hasSkill("effects.second_wind"))
		{
			return;
		}

		if (_targetEntity.getFlags().has("undead"))
		{
			return;
		}

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " отравлен");
		}

		local poison = _targetEntity.getSkills().getSkillByID("effects.goblin_poison");

		if (poison == null)
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/goblin_poison_effect"));
		}
		else
		{
			poison.resetTime();
		}
	}

	o.onTargetMissed = function( _skill, _targetEntity )
	{
		--this.m.AttacksLeft;

		if (this.m.AttacksLeft <= 0)
		{
			this.removeSelf();
		}
	}
});
::mods_hookNewObject("skills/effects/spider_poison_coat_effect", function(o) 
{
o.m.AttacksLeft = 8;
	o.getDescription = function()
	{
		return "Оружие этого персонажа покрыто концентрированным ядом сетеплёта. Следующие [color=" + this.Const.UI.Color.NegativeValue + "]" + 1 * this.m.AttacksLeft + "[/color] ударов нанесут не менее [color=" + this.Const.UI.Color.NegativeValue + "]" + this.Const.Combat.PoisonEffectMinDamage + "[/color] урона ОЗ. Поражённые цели будут терять [color=" + this.Const.UI.Color.NegativeValue + "]10[/color] ОЗ за ход, пока эффект не рассеется.\n\nКаждый раз, когда этот эффект применяется или возобновляется, цель проходит проверку решимости.";
	}

	o.resetTime = function()
	{
		if (this.getContainer().getActor().isPlacedOnMap())
		{
			this.spawnIcon("status_effect_88", this._targetEntity.getTile());
		}

		this.m.AttacksLeft = 8;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		--this.m.AttacksLeft;
		
		if (this.m.AttacksLeft <= 0)
		{
			this.removeSelf();
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < this.Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (!_targetEntity.isAlive())
		{
			return;
		}

        if ( _targetEntity.getSkills().hasSkill("effects.second_wind"))
		{
			return;
		}

		if (_targetEntity.getFlags().has("undead"))
		{
			return;
		}

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " отравлен");
		}

		local effect = this.new("scripts/skills/effects/spider_poison_effect");
		
		if (_targetEntity.getSkills().hasSkill("effects.spider_poison"))
		{
			effect.setDamage(10);
			_targetEntity.getSkills().add(effect);
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/XP_effect"));
			_targetEntity.checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
		}
		else
		{
			effect.setDamage(10);
			_targetEntity.getSkills().add(effect);
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/XP_effect"));
		}
	}
});
::mods_hookNewObject("skills/effects/spider_poison_effect", function(o) 
{
	o.onWaitTurn = function()
	{
	}
});
::mods_hookNewObject("skills/effects/bleeding_effect", function(o) 
{
	o.onWaitTurn = function()
	{
	}
});
::mods_hookNewObject("skills/effects/goblin_poison_effect", function(o) 
{
	o.resetTime = function()
	{
		this.m.TurnsLeft = 3;

		if (this.getContainer().hasSkill("trait.ailing"))
		{
			++this.m.TurnsLeft;
		}
	}

	o.onAdded = function()
	{
		this.m.TurnsLeft = 3;

		if (this.getContainer().hasSkill("trait.ailing"))
		{
			++this.m.TurnsLeft;
		}
	}
});
::mods_hookNewObject("skills/effects/stunned_effect", function(o) 
{
	o.onAdded = function()
	{
		local statusResisted = this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses ? this.Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || this.getContainer().getActor().getCurrentProperties().IsResistantToPhysicalStatuses ? this.Math.rand(1, 100) <= 33 : false;

		if (statusResisted)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " избавляется от оглушения благодаря своей неестественной физиологии");
			}

			this.removeSelf();
		}
		else if (!this.m.Container.getActor().getCurrentProperties().IsImmuneToStun)
		{
			this.m.Container.removeByID("effects.shieldwall");
			this.m.Container.removeByID("effects.spearwall");
			this.m.Container.removeByID("effects.riposte");
			this.m.Container.removeByID("effects.ripostes");
			this.m.Container.removeByID("effects.return_favor");
			this.m.Container.removeByID("effects.possessed_undead");
		}
		else
		{
			this.m.IsGarbage = true;
		}
	}

	o.onUpdate = function( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.getCurrentProperties().IsImmuneToStun)
		{
			if (this.m.TurnsLeft != 0)
			{
				_properties.IsStunned = true;
				_properties.ActionPoints -= 30;
				
				if (actor.hasSprite("status_stunned"))
				{
					actor.getSprite("status_stunned").setBrush(this.Const.Combat.StunnedBrush);
					actor.getSprite("status_stunned").Visible = true;
				}

				actor.setDirty(true);
			}
			else
			{
				if (actor.hasSprite("status_stunned"))
				{
					actor.getSprite("status_stunned").Visible = false;
				}

				actor.setDirty(true);
			}
		}
		else
		{
			this.removeSelf();
		}
	}

});
::mods_hookNewObject("skills/effects/taunt_effect", function(o) 
{
	o.onUpdate = function( _properties )
	{
		_properties.IsRooted = true;
		_properties.InitiativeForTurnOrderAdditional -= 1000;
	}
});
::mods_hookNewObject("skills/effects/taunted_effect", function(o) 
{
	o.onUpdate = function( _properties )
	{
	    _properties.MeleeDefense -= 5;	
	    _properties.RangedDefense -= 5;	
		_properties.IsProvoke = true;
	}

	o.onTurnEnd = function()
	{
		this.removeSelf();
	}
});
::mods_hookNewObject("skills/effects/whipped_effect", function(o) 
{
o.m.TurnsLeft <- 3;
	o.onAdded = function()
	{
		this.m.TurnsLeft = 3;
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").setBrush("bust_slave_whipped");
		actor.setDirty(true);
	}

	o.onRefresh = function()
	{
		this.m.TurnsLeft = 3;
	}
});
::mods_hookNewObject("skills/effects/hex_master_effect", function(o) 
{
	o.m.DamageLater <- [];
	
	o.onDamageReceived = function( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.Slave == null || this.m.Slave.isNull() || !this.m.Slave.isAlive())
		{
			this.removeSelf();
			return;
		}

		if (_damageHitpoints > 0)
		{
			if ((_damageHitpoints - this.getContainer().getActor().getHitpoints()) <= 0)
			{
				this.m.DamageLater.append(_damageHitpoints * 0.5);
				this.m.Slave.applyDamage(_damageHitpoints * 0.5);
			}
			else
			{
				this.m.DamageLater.append((_damageHitpoints - (_damageHitpoints - this.getContainer().getActor().getHitpoints())) * 0.5);
				this.m.Slave.applyDamage((_damageHitpoints - (_damageHitpoints - this.getContainer().getActor().getHitpoints())) * 0.5);
			}
		}

		if (this.m.Slave == null || this.m.Slave.isNull() || !this.m.Slave.isAlive())
		{
			this.removeSelf();
		}
	}

	o.onTurnStart = function()
	{
		foreach(damage in this.m.DamageLater)
		{
			if (this.m.Slave != null && !this.m.Slave.isNull() && this.m.Slave.isAlive())
			{
				this.m.Slave.applyDamage(damage);
			}
		}; 
		this.m.DamageLater = [];
		
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
});
::mods_hookNewObject("skills/effects/smoke_effect", function(o) 
{
	o.getTooltip = function()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] к навыку дальнего боя"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] к навыку дальнего боя для всех, кто попытается поразить цель в облаке дыма"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Не подвержен влиянию зон контроля"
			}
		];
	}

	o.onUpdate = function( _properties )
	{
		local tile = this.getContainer().getActor().getTile();

		if (tile.Properties.Effect == null || tile.Properties.Effect.Type != "smoke")
		{
			this.removeSelf();
		}
		else
		{
			_properties.RangedSkillMult *= 0.5;
		}
	}

	o.onBeingAttacked <- function( _attacker, _skill, _properties )
	{
		local tile = this.getContainer().getActor().getTile();

		if (tile.Properties.Effect == null || tile.Properties.Effect.Type != "smoke")
		{
			this.removeSelf();
		}
		else
		{
			_properties.RangedDefense += _attacker.getCurrentProperties().getRangedSkill() * 0.5;
		}
	}
});
::mods_hookNewObject("skills/effects/goblin_grunt_potion_effect", function(o) 
{
	o.getTooltip = function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Затраты ОД на умения 'Рокировка' и 'Изворотливость' снижена до [color=" + this.Const.UI.Color.PositiveValue + "]2[/color]"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Затраты выносливости на умение 'Рокировка' уменьшены на [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Затраты выносливости на умение 'Изворотливость' уменьшены до [color=" + this.Const.UI.Color.PositiveValue + "]15[/color]"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Дальнейшие мутации приведут к более длительному периоду болезни"
			}
		];
		return ret;
	}
});
})
