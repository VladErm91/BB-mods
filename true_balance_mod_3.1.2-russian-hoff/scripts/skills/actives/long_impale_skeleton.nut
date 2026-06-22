this.long_impale_skeleton <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.long_impale_skeleton";
		this.m.Name = "Вспороть живот";
		this.m.Description = "Колющая атака, которая работает на расстоянии до 3-х клеток. Может быть использована с задней линии, за пределом действия большинства оружия ближнего боя.";
		this.m.KilledString = "Пронзён";
		this.m.Icon = "skills/active_30.png";
		this.m.IconDisabled = "skills/active_30_sw.png";
		this.m.Overlay = "disembovel";
		this.m.SoundOnUse = [
			"sounds/combat/impale_01.wav",
			"sounds/combat/impale_02.wav",
			"sounds/combat/impale_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/impale_hit_01.wav",
			"sounds/combat/impale_hit_02.wav",
			"sounds/combat/impale_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsRanged = false;
		this.m.IsTooCloseShown = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.40;
		this.m.HitChanceBonus = 10;
		this.m.ActionPointCost = 18;
		this.m.FatigueCost = 20;
		this.m.MinRange = 2;
		this.m.MaxRange = 2;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] клетки"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] к шансу на попадание"
		});
		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Для использования требуется владеть мастерством древкового оружия![/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.m.Container.getActor().getCurrentProperties().IsAbleToUseWeaponSkills && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && this.getContainer().getActor().getSkills().hasSkill("actives.impale");
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectImpale);
		return this.attackEntity(_user, _targetTile.getEntity());
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
			_properties.DamageTotalMult *= 1.1;
			_properties.MeleeSkill += 5;
			return;
		}

		if (_skill == this)
		{
			_properties.DamageTotalMult *= 1.1;
			_properties.MeleeSkill += 5;
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

