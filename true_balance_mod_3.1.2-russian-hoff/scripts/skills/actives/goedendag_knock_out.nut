this.goedendag_knock_out <- this.inherit("scripts/skills/skill", {
	m = {
		StunChance = 75,
		IsFromLute = false
	},
	function setStunChance( _c )
	{
		this.m.StunChance = _c;
	}

	function create()
	{
		this.m.ID = "actives.goedendag_knock_out";
		this.m.Name = "Оглушение";
		this.m.Description = "Мощный удар, направленный на оглушение или вывод цели из строя на один ход, не наносящий при этом значительного урона. Оглушённая цель утрачивает эффекты оборонительных умений 'Стена щитов', 'Стена копий' и другие.";
		this.m.Icon = "skills/active_32.png";
		this.m.IconDisabled = "skills/active_32_sw.png";
		this.m.Overlay = "active_32";
		this.m.SoundOnUse = [
			"sounds/combat/bash_01.wav",
			"sounds/combat/bash_02.wav",
			"sounds/combat/bash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/bash_hit_01.wav",
			"sounds/combat/bash_hit_02.wav",
			"sounds/combat/bash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 50;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * 2 + "[/color] урона выносливости врага, истощая его"
		});

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] оглушить цель на один ход при попадании"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color] оглушить цель на один ход при попадании"
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInMaces ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();

			if (((_user.getCurrentProperties().IsSpecializedInMaces && this.Math.rand(0, 100) <= 100 - _targetTile.getEntity().getCurrentProperties().StunResist) || this.Math.rand(0, 100) <= (this.m.StunChance - _targetTile.getEntity().getCurrentProperties().StunResist)) && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasSkill("effects.parry") && !target.getSkills().hasSkill("effects.stunned") && !target.getSkills().hasSkill("effects.second_wind"))
			{
				target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));

				if (!target.getSkills().hasSkill("effects.antistun"))
				{
					target.getSkills().add(this.new("scripts/skills/effects/antistun_effect"));
				}
				else
				{
					target.getSkills().removeByID("effects.antistun");
					target.getSkills().add(this.new("scripts/skills/effects/antistun_effect"));
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " оглушает противника " + this.Const.UI.getColorizedEntityName(target) + " на один ход");
				}

				if (this.m.IsFromLute && _user.isPlayerControlled())
				{
					this.updateAchievement("LuteStun", 1, 1);
				}
			}
		}

		return success;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local maxHP = _targetEntity.getHitpointsMax();
			local currentHP = _targetEntity.getHitpoints();
			local actor = this.getContainer().getActor();

			if (actor.getSkills().hasSkill("perk.crippling_strikes"))
			{
				if (currentHP < maxHP / 1.7)
				{
					this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
					this.m.InjuriesOnHead = this.Const.Injury.BluntHead;

					if (_targetEntity.getFlags().has("undead"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
					    this.spawnIcon("injury_icon_04", _targetEntity.getTile());
				    }
				}
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.FatigueDealtPerHitMult += 2.0;
			return;
		}

		if (_skill == this)
		{
			_properties.FatigueDealtPerHitMult += 2.0;
			local rd = _targetEntity.getBaseProperties().getRangedDefense();
			local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
			local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				if (body < head)
				{
					_properties.HitChance[this.Const.BodyPart.Head] += rd;
				}

				if (body > head)
				{
					_properties.HitChance[this.Const.BodyPart.Head] -= rd * 0.4;
				}
			}
		}
	}

});

