this.pounds <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.pounds";
		this.m.Name = "Дистанционная отбивная";
		this.m.Description = "Вбивает противника в землю с помощью цепа издалека, поражая голову. При достаточно сильном ударе в голову, может выбить дух из противника на один ход.";
		this.m.KilledString = "Забит до смерти";
		this.m.Icon = "skills/distant_pound_orc.png";
		this.m.IconDisabled = "skills/distant_pound_orc_sw.png";
		this.m.Overlay = "distant_pound_orc";
		this.m.SoundOnUse = [
			"sounds/combat/pound_01.wav",
			"sounds/combat/pound_02.wav",
			"sounds/combat/pound_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/pound_hit_01.wav",
			"sounds/combat/pound_hit_02.wav",
			"sounds/combat/pound_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 2;
		this.m.MaxRange = 2;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 66;
	}

	function getTooltip()
	{
		local p = this.getContainer().buildPropertiesForUse(this, null);
		local damage_regular_min = this.Math.floor(p.DamageRegularMin * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_regular_max = this.Math.floor(p.DamageRegularMax * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_direct_max = this.Math.floor(damage_regular_max * (this.m.DirectDamageMult + p.DamageDirectAdd + p.DamageDirectMeleeAdd));
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
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_max + "[/color] урона здоровью, из которых [color=" + this.Const.UI.Color.DamageValue + "]0[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_direct_max + "[/color] игнорирует броню"
		});

		if (damage_Armor_max > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + damage_Armor_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_Armor_max + "[/color] урона броне"
			});
		}

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] выбить дух из цель при попадании"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]2" + "[/color] клетки"
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] к шансу на попадание"
			});
		}

		return ret;
	}

	function isUsable()
	{
		if (!this.skill.isUsable() || (!this.getContainer().getActor().isPlayerControlled() && this.getContainer().getActor().getActionPoints() == this.getContainer().getActor().getActionPointsMax()) && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			return false;
		}
		
		return true;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && target.isAlive())
		{
		}

		return success;
	}

	function onPerformAttack( _tag )
	{
		_tag.Skill.getContainer().setBusy(false);
		return _tag.Skill.attackEntity(_tag.User, _tag.TargetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
			{
				_properties.MeleeSkill += -10;
				this.m.HitChanceBonus = -10;
			}
			else
			{
				this.m.HitChanceBonus = 0;
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			return;
		}

		if (_skill == this)
		{
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


	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();
			local maxHP = _targetEntity.getHitpointsMax();
			local currentHP = _targetEntity.getHitpoints();
			local actor = this.getContainer().getActor();

			if (_bodyPart == this.Const.BodyPart.Head && !_targetEntity.getSkills().hasSkill("effects.second_wind"))
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));

				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " наносит удар, выбивая из " + this.Const.UI.getColorizedEntityName(_targetEntity) + " дух");
				}
			}

			local rd = _targetEntity.getBaseProperties().getRangedDefense();
			local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
			local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

		
			if (actor.getSkills().hasSkill("perk.crippling_strikes"))
			{
				if (currentHP < maxHP / 1.7)
				{
					if (_targetEntity.getFlags().has("undead"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
					    this.spawnIcon("injury_icon_04", _targetEntity.getTile());
				    }
				}
			}
		}
	}

});

