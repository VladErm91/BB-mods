this.throw_sper_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0
	},
	function create()
	{
		this.m.ID = "actives.throw_sper";
		this.m.Name = "Бросок копья";
		this.m.Description = "Бросить метательное копьё в противника! Нельзя использовать в режиме ближнего боя.";
		this.m.KilledString = "Пронзён";
		this.m.Icon = "skills/active_85.png";
		this.m.IconDisabled = "skills/active_85_sw.png";
		this.m.Overlay = "active_85";
		this.m.SoundOnUse = [
			"sounds/combat/dlc2/throwing_spear_throw_01.wav",
			"sounds/combat/dlc2/throwing_spear_throw_02.wav",
			"sounds/combat/dlc2/throwing_spear_throw_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/dlc2/throwing_spear_hit_01.wav",
			"sounds/combat/dlc2/throwing_spear_hit_02.wav",
			"sounds/combat/dlc2/throwing_spear_hit_03.wav",
			"sounds/combat/dlc2/throwing_spear_hit_04.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/dlc2/throwing_spear_miss_01.wav",
			"sounds/combat/dlc2/throwing_spear_miss_02.wav",
			"sounds/combat/dlc2/throwing_spear_miss_03.wav",
			"sounds/combat/dlc2/throwing_spear_miss_04.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/dlc2/throwing_spear_hit_shield_01.wav",
			"sounds/combat/dlc2/throwing_spear_hit_shield_02.wav",
			"sounds/combat/dlc2/throwing_spear_hit_shield_03.wav",
			"sounds/combat/dlc2/throwing_spear_hit_shield_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsWeaponSkill = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.45;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 2;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.Javelin;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] клетки на равнине. Если же бросок осуществляется с возвышенности, то дальность увеличивается"
		});

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && this.getContainer().getActor().getSkills().hasSkill("perk.melee_archer"))
		{
			if (30 + this.m.AdditionalAccuracy >= 0)
			{
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (0 + this.m.AdditionalAccuracy) + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-10 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
				});
			}
			else
			{
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + (0 + this.m.AdditionalAccuracy) + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-10 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
				});
			}
		}
		else
		{
			if (30 + this.m.AdditionalAccuracy >= 0)
			{
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (30 + this.m.AdditionalAccuracy) + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-10 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
				});
			}
			else
			{
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + (30 + this.m.AdditionalAccuracy) + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-10 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
				});
			}
		}

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] копий осталось"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Копья закончились[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && !this.getContainer().getActor().getSkills().hasSkill("perk.melee_archer"))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Нельзя использовать, пока этот персонаж находится в режиме ближнего боя[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		if (this.getContainer().getActor().getSkills().hasSkill("perk.melee_archer"))
		{
			return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0;
		}
		else
		{
			return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
		}
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item == null)
		{
			return 0;
		}

		return item.getAmmo();
	}

	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item != null)
		{
			item.consumeAmmo();
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();
	}

	function onUse( _user, _targetTile )
	{
		local ret = this.attackEntity(_user, _targetTile.getEntity());
		this.consumeAmmo();
		return ret;
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
			if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
			{
				_properties.RangedSkill += -25 + this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile -= 10 + this.m.AdditionalHitChance;
			}
			else
			{
				_properties.RangedSkill += 20 + this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile -= 10 + this.m.AdditionalHitChance;			
			}
			return;
		}

		if (_skill == this)
		{
			if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
			{
				_properties.RangedSkill += -25 + this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile -= 10 + this.m.AdditionalHitChance;
			}
			else
			{
				_properties.RangedSkill += 20 + this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile -= 10 + this.m.AdditionalHitChance;			
			}
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

