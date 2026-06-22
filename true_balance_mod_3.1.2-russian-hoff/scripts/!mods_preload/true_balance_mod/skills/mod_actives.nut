::mods_registerMod("mod_actives", 1.8, "True Balance Mod Actives");
::mods_queue("mod_actives", "mod_true_balance", function() {
::mods_hookNewObject("skills/actives/aimed_shot", function(o) 
{
o.m.MinRange = 2;
o.m.ActionPointCost = 8;
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
					{
						_targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
					}	
				}
			}
		}
	}

	o.onAfterUpdate = function( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInBows ? 1 : 0);
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInBows) 
		{
			this.m.ActionPointCost = 7;
			this.m.FatigueCostMult = _properties.IsSpecializedInBows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		}

		if (!this.getContainer().getActor().isPlayerControlled())
		{
			this.m.MinRange = 6;
		}
		else
		{
			this.m.MinRange = 2;
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.RangedSkill += 10 + this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += -2 + this.m.AdditionalHitChance;
			_properties.DamageRegularMult *= 1.1;
			return;
		}

		if (_skill == this)
		{
			_properties.RangedSkill += 10 + this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += -2 + this.m.AdditionalHitChance;
			_properties.DamageRegularMult *= 1.1;
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
::mods_hookNewObject("skills/actives/pound", function(o) {
o.m.FatigueCost = 20;

	o.getTooltip = function()
	{
		local p = this.getContainer().buildPropertiesForUse(this, null);
		local damage_regular_min = this.Math.floor(p.DamageRegularMin * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_regular_max = this.Math.floor(p.DamageRegularMax * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_direct_max = this.Math.floor(damage_regular_max * (this.m.DirectDamageMult + p.DamageDirectAdd));
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
			text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_max + "[/color] урона ОЗ, из которых [color=" + this.Const.UI.Color.DamageValue + "]0[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_direct_max + "[/color] игнорируют броню"
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
			text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] выбить дух при попадании в голову"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Игнорирует бонус к защите ближнего боя от щита"
		});
		return ret;
	}

	o.onUse = function( _user, _targetTile )
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

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
			return;
		}

		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/bash", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
					{
						_targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
					}	
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
::mods_hookNewObject("skills/actives/batter_skill", function(o) 
{
	o.m.FatigueCost = 20;
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					
			
				    if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}    	
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, 10);

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
			}
			return;
		}

		if (_skill == this)
		{
			_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, 10);

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
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
::mods_hookNewObject("skills/actives/cascade_skill", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageTotalMult *= 0.33333334;
			_properties.DamageTooltipMaxMult *= 3.0;
			return;
		}

		if (_skill == this)
		{
			_properties.DamageTotalMult *= 0.33333334;
			_properties.DamageTooltipMaxMult *= 3.0;
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
::mods_hookNewObject("skills/actives/chop", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

				    if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
					}   
				}	
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.5;
			return;
		}

		if (_skill == this)
		{
			_properties.DamageAgainstMult[this.Const.BodyPart.Head] += 0.5;

			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				local rd = _targetEntity.getBaseProperties().getRangedDefense();
				local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
				local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

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
::mods_hookNewObject("skills/actives/cleave", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					
			
				    if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
					}    
				}	
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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

	o.onUse = function( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		if (success)
		{
			if (!target.isAlive() || target.isDying())
			{
				if (this.isKindOf(target, "lindwurm_tail") || !target.getCurrentProperties().IsImmuneToBleeding)
				{
					this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
				else
				{
					this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
			}
			else if (!target.getCurrentProperties().IsImmuneToBleeding && !target.getSkills().hasSkill("effects.second_wind") && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
			{
				local effect = this.new("scripts/skills/effects/bleeding_effect");
				if (_user.isPlayerControlled())
				{
					_targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/XP_effect"));
				}
				effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
				target.getSkills().add(effect);
				this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
			else
			{
				this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
		}

		return success;
	}
});
::mods_hookNewObject("skills/actives/thrust", function(o) 
{
o.m.Icon = "skills/active_04.png";
o.m.IconDisabled = "skills/active_04_sw.png";
o.m.Overlay = "active_04";
o.m.DirectDamageMult = 0.35;
o.m.HitChanceBonus = 10;
o.m.FatigueCost = 11;

	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears && main != null && (off == null || (off != null && (off.getID() == "shield.buckler" || off.getID() == "shield.goblin_light_shield" || off.getID() == "shield.goblin_heavy_shield") && this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)) && main.isDoubleGrippable())
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] к шансу на попадание"
			});
		}
		else if (main != null && (off == null || (off != null && (off.getID() == "shield.buckler" || off.getID() == "shield.goblin_light_shield" || off.getID() == "shield.goblin_heavy_shield") && this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)) && main.isDoubleGrippable())
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] к шансу на попадание"
			});		
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] к шансу на попадание"
			});			
		}
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Точность выше при двуручном хвате"
		});	
		return ret;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (_targetEntity == null && _skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears && main != null && (off == null || (off != null && (off.getID() == "shield.buckler" || off.getID() == "shield.goblin_light_shield" || off.getID() == "shield.goblin_heavy_shield") && this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)) && main.isDoubleGrippable())
			{
				_properties.MeleeSkill += 20;
			}
			else if (main != null && (off == null || (off != null && (off.getID() == "shield.buckler" || off.getID() == "shield.goblin_light_shield" || off.getID() == "shield.goblin_heavy_shield") && this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)) && main.isDoubleGrippable())
			{
				_properties.MeleeSkill += 15;			
			}
			else
			{
				_properties.MeleeSkill += 10;			
			}
			return;
		}

		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears && main != null && off == null && main.isDoubleGrippable())
			{
				_properties.MeleeSkill += 20;
			}
			else if (main != null && off == null && main.isDoubleGrippable())
			{
				_properties.MeleeSkill += 15;			
			}
			else
			{
				_properties.MeleeSkill += 10;			
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
::mods_hookNewObject("skills/actives/crumble_skill", function(o) 
{
o.m.FatigueCost = 20;

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.FatigueDealtPerHitMult += 2.0;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
			}
			return;
		}

		if (_skill == this)
		{
			_properties.FatigueDealtPerHitMult += 2.0;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					
			
				    if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
					}    
				}	
			}
		}
	}
});
::mods_hookNewObject("skills/actives/crush_armor", function(o) 
{
o.m.FatigueCost = 20;

	o.getTooltip = function()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		local f = p.IsSpecializedInHammers ? 1.73 : 1.4;
		local damage_armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * f * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * f * p.DamageTotalMult * p.MeleeDamageMult);
		local ret = this.getDefaultUtilityTooltip();

		if (damage_armor_max > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + damage_armor_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_armor_max + "[/color] урона броне"
			});
		}

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + 10 + "[/color] урона ОЗ сквозь броню"
		});
		return ret;
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageArmorMult *= this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers ? 1.73 : 1.4;
			_properties.DamageRegularMult *= 0.0;
			_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, 10);
			return;
		}

		if (_skill == this)
		{
			_properties.DamageArmorMult *= this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers ? 2.0 : 1.5;
			_properties.DamageRegularMult *= 0.0;
			_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, 10);
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
::mods_hookNewObject("skills/actives/cudgel_skill", function(o) 
{
o.m.StunChance <- 75;
o.m.FatigueCost = 20;
o.m.DirectDamageMult = 0.4;

	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * 4 + "[/color] урона выносливости врага, истощая его"
		});
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] выбить дух из противника при попадании"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color] выбить дух из противника при попадании"
			});
		}
		return ret;
	}
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
			_properties.FatigueDealtPerHitMult += 4.0;
			return;
		}

		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
			_properties.FatigueDealtPerHitMult += 4.0;

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

	o.onUse = function( _user, _targetTile )
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

			if ((_user.getCurrentProperties().IsSpecializedInMaces || this.Math.rand(1, 100) <= this.m.StunChance) && !target.getSkills().hasSkill("effects.second_wind"))
			{
				target.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " выбил дух из противника" + this.Const.UI.getColorizedEntityName(target) + " на один ход");
				}
			}
		}

		return success;
	}
});
::mods_hookNewObject("skills/actives/deathblow_skill", function(o) 
{
o.m.DirectDamageMult = 0.25;

	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Наносит на [color=" + this.Const.UI.Color.DamageValue + "]33%[/color] больше урона и игнорирует [color=" + this.Const.UI.Color.DamageValue + "]20%[/color] брони целей, которые имеют эффекты 'Выбит дух', 'Рой мошкары', 'Оглушён' или 'Пойман в сеть'"
		});
		return ret;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
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

		local targetStatus = _targetEntity.getSkills();

		if (targetStatus.hasSkill("effects.dazed") || targetStatus.hasSkill("effects.stunned") || targetStatus.hasSkill("effects.sleeping") || targetStatus.hasSkill("effects.insect_swarm") || targetStatus.hasSkill("effects.net") || targetStatus.hasSkill("effects.web") || targetStatus.hasSkill("effects.rooted"))
		{
			_properties.DamageTotalMult *= 1.33;
			_properties.DamageDirectAdd += 0.2;
		}
	}
});
::mods_hookNewObject("skills/actives/decapitate", function(o) 
{
o.m.Description = "Гибельный удар, обезглавливающий жертву. Наносит тем больше урона по здоровью, чем больше изранен противник. Убийство врага всегда срубает ему голову, если это вообще возможно, при этом велик шанс напугать других противников на расстоянии до [color=" + this.Const.UI.Color.PositiveValue + "]4-х" + "[/color] клеток.";
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageRegularMult += 1.0 - _targetEntity.getHitpoints() / (_targetEntity.getHitpointsMax() * 1.0);
			return;
		}

		if (_skill == this)
		{
			_properties.DamageRegularMult += 1.0 - _targetEntity.getHitpoints() / (_targetEntity.getHitpointsMax() * 1.0);
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
::mods_hookNewObject("skills/actives/demolish_armor_skill", function(o) 
{
o.m.FatigueCost = 35;

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageArmorMult *= this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers ? 1.93 : 1.45;
			_properties.DamageRegularMult *= 0.0;
			_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, 10);

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
			}
			return;
		}

		if (_skill == this)
		{
			_properties.DamageArmorMult *= this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers ? 1.93 : 1.45;
			_properties.DamageRegularMult *= 0.0;
			_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, 10);

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
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
::mods_hookNewObject("skills/actives/disarm_skill", function(o) 
{
o.m.HitChanceBonus = -15;
o.m.FatigueCost = 25;
	o.getTooltip = function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]3" + "[/color] клетки"
		});

		if (this.m.HitChanceBonus != 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.HitChanceBonus + "%[/color] к шансу на попадание"
			});
		}

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] обезоружить противника при попадании"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Чем тяжелее оружие, тем меньше шансов попасть"
		});
		return ret;
	}

	o.onUse = function( _user, _targetTile )
	{
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (success)
		{
			local target = _targetTile.getEntity();

			if (!target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsImmuneToDisarm)
			{
				target.getSkills().add(this.new("scripts/skills/effects/disarmed_effect"));

				if (!target.getSkills().hasSkill("effects.antidisarm"))
				{
					target.getSkills().add(this.new("scripts/skills/effects/antidisarm_effect"));
				}
				else
				{
					target.getSkills().removeByID("effects.antidisarm");
					target.getSkills().add(this.new("scripts/skills/effects/antidisarm_effect"));
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " обезоруживает противника " + this.Const.UI.getColorizedEntityName(target) + " на один ход");
				}
			}
		}

		return success;
	}

	o.onAfterUpdate = function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers)
		{
			this.m.HitChanceBonus = 0;
		}
		else
		{
			this.m.HitChanceBonus = -15;
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local fat = 0;
			local mainhand = _targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (mainhand != null)
			{
				fat = fat + mainhand.getStaminaModifier();
			}
	
	         	local bonus = this.Math.pow(this.Math.abs(fat), 1.0);

			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers)
			{
				_properties.MeleeSkill -= 15;
			}

			_properties.MeleeSkill -= bonus + _targetEntity.getCurrentProperties().DisarmResist;
			_properties.DamageTotalMult = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
		}
	}
});
::mods_hookNewObject("skills/actives/ignite_firelance_skill", function(o) 
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+40%[/color] к шансу на попадание"
		});
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Может поразить до двух целей"
		});
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс поджечь плитку тем выше, чем ниже был шанс попасть в цель."
			});
		}

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] заряд остался"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Заряды закончились[/color]"
			});
		}

		return ret;
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.RangedSkill += 40;
			_properties.DamageRegularMin = 40;
			_properties.DamageRegularMax = 60;
			_properties.DamageArmorMult = 0.9;
			_properties.DamageDirectMult = 0.2;
			if (this.getContainer().getActor().getSkills().hasSkill("perk.duelist")) 
			{
				local items = this.getContainer().getActor().getItems();
				local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

				if (off == null || off != null && off.isItemType(this.Const.Items.ItemType.Tool) || off != null && (off.getID() == "shield.goblin_light_shield" || off.getID() == "shield.goblin_heavy_shield" || off.getID() == "shield.buckler"))
				{
					_properties.DamageDirectAdd -= 0.25;
				}
			}
			return;
		}

		if (_skill == this)
		{
			_properties.RangedSkill += 40;
			_properties.DamageRegularMin = 40;
			_properties.DamageRegularMax = 60;
			_properties.DamageArmorMult = 0.9;
			_properties.DamageDirectMult = 0.2;
			if (this.getContainer().getActor().getSkills().hasSkill("perk.duelist")) 
			{
				local items = this.getContainer().getActor().getItems();
				local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

				if (off == null || off != null && off.isItemType(this.Const.Items.ItemType.Tool) || off != null && (off.getID() == "shield.goblin_light_shield" || off.getID() == "shield.goblin_heavy_shield" || off.getID() == "shield.buckler"))
				{
					_properties.DamageDirectAdd -= 0.25;
				}
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

	o.onUse = function( _user, _targetTile )
	{
		local ownTile = this.m.Container.getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
                local ht = this.Math.rand(1, 100)
		local tag = {
			User = _user,
			TargetTile = _targetTile
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedEffect.bindenv(this), tag);
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears)
		{
			this.Time.scheduleEvent(this.TimeUnit.Real, 500, this.onApply.bindenv(this), {
				Skill = this,
				User = _user,
				TargetTile = _targetTile
			});
		}
		return true;
	}

	o.onApply <- function( _data )
	{
		local user = _data.User;
        local ht = this.Math.rand(1, 100)
		local targetTile = _data.TargetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		local targets = [];
		if (targetTile.getEntity() && (ht > this.getHitchance(targetTile.getEntity())))
		{
			targets.push(_data.TargetTile);
		}
		if (!targetTile.getEntity())
		{
			targets.push(_data.TargetTile);
		}
		if (targetTile.getNextTile(dir).getEntity() && (ht > this.getHitchance(targetTile.getNextTile(dir).getEntity())))
		{
			targets.push(_data.TargetTile.getNextTile(dir));
		}
		if (!targetTile.getNextTile(dir).getEntity())
		{
			targets.push(_data.TargetTile.getNextTile(dir));
		}

		this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], 1.0, _data.TargetTile.Pos);
		local p = {
			Type = "fire",
			Tooltip = "Здесь бушует огонь, раскаляя доспехи и обугливая плоть",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _data.User.isPlayerControlled(),
			Timeout = this.Time.getRound() + 3,
			Callback = this.Const.Tactical.Common.onApplyFire,
			function Applicable( _a )
			{
				return true;
			}

		};
		local removeFireEffect = this.new("scripts/skills/effects/remove_fire_effect");
		removeFireEffect.m.FireTiles = targets;
		_data.User.getSkills().add(removeFireEffect);

		foreach( tile in targets )
		{
			if (tile.Subtype != this.Const.Tactical.TerrainSubtype.Snow && tile.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow && tile.Type != this.Const.Tactical.TerrainType.ShallowWater && tile.Type != this.Const.Tactical.TerrainType.DeepWater)
			{
				if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire")
				{
					tile.Properties.Effect.Timeout = this.Time.getRound() + 3;
				}
				else
				{
					if (tile.Properties.Effect != null)
					{
						this.Tactical.Entities.removeTileEffect(tile);
					}

					tile.Properties.Effect = clone p;
					local particles = [];

					for( local i = 0; i < this.Const.Tactical.FireParticles.len(); i = ++i )
					{
						particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.FireParticles[i].Brushes, tile, this.Const.Tactical.FireParticles[i].Delay, this.Const.Tactical.FireParticles[i].Quantity, this.Const.Tactical.FireParticles[i].LifeTimeQuantity, this.Const.Tactical.FireParticles[i].SpawnRate, this.Const.Tactical.FireParticles[i].Stages));
					}

					this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
					tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
					tile.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
			}

			if (tile.IsOccupiedByActor)
			{
				this.Const.Tactical.Common.onApplyFire(tile, tile.getEntity());
			}
		}
	}

	o.onDelayedEffect = function( _tag )
	{
		local user = _tag.User;
		local targetTile = _tag.TargetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		this.consumeAmmo();

		if (myTile.IsVisibleForPlayer)
		{
			if (user.isAlliedWithPlayer())
			{
				for( local i = 0; i < this.Const.Tactical.FireLanceRightParticles.len(); i = ++i )
				{
					local effect = this.Const.Tactical.FireLanceRightParticles[i];
					this.Tactical.spawnParticleEffect(false, effect.Brushes, myTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 0));
				}
			}
			else
			{
				for( local i = 0; i < this.Const.Tactical.FireLanceLeftParticles.len(); i = ++i )
				{
					local effect = this.Const.Tactical.FireLanceLeftParticles[i];
					this.Tactical.spawnParticleEffect(false, effect.Brushes, myTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 0));
				}
			}
		}

		local targets = [];

		if (targetTile.IsOccupiedByActor && targetTile.getEntity().isAttackable())
		{
			targets.push(targetTile.getEntity());
		}

		if (targetTile.hasNextTile(dir))
		{
			local nextTile = targetTile.getNextTile(dir);

			if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && this.Math.abs(nextTile.Level - myTile.Level) <= 1)
			{
				targets.push(nextTile.getEntity());
			}
		}

		this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], 1.0, user.getPos());
		local tag = {
			User = user,
			Targets = targets
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, this.applyEffectToTargets.bindenv(this), tag);
		return true;
	}
});
::mods_hookNewObject("skills/actives/fire_handgonne_skill", function(o) 
{
o.m.DirectDamageMult = 0.35;
o.m.MinRange = 1;

	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Может ударить до [color=" + this.Const.UI.Color.PositiveValue + "]4[/color] целей"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] клеток на равнине. При стрельбе с возвышенности дальность увеличивается на [color=" + this.Const.UI.Color.PositiveValue + "]" + (this.getMaxRange() + this.m.MaxRangeBonus) + "[/color] клетки"
		});

		if (10 + this.m.AdditionalAccuracy >= 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Имеет [color=" + this.Const.UI.Color.PositiveValue + "]+" + (10 + this.m.AdditionalAccuracy) + "%[/color] к шансу на попадание, и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-10 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели. На этот шанс не влияют объекты или персонажи на линии огня."
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Имеет [color=" + this.Const.UI.Color.NegativeValue + "]" + (10 + this.m.AdditionalAccuracy) + "%[/color] к шансу на попадание, и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-10 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели. На этот шанс не влияют объекты или персонажи на линии огня."
			});
		}

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Осталось выстрелов: [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color]"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Мешок с порохом опустел[/color]"
			});
		}

		if (!this.getItem().isLoaded())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Требуется перезарядка[/color]"
			});
		}

		return ret;
	}

	o.isUsable = function()
	{
		return this.skill.isUsable() && this.getItem().isLoaded();
	}

	o.getAffectedTiles = function( _targetTile )
	{
		local ret = [
			_targetTile
		];
		local ownTile = this.m.Container.getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local forwardTile = _targetTile.getNextTile(dir);

			if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(forwardTile);
			}
		}

		local left = dir - 1 < 0 ? 5 : dir - 1;

		if (_targetTile.hasNextTile(left))
		{
			local forwardTile = _targetTile.getNextTile(left);

			if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(forwardTile);
			}
		}

		local right = dir + 1 > 5 ? 0 : dir + 1;

		if (_targetTile.hasNextTile(right))
		{
			local forwardTile = _targetTile.getNextTile(right);

			if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(forwardTile);
			}
		}

		return ret;
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
			{
				_properties.RangedSkill += -15 + this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile += -10 + this.m.AdditionalHitChance;
			}
			else
			{
				_properties.RangedSkill += 10 + this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile += -10 + this.m.AdditionalHitChance;		
			}
			return;
		}

		if (_skill == this)
		{
			if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
			{
				_properties.RangedSkill += -15 + this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile += -10 + this.m.AdditionalHitChance;
			}
			else
			{
				_properties.RangedSkill += 10 + this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile += -10 + this.m.AdditionalHitChance;		
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
::mods_hookNewObject("skills/actives/flail_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/footwork", function(o) 
{
o.m.FatigueCost = 25;

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
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];

		if (!this.Tactical.isActive() || !this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion"))
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "В бою затраты выносливости будет равна [color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.round(this.Math.ceil(25 * this.getChance())) + "[/color]"
			});
		}

		if (this.Tactical.isActive() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Можно использовать только в зоне контроля противника[/color]"
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Нельзя использовать, пока персонаж обездвижен[/color]"
			});
		}

		return ret;
	}

	o.getChance <- function()
	{
		local chances;

		if (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion"))
		{
			chances = 0.59;
		}
		else
		{
			local initiatives = this.m.Container.getActor().getInitiative();
			local initiative = this.Math.max(10, initiatives);
	
			if (initiatives >= 100)
			{
				chances = 0.59;
			}
	
			if (initiatives < 100)
			{
				chances = 0.6 + (100 - initiative) * 0.005;
			}
	
			if (initiatives < 20)
			{
				chances = 1.0;
			}
		}
		
		local ret = chances;
		return ret;
	}

	o.onUse = function( _user, _targetTile )
	{
		if (!this.getContainer().getActor().isPlayerControlled())
		{
			this.Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
			_user.getSkills().add(this.new("scripts/skills/effects/not_lunge_effect"));
			return true;
		}
		else
		{
			this.Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
			return true;		
		}
	}

	o.onAfterUpdate = function( _properties )
	{
		if (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion"))
		{
			this.m.FatigueCostMult = 0.59;
			this.m.ActionPointCost = 2;
		}
		else if (this.Tactical.isActive())
		{
			local initiatives = this.m.Container.getActor().getInitiative();
			local initiative = this.Math.max(10, initiatives);
			local chances;
	
			if (initiatives >= 100)
			{
				chances = 0.59;
			}
	
			if (initiatives < 100)
			{
				chances = 0.6 + (100 - initiative) * 0.005;
			}
	
			if (initiatives < 20)
			{
				chances = 1.0;
			}
	
			this.m.FatigueCostMult = chances;
		}
	}
});
::mods_hookNewObject("skills/actives/gash_skill", function(o) 
{
o.m.HitChanceBonus = 5;
o.m.DirectDamageMult = 0.25;
o.m.DamageType.setWeight(::Const.Damage.DamageType.Cutting, 0);
o.m.DamageType.add(::Const.Damage.DamageType.Saber);
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] к шансу на попадание"
			}
		]);

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "На [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color] меньше повреждения необходимо для нанесения ранения"
			});
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "На [color=" + this.Const.UI.Color.NegativeValue + "]33%[/color] меньше повреждения необходимо для нанесения ранения"
			});
		}

		return ret;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					
                }

				if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul") && currentHP < maxHP / 1.3)
				{
					_targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.MeleeSkill += 5;
			return;
		}

		if (_skill == this)
		{
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
::mods_hookNewObject("skills/actives/ghoul_claws", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			return;
		}

		if (_skill == this)
		{
			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				local rd = _targetEntity.getBaseProperties().getRangedDefense();
				local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
				local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/gore_skill", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			return;
		}

		if (_skill == this)
		{
			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				local rd = _targetEntity.getBaseProperties().getRangedDefense();
				local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
				local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

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
::mods_hookNewObject("skills/actives/gorge_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageRegularMin += 80;
			_properties.DamageRegularMax += 140;
			_properties.DamageArmorMult *= 1.5;
			_properties.DamageDirectMult += 0.4;
			return;
		}

		if (_skill == this)
		{
			_properties.DamageRegularMin += 80;
			_properties.DamageRegularMax += 140;
			_properties.DamageArmorMult *= 1.5;
			_properties.DamageDirectMult += 0.4;

			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				local rd = _targetEntity.getBaseProperties().getRangedDefense();
				local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
				local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/hail_skill", function(o) 
{
o.m.FatigueCost = 20;
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] попадания по голове"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Три отдельных удара, каждый из которых наносит треть от общего урона оружия."
			}
		]);

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Игнорирует бонус к защите ближнего боя от щита"
			});
		}

		return ret;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{	
		if (_targetEntity == null && _skill == this)
		{
			_properties.HitChance[this.Const.BodyPart.Head] += 50.0;
			_properties.DamageTotalMult *= 0.33333334;
			_properties.DamageTooltipMaxMult *= 3.0;
			return;
		}

		if (_skill == this)
		{
			_properties.HitChance[this.Const.BodyPart.Head] += 50.0;
			_properties.DamageTotalMult *= 0.33333334;
			_properties.DamageTooltipMaxMult *= 3.0;
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
::mods_hookNewObject("skills/actives/hammer", function(o) 
{
o.m.FatigueCost = 12;
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{	
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, 10);
			return;
		}

		if (_skill == this)
		{
			_properties.DamageMinimum = this.Math.max(_properties.DamageMinimum, 10);
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
::mods_hookNewObject("skills/actives/hand_to_hand", function(o) 
{
o.m.FatigueCost = 16;
});
::mods_hookNewObject("skills/actives/headbutt_skill", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
::mods_hookNewObject("skills/actives/hook", function(o) 
{
o.m.KilledString <- "Раздроблён";
o.m.Order <- this.Const.SkillOrder.OffensiveTargeted;
o.m.InjuriesOnBody <- this.Const.Injury.CuttingBody;
o.m.InjuriesOnHead <- this.Const.Injury.CuttingHead;
o.m.DirectDamageMult <- 0.3;
o.m.ChanceDecapitate = 25;
o.m.ChanceDisembowel = 25;
o.m.ChanceSmash = 0;
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] клетки"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] ошеломить противника при попадании"
		});
		return ret;
	}

	o.onUse = function( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplitShield);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();

			local pullToTile = this.getPulledToTile(_user.getTile(), _targetTile);

			if (pullToTile == null)
			{
				return false;
			}

			if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
			{
				return false;
			}

			if (!_user.isHiddenToPlayer() && pullToTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " притягивает противника " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()));
			}

			local skills = _targetTile.getEntity().getSkills();

			skills.removeByID("effects.shieldwall");
			skills.removeByID("effects.spearwall");
			skills.removeByID("effects.riposte");

			if (!target.getSkills().hasSkill("effects.second_wind"))
			{
				target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
			}

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " ошеломил противника " + this.Const.UI.getColorizedEntityName(target) + " на один ход");
			}

			local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");

			if (overwhelm != null)
			{
				overwhelm.onTargetHit(this, target, this.Const.BodyPart.Body, 0, 0);
			}

			target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
			local damage = this.Math.max(0, this.Math.abs(pullToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;
			local tag = {
				Attacker = _user,
				Skill = this,
				HitInfo = clone this.Const.Tactical.HitInfo
			};

			if (damage == 0)
			{
				this.Tactical.getNavigator().teleport(_targetTile.getEntity(), pullToTile, this.onHookingComplete, tag, true);
			}
			else
			{
				tag.HitInfo.DamageRegular = damage;
				tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
				tag.HitInfo.DamageDirect = 1.0;
				tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
				this.Tactical.getNavigator().teleport(_targetTile.getEntity(), pullToTile, this.onPulledDown, tag, true);
			}

			return true;
		}

		return success;
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/horrific_scream", function(o) 
{
o.m.MaxRange = 4;
	o.onUse = function( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " использует умение 'Ужасающий крик'");
		}

		_targetTile.getEntity().checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
		_targetTile.getEntity().checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
		_targetTile.getEntity().checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
		return true;
	}
});
::mods_hookNewObject("skills/actives/throw_golem_skill", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
					{
						_targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
					}	
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
});
::mods_hookNewObject("skills/actives/hyena_bite_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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

	o.onUse = function( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		if (success && target.isAlive() && !target.isDying() && !target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
		{
			local effect = this.new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(_user.isHigh() ? 10 : 5);
			target.getSkills().add(effect);
		}

		return success;
	}
});
::mods_hookNewObject("skills/actives/impale", function(o) 
{
o.m.DirectDamageMult = 0.30;
o.m.FatigueCost = 20;

	o.onAfterUpdate = function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 5 : 6;
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && !this.getContainer().getActor().isPlayerControlled() && this.getContainer().getActor().getActionPoints() >= 8)
		{
			this.m.MaxRange = 1;
		}
		else
		{
			this.m.MaxRange = 2;
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.MeleeSkill += 10;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -5;
			}
			else
			{
				this.m.HitChanceBonus = 10;
			}
			return;
		}

		if (_skill == this)
		{
			_properties.MeleeSkill += 10;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -5;
			}
			else
			{
				this.m.HitChanceBonus = 10;
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/indomitable", function(o) 
{
o.m.SoundOnUse = [
	"sounds/combat/return_favor_01.wav"
];
o.m.ActionPointCost = 3;
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
				id = 3,
				type = "text",
				text = this.getCostString()
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
});
::mods_hookNewObject("skills/actives/knock_out", function(o) 
{
	o.onUse = function( _user, _targetTile )
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

			if (((_user.getCurrentProperties().IsSpecializedInMaces && this.Math.rand(0, 100) <= 100 - _targetTile.getEntity().getCurrentProperties().StunResist) || this.Math.rand(0, 100) <= (this.m.StunChance - _targetTile.getEntity().getCurrentProperties().StunResist)) && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasSkill("effects.stunned") && !target.getSkills().hasSkill("effects.second_wind"))
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageTotalMult *= 0.5;
			_properties.FatigueDealtPerHitMult += 2.0;
			return;
		}

		if (_skill == this)
		{
			_properties.DamageTotalMult *= 0.5;
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
::mods_hookNewObject("skills/actives/knock_over_skill", function(o) 
{
	o.onUse = function( _user, _targetTile )
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

			if (((_user.getCurrentProperties().IsSpecializedInMaces && this.Math.rand(0, 100) <= 100 - _targetTile.getEntity().getCurrentProperties().StunResist) || this.Math.rand(0, 100) <= (this.m.StunChance - _targetTile.getEntity().getCurrentProperties().StunResist)) && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasSkill("effects.stunned") && !target.getSkills().hasSkill("effects.second_wind"))
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
			}
		}

		return success;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageTotalMult *= 0.5;
			_properties.FatigueDealtPerHitMult += 2.0;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
			}
			return;
		}

		if (_skill == this)
		{
			_properties.DamageTotalMult *= 0.5;
			_properties.FatigueDealtPerHitMult += 2.0;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
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
::mods_hookNewObject("skills/actives/kraken_bite_skill", function(o) 
{
	o.onUpdate = function( _properties )
	{
		_properties.DamageRegularMin += 50;
		_properties.DamageRegularMax += 70;
		_properties.DamageArmorMult *= 1.0;
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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

	o.onUse = function( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && target.isAlive() && !target.isDying())
		{
			if (!target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
			{
				target.getSkills().add(this.new("scripts/skills/effects/bleeding_effect"));
			}
		}

		return success;
	}
});
::mods_hookNewObject("skills/actives/kraken_move_ensnared_skill", function(o) 
{
o.m.IsSpent <- true
	o.isUsable = function()
	{
		return this.m.IsUsable && !this.m.IsSpent;
	}

	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		return true;
	}

	o.onUse = function( _user, _targetTile )
	{
		this.m.IsSpent = true;
		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile,
			OnDone = this.onTeleportDone,
			OnTeleportStart = this.onTeleportStart,
			IgnoreColors = false
		};

		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " был притянут навстречу верной смерти");
		}

		if (_user.getTile().IsVisibleForPlayer)
		{
			_user.sinkIntoGround(0.75);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 800, this.onTeleportStart, tag);
		}
		else if (_targetTile.IsVisibleForPlayer)
		{
			this.onTeleportStart(tag);
		}
		else
		{
			tag.IgnoreColors = true;
			this.onTeleportStart(tag);
		}

		return true;
	}

	o.onTeleportStart = function( _tag )
	{
		if (!_tag.IgnoreColors)
		{
			_tag.User.storeSpriteColors();
			_tag.User.fadeTo(this.createColor("ffffff00"), 0);
		}

		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, _tag.OnDone, _tag, false, 1000.0);
	}

	o.onTeleportDone = function( _entity, _tag )
	{
		if (!_tag.IgnoreColors)
		{
			_entity.restoreSpriteColors();
		}

		if (!_entity.isHiddenToPlayer())
		{
			_entity.riseFromGround(0.75);
		}

		if (_tag.Skill.m.SoundOnHit.len() > 0)
		{
			this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _entity.getPos());
		}
	}

	o.onTurnStart = function()
	{
		this.m.IsSpent = true;
	}

	o.onTurnEnd = function()
	{
		this.m.IsSpent = false;
	}

	o.onWaitTurn = function()
	{
		this.m.IsSpent = false;
	}
});
::mods_hookNewObject("skills/actives/lash_skill", function(o) 
{
o.m.FatigueCost = 20;
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]+50%[/color] попадания по голове"
			}
		]);

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Игнорирует бонус к защите ближнего боя от щита"
			});
		}

		return ret;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.HitChance[this.Const.BodyPart.Head] += 50.0;
			return;
		}

		if (_skill == this)
		{
			_properties.HitChance[this.Const.BodyPart.Head] += 50.0;
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
::mods_hookNewObject("skills/actives/lunge_skill", function(o) 
{
o.m.DirectDamageMult = 0.25;

	o.isUsable = function()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted && !this.getContainer().getActor().getSkills().hasSkill("effects.not_lunge");
	}

	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local myTile = this.getContainer().getActor().getTile();
		local hasTile = false;

		for( local i = 0; i < 6; i = i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);

				if (tile.IsEmpty && tile.getDistanceTo(myTile) == 1 && this.Math.abs(myTile.Level - tile.Level) <= 1 && this.Math.abs(_targetTile.Level - tile.Level) <= 1)
				{
					hasTile = true;
					break;
				}
			}

			i = ++i;
		}

		return hasTile;
	}

	o.onUse = function( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local destTile;

		for( local i = 0; i < 6; i = i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);

				if (tile.IsEmpty && tile.getDistanceTo(myTile) == 1 && this.Math.abs(myTile.Level - tile.Level) <= 1 && this.Math.abs(_targetTile.Level - tile.Level) <= 1)
				{
					destTile = tile;
					break;
				}
			}

			i = ++i;
		}

		if (destTile == null)
		{
			return false;
		}

		this.getContainer().setBusy(true);
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};
		_user.spawnTerrainDropdownEffect(myTile);
		this.Tactical.getNavigator().teleport(_user, destTile, this.onTeleportDone.bindenv(this), tag, false, 3.0);
		return true;
	}

	o.onTeleportDone = function( _entity, _tag )
	{
		local myTile = _entity.getTile();
		local ZOC = [];
		this.getContainer().setBusy(false);

		for( local i = 0; i != 6; i = i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = myTile.getNextTile(i);

				if (!tile.IsOccupiedByActor)
				{
				}
				else
				{
					local actor = tile.getEntity();

					if (actor.isAlliedWith(_entity) || actor.getCurrentProperties().IsStunned)
					{
					}
					else
					{
						ZOC.push(actor);
					}
				}
			}
			
			i = ++i;
		}

		foreach( actor in ZOC )
		{
			if (!actor.onMovementInZoneOfControl(_entity, true))
			{
				continue;
			}

			if (actor.onAttackOfOpportunity(_entity, true))
			{
				if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " прыгает вперёд, но получает отпор");
				}

				if (!_entity.isAlive() || _entity.isDying())
				{
					return;
				}

				local dir = myTile.getDirectionTo(_tag.OldTile);

				if (myTile.hasNextTile(dir))
				{
					local tile = myTile.getNextTile(dir);

					if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1)
					{
						_tag.TargetTile = tile;
						this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
						return;
					}
				}
			}
		}

		this.spawnAttackEffect(_tag.TargetTile, this.Const.Tactical.AttackEffectThrust);
		local s = this.m.SoundOnUse;
		this.m.SoundOnUse = this.m.SoundOnAttack;
		this.attackEntity(_entity, _tag.TargetTile.getEntity());
		this.m.SoundOnUse = s;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			local a = this.getContainer().getActor();
			local s = this.Math.minf(2.0, 2.0 * (this.Math.max(0, a.getInitiative() + (_targetEntity != null ? this.getFatigueCost() : 0)) / 175.0));

			if (a.getInitiative() < 89)
			{
				_properties.DamageTotalMult *= 1;
			}
                        else
			{
				_properties.DamageTotalMult *= s;
			}

			return;
		}

		if (_skill == this)
		{
			local a = this.getContainer().getActor();
			local s = this.Math.minf(2.0, 2.0 * (this.Math.max(0, a.getInitiative() + (_targetEntity != null ? this.getFatigueCost() : 0)) / 175.0));

			if (a.getInitiative() < 89)
			{
				_properties.DamageTotalMult *= 1;
			}
                        else
			{
				_properties.DamageTotalMult *= s;
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
::mods_hookNewObject("skills/actives/overhead_strike", function(o) 
{
o.m.FatigueCost = 20;

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onUse = function( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor && this.Math.rand(1, 100) <= this.m.StunChance && !_targetTile.getEntity().getCurrentProperties().IsImmuneToStun && !_targetTile.getEntity().getSkills().hasSkill("effects.stunned"))
		{
			_targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/stunned_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " оглушает противника " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + " на один ход");
			}
		}
		if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.flame_greatsword")
		{
			this.Time.scheduleEvent(this.TimeUnit.Real, 100, this.onApply.bindenv(this), {
				Skill = this,
				User = _user,
				TargetTile = _targetTile
			});
		}

		return success;
	}

	o.onApply <- function( _data )
	{
		local user = _data.User;
		local targetTile = _data.TargetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		local targets = [];
		if (targetTile.getEntity())
		{
			targets.push(_data.TargetTile);
		}
		if (!targetTile.getEntity())
		{
			targets.push(_data.TargetTile);
		}

		local p = {
			Type = "fire",
			Tooltip = "Здесь бушует огонь, раскаляя доспехи и обугливая плоть",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _data.User.isPlayerControlled(),
			Timeout = this.Time.getRound() + 3,
			Callback = this.Const.Tactical.Common.onApplyFire,
			function Applicable( _a )
			{
				return true;
			}

		};
		local removeFireEffect = this.new("scripts/skills/effects/remove_fire_effect");
		removeFireEffect.m.FireTiles = targets;
		_data.User.getSkills().add(removeFireEffect);

		foreach( tile in targets )
		{
			if (tile.Subtype != this.Const.Tactical.TerrainSubtype.Snow && tile.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow && tile.Type != this.Const.Tactical.TerrainType.ShallowWater && tile.Type != this.Const.Tactical.TerrainType.DeepWater)
			{
				if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire")
				{
					tile.Properties.Effect.Timeout = this.Time.getRound() + 3;
				}
				else
				{
					if (tile.Properties.Effect != null)
					{
						this.Tactical.Entities.removeTileEffect(tile);
					}

					tile.Properties.Effect = clone p;
					local particles = [];

					for( local i = 0; i < this.Const.Tactical.FireParticles.len(); i = ++i )
					{
						particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.FireParticles[i].Brushes, tile, this.Const.Tactical.FireParticles[i].Delay, this.Const.Tactical.FireParticles[i].Quantity, this.Const.Tactical.FireParticles[i].LifeTimeQuantity, this.Const.Tactical.FireParticles[i].SpawnRate, this.Const.Tactical.FireParticles[i].Stages));
					}

					this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
					tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
					tile.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
			}

			if (tile.IsOccupiedByActor)
			{
				this.Const.Tactical.Common.onApplyFire(tile, tile.getEntity());
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.MeleeSkill += 5;
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
			return;
		}

		if (_skill == this)
		{
			_properties.MeleeSkill += 5;
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
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
::mods_hookNewObject("skills/actives/prong_skill", function(o) 
{
o.m.DirectDamageMult = 0.3;
o.m.FatigueCost = 20;

	o.getTooltip = function()
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
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] к шансу на попадание"
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] к шансу на попадание при атаке целей, стоящих рядом, из-за большой длины оружия"
			});
		}

		return ret;
	}

	o.onAfterUpdate = function( _properties )
	{
		if (_properties.IsSpecializedInSpears)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 5;
        }
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.MeleeSkill += 15;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = 0;
			}
			else
			{
				this.m.HitChanceBonus = 15;
			}
			return;
		}

		if (_skill == this)
		{
			_properties.MeleeSkill += 15;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = 0;
			}
			else
			{
				this.m.HitChanceBonus = 15;
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
::mods_hookNewObject("skills/actives/puncture", function(o) 
{
	o.m.DirectDamageMult = 1.0;
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] к шансу на попадание. Если цель в состоянии бегства, то этот штраф не применяется."
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Всегда наносит как минимум [color=" + this.Const.UI.Color.DamageValue + "]" + 7 + "[/color] урона ОЗ."
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Полностью игнорирует броню"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Чем меньше у цели ОЗ, тем больше будет нанесено урона. Если цель в состоянии бегства, то наносится двойной урон, исходя из базового."
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "В случае промаха, цель совершает контратаку с штрафом к шансу попадания [color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] и урону [color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color]."
			},
		]);
		return ret;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.getExpectedDamage <- function( _target )
	{
		local ret = this.skill.getExpectedDamage(_target);
		ret.HitpointDamage = this.Math.max(7, ret.HitpointDamage);
		ret.TotalDamage = this.Math.max(7, ret.TotalDamage);
		return ret;
	}
	
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.IsIgnoringArmorOnAttack = true;
			_properties.DamageTotalMult *= 0.5;
			_properties.DamageArmorMult *= 0.0;

			if (this.canDoubleGrip())
			{
				_properties.DamageTotalMult /= 1.25;
			}
			return;
		}

		if (_skill == this)
		{
			if (_targetEntity.getMoraleState() == this.Const.MoraleState.Fleeing)
			{
				_properties.MeleeSkill += 15;
			}

			if (_targetEntity.getMoraleState() != this.Const.MoraleState.Fleeing)
			{
				_properties.DamageRegularMult += 1.0 - (_targetEntity.getHitpoints() * 0.7) / (_targetEntity.getHitpointsMax() * 1.0);
			}

			if (_targetEntity.getMoraleState() != this.Const.MoraleState.Fleeing)
			{
				_properties.DamageTotalMult *= 0.5;
			}

			_properties.MeleeSkill -= 15;
			_properties.DamageArmorMult *= 0.0;
			_properties.IsIgnoringArmorOnAttack = true;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Body] = 1.0;

			if (this.canDoubleGrip())
			{
				_properties.DamageTotalMult /= 1.25;
			}
		}
	}
});
::mods_hookNewObject("skills/actives/quick_shot", function(o) 
{
o.m.MinRange = 2;
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] клеток на равнине. При стрельбе с возвышенности дальность увеличивается"
			}
		]);

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInBows)
		{
			if (this.m.AdditionalAccuracy >= 0)
			{
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.AdditionalAccuracy + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-6 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
				});
			}
			else
			{
				ret.push({
					id = 7,
					type = "text",
				icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.AdditionalAccuracy + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-6 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
				});
			}
		}
		else
		{
			if (this.m.AdditionalAccuracy >= 0)
			{
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.AdditionalAccuracy + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-4 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
				});
			}
			else
			{
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.AdditionalAccuracy + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-4 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] стрел осталось"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Требуется колчан со стрелами[/color]"
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

	o.isUsable = function()
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

	o.onAfterUpdate = function( _properties )
	{
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();
		this.m.FatigueCostMult = _properties.IsSpecializedInBows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this) 
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInBows) 
			{
				_properties.RangedSkill += this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile += -6 + this.m.AdditionalHitChance;
			}
			else
			{
				_properties.RangedSkill += this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile += -4 + this.m.AdditionalHitChance;
			}

			if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) 
			{
				_properties.RangedSkill -= 25;
			}
			return;
		}

		if (_skill == this)
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInBows) 
			{
				_properties.RangedSkill += this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile += -6 + this.m.AdditionalHitChance;
			}
			else
			{
				_properties.RangedSkill += this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile += -4 + this.m.AdditionalHitChance;
			}

			if (this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) 
			{
				_properties.RangedSkill -= 25;
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
::mods_hookNewObject("skills/actives/reap_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
			}
			return;
		}

		if (_skill == this)
		{
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/recover_skill", function(o) 
{
o.m.Name = "Глубокое восстановление";
o.m.CanRecover <- true;
o.m.Description = "Позволяет персонажу отдохнуть в течение хода, чтобы восстановить свои силы.";

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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Текущая накопленная усталость снижается на 50%"
			}
		];
		return ret;
	}

	o.onTurnStart = function()
	{
		this.m.CanRecover <- true;
	}
	
	o.onUpdate = function( _properties )
	{
		if (this.getContainer().hasSkill("effects.bersrs"))
		{
			this.m.CanRecover <- false;
		}
		else
		{	
			this.m.CanRecover <- true;
		}

	}

	o.isUsable = function()
	{
		return this.m.CanRecover;
	}

	o.onUse = function( _user, _targetTile )
	{
		_user.setFatigue(_user.getFatigue() / 2);

		if (!_user.isHiddenToPlayer())
		{
			_user.playSound(this.Const.Sound.ActorEvent.Fatigue, this.Const.Sound.Volume.Actor * _user.getSoundVolume(this.Const.Sound.ActorEvent.Fatigue));
		}

		return true;
	}
});
::mods_hookNewObject("skills/actives/repel", function(o) 
{
	o.m.SoundOnHit = [
		"sounds/combat/impale_hit_01.wav",
		"sounds/combat/impale_hit_02.wav",
		"sounds/combat/impale_hit_03.wav"
	];
	o.m.Order = this.Const.SkillOrder.OffensiveTargeted;
	o.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
	o.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
	o.m.DirectDamageMult = 0.3;
	o.m.ChanceDisembowel = 25;

	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] клетки"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] ошеломить противника при попадании"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] к шансу на попадание"
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] к шансу на попадание при атаке целей, стоящих рядом, из-за большой длины оружия"
			});
		}

		return ret;
	}

	o.findTileToKnockBackTo = function( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && knockToTile.Level - _userTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _userTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _userTile.Level <= 1)
			{
				return knockToTile;
			}
		}

		return null;
	}

	o.onAfterUpdate = function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInPolearms ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInPolearms ? 5 : 6;
	}

	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsRooted)
		{
			return false;
		}

		return true;
	}

	o.onUse = function( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectImpale);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor)
		{
		local target = _targetTile.getEntity();
		local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);

		if (knockToTile == null)
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}

			return false;
		}

		this.applyFatigueDamage(target, 10);

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}

			return false;
		}

		if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " отбрасывает противника " + this.Const.UI.getColorizedEntityName(target));
		}

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");

		if (!target.getSkills().hasSkill("effects.second_wind"))
		{
			target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
		}

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " ошеломил противника " + this.Const.UI.getColorizedEntityName(target) + " на один ход");
		}

		local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");

		if (overwhelm != null)
		{
			overwhelm.onTargetHit(this, target, this.Const.BodyPart.Body, 0, 0);
		}

		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

		if (damage == 0)
		{
			this.Tactical.getNavigator().teleport(target, knockToTile, null, null, true);
		}
		else
		{
			local p = this.getContainer().getActor().getCurrentProperties();
			local tag = {
				Attacker = _user,
				Skill = this,
				HitInfo = clone this.Const.Tactical.HitInfo,
				HitInfoBash = null
			};
			tag.HitInfo.DamageRegular = damage;
			tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
			tag.HitInfo.DamageDirect = 1.0;
			tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
			tag.HitInfo.BodyDamageMult = 1.0;
			tag.HitInfo.FatalityChanceMult = 1.0;
			this.Tactical.getNavigator().teleport(target, knockToTile, this.onKnockedDown, tag, true);
		}

		return true;
	}

		return success;
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.MeleeSkill += 10;
			_properties.DamageTotalMult *= 0.3;
			return;
		}

		if (_skill == this)
		{
			_properties.MeleeSkill += 10;
			_properties.DamageTotalMult *= 0.3;
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

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -5;
			}
			else
			{
				this.m.HitChanceBonus = 10;
			}
		}
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
					    this.spawnIcon("injury_icon_04", _targetEntity.getTile());
				    }
				}
			}
		}
	}

	o.onKnockedDown = function( _entity, _tag )
	{
		if (_tag.HitInfo.DamageRegular != 0)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
		}

		if (_tag.HitInfoBash != null)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfoBash);
		}
	}
});
::mods_hookNewObject("skills/actives/riposte", function(o) 
{
	o.onAfterUpdate = function( _properties )
	{
		if (_properties.IsSpecializedInSwords)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
		    this.m.ActionPointCost = 2;
		}
	}
});
::mods_hookNewObject("skills/actives/rotation", function(o) 
{
	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
		{
			return false;
		}

		local target = _targetTile.getEntity();
		local targets = _originTile.getEntity();

		if (!target.isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}

		if (!this.isKindOf(target, "player") && this.isKindOf(targets, "player") && target.getFaction() != this.Const.Faction.PlayerAnimals)
		{
			return false;
		}

		if (this.isKindOf(target, "player") && !this.isKindOf(targets, "player"))
		{
			return false;
		}

		return this.skill.onVerifyTarget(_originTile, _targetTile) && !target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsRooted && target.getCurrentProperties().IsMovable && !target.getCurrentProperties().IsImmuneToRotation;
	}
});
::mods_hookNewObject("skills/actives/barbarian_fury_skill", function(o) 
{
	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
		{
			return false;
		}

		local target = _targetTile.getEntity();
		local targets = _originTile.getEntity();

		if (!target.isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}

		if (!this.isKindOf(target, "player") && this.isKindOf(targets, "player") && target.getFaction() != this.Const.Faction.PlayerAnimals)
		{
			return false;
		}

		if (this.isKindOf(target, "player") && !this.isKindOf(targets, "player"))
		{
			return false;
		}

		return this.skill.onVerifyTarget(_originTile, _targetTile) && !target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsRooted && target.getCurrentProperties().IsMovable && !target.getCurrentProperties().IsImmuneToRotation;
	}
});
::mods_hookNewObject("skills/actives/round_swing", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
			{
				_properties.MeleeSkill -= 10;
			}
			else
			{
				_properties.MeleeSkill -= 15;
			}
			return;
		}

		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
			{
				_properties.MeleeSkill -= 10;
			}
			else
			{
				_properties.MeleeSkill -= 15;
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
::mods_hookNewObject("skills/actives/rupture", function(o) 
{
	o.m.FatigueCost = 17;
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.MeleeSkill += 5;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -10;
			}
			else
			{
				this.m.HitChanceBonus = 5;
			}
			return;
		}

		if (_skill == this)
		{
			_properties.MeleeSkill += 5;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -10;
			}
			else
			{
				this.m.HitChanceBonus = 5;
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

	o.onUse = function( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectImpale);
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && target.isAlive() && !target.isDying())
		{
			if (!target.getCurrentProperties().IsImmuneToBleeding && !target.getSkills().hasSkill("effects.second_wind") && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
			{
				target.getSkills().add(this.new("scripts/skills/effects/bleeding_effect"));
				this.Sound.play(this.m.BleedingSounds[this.Math.rand(0, this.m.BleedingSounds.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
		}

		return success;
	}
});
::mods_hookNewObject("skills/actives/serpent_bite_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
});
::mods_hookNewObject("skills/actives/shatter_skill", function(o) 
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] к шансу на попадание"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] к шансу на попадание"
			});
		}

		ret.extend([
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] ошеломить противника при попадании"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] отбросить противника при попадании"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Может поразить до трёх целей"
			}
		]);
		return ret;
	}

	o.findTileToKnockBackTo = function( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null)
			{
				return knockToTile;
			}
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null)
			{
				return knockToTile;
			}
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= 1 && this.m.TilesUsed.find(knockToTile.ID) == null)
			{
				return knockToTile;
			}
		}

		return null;
	}

	o.applyEffectToTarget = function( _user, _target, _targetTile )
	{
		local applyEffect = this.Math.rand(1, 3);

		if (applyEffect == 1)
		{
			return;
		}
		else if (applyEffect == 2)
		{
			if (_target.getCurrentProperties().IsImmuneToKnockBackAndGrab || _target.getCurrentProperties().IsRooted)
			{
				return;
			}

			local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);

			if (knockToTile == null)
			{
				return;
			}

			this.m.TilesUsed.push(knockToTile.ID);

			if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " отбрасывает противника " + this.Const.UI.getColorizedEntityName(_target));
			}

			local skills = _target.getSkills();
			skills.removeByID("effects.shieldwall");
			skills.removeByID("effects.spearwall");
			skills.removeByID("effects.riposte");
			_target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
			local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - _targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

			if (damage == 0)
			{
				this.Tactical.getNavigator().teleport(_target, knockToTile, null, null, true);
			}
			else
			{
				local p = this.getContainer().getActor().getCurrentProperties();
				local tag = {
					Attacker = _user,
					Skill = this,
					HitInfo = clone this.Const.Tactical.HitInfo
				};
				tag.HitInfo.DamageRegular = damage;
				tag.HitInfo.DamageDirect = 1.0;
				tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
				tag.HitInfo.BodyDamageMult = 1.0;
				tag.HitInfo.FatalityChanceMult = 1.0;
				this.Tactical.getNavigator().teleport(_target, knockToTile, this.onKnockedDown, tag, true);
			}
		}
		else
		{
			if (_target.isNonCombatant())
			{
				return;
			}

			if (!_target.getSkills().hasSkill("effects.second_wind"))
			{
				_target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
			}

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " ошеломил противника " + this.Const.UI.getColorizedEntityName(_target) + " на один ход");
			}
		}
	}

	o.onKnockedDown = function( _entity, _tag )
	{
		if (_tag.HitInfo.DamageRegular != 0)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
		}
	}

	o.onAfterUpdate = function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInHammers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onUse = function( _user, _targetTile )
	{
		this.m.TilesUsed = [];
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSwing);
		local ret = false;
		local ownTile = _user.getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		ret = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return ret;
		}

		if (ret && _targetTile.IsOccupiedByActor && _targetTile.getEntity().isAlive() && !_targetTile.getEntity().isDying())
		{
			this.applyEffectToTarget(_user, _targetTile.getEntity(), _targetTile);
		}

		local nextDir = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);
			local success = false;

			if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				success = this.attackEntity(_user, nextTile.getEntity());
			}

			if (!_user.isAlive() || _user.isDying())
			{
				return success;
			}

			if (success && nextTile.IsOccupiedByActor && nextTile.getEntity().isAlive() && !nextTile.getEntity().isDying())
			{
				this.applyEffectToTarget(_user, nextTile.getEntity(), nextTile);
			}

			ret = success || ret;
		}

		nextDir = nextDir - 1 >= 0 ? nextDir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);
			local success = false;

			if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				success = this.attackEntity(_user, nextTile.getEntity());
			}

			if (!_user.isAlive() || _user.isDying())
			{
				return success;
			}

			if (success && nextTile.IsOccupiedByActor && nextTile.getEntity().isAlive() && !nextTile.getEntity().isDying())
			{
				this.applyEffectToTarget(_user, nextTile.getEntity(), nextTile);
			}

			ret = success || ret;
		}

		this.m.TilesUsed = [];
		return ret;
	}

	o.onTargetSelected = function( _targetTile )
	{
		local ownTile = this.m.Container.getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, _targetTile, _targetTile.Pos.X, _targetTile.Pos.Y);
		local nextDir = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);

			if (this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, nextTile, nextTile.Pos.X, nextTile.Pos.Y);
			}
		}

		nextDir = nextDir - 1 >= 0 ? nextDir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);

			if (this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, nextTile, nextTile.Pos.X, nextTile.Pos.Y);
			}
		}
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers)
			{
				_properties.MeleeSkill -= 10;
			}
			else
			{
				_properties.MeleeSkill -= 5;
			}
			return;
		}

		if (_skill == this)
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers)
			{
				_properties.MeleeSkill -= 10;
			}
			else
			{
				_properties.MeleeSkill -= 5;
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
::mods_hookNewObject("skills/actives/shoot_bolt", function(o) 
{
o.m.DirectDamageMult = 0.50;
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			return;
		}

		if (_skill == this)
		{
			_properties.RangedSkill += 15 + this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile -= 3 + this.m.AdditionalHitChance;
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
::mods_hookNewObject("skills/actives/shoot_stake", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			return;
		}

		if (_skill == this)
		{
			_properties.RangedSkill += 10 + this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile -= 3 + this.m.AdditionalHitChance;
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local maxHP = _targetEntity.getHitpointsMax();
			local currentHP = _targetEntity.getHitpoints();
			local actor = this.getContainer().getActor();

			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();

			if (_targetEntity.getCurrentProperties().IsImmuneToKnockBackAndGrab || _targetEntity.getCurrentProperties().IsRooted)
			{
				return false;
			}

			local knockToTile = this.findTileToKnockBackTo(user.getTile(), targetTile);

			if (knockToTile == null)
			{
				return;
			}

			if (!user.isHiddenToPlayer() && (targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " отбрасывает противника " + this.Const.UI.getColorizedEntityName(_targetEntity));
			}

			local skills = _targetEntity.getSkills();
			skills.removeByID("effects.shieldwall");
			skills.removeByID("effects.spearwall");
			skills.removeByID("effects.riposte");
			local damage = this.Math.max(0, this.Math.abs(knockToTile.Level - targetTile.Level) - 1) * this.Const.Combat.FallingDamage;

			if (damage == 0)
			{
				this.Tactical.getNavigator().teleport(_targetEntity, knockToTile, null, null, true);
			}
			else
			{
				function onKnockedDown( _entity, _tag )
				{
					if (_tag.HitInfo.DamageRegular != 0)
					{
						_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
					}
				}
				
				local p = this.getContainer().getActor().getCurrentProperties();
				local tag = {
					Attacker = user,
					Skill = this,
					HitInfo = clone this.Const.Tactical.HitInfo,
					HitInfoBash = null
				};
				tag.HitInfo.DamageRegular = damage;
				tag.HitInfo.DamageFatigue = this.Const.Combat.FatigueReceivedPerHit;
				tag.HitInfo.DamageDirect = 1.0;
				tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
				tag.HitInfo.BodyDamageMult = 1.0;
				tag.HitInfo.FatalityChanceMult = 1.0;
				this.Tactical.getNavigator().teleport(_targetEntity, knockToTile, this.onKnockedDown, tag, true);
			}

			if (actor.getSkills().hasSkill("perk.crippling_strikes"))
			{
				if (currentHP < maxHP / 1.7)
				{
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/slash", function(o) 
{
o.m.HitChanceBonus = 5;
o.m.DirectDamageMult = 0.20;

	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] к шансу на попадание"
			}
		]);
		return ret;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.MeleeSkill += 5;
			return;
		}

		if (_skill == this)
		{
			_properties.MeleeSkill += 5;

			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				local rd = _targetEntity.getBaseProperties().getRangedDefense();
				local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
				local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

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
::mods_hookNewObject("skills/actives/slash_lightning", function(o) 
{
o.m.HitChanceBonus = 5;
o.m.DirectDamageMult = 0.20;
o.m.FatigueCost = 11;
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Наносит дополнительно [color=" + this.Const.UI.Color.DamageValue + "]10[/color] - [color=" + this.Const.UI.Color.DamageValue + "]20[/color] урона, игнорирующего броню. Поражает до трёх целей"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] к шансу на попадание"
			}
		]);
		return ret;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.MeleeSkill += 5;
			return;
		}

		if (_skill == this)
		{
			local rd = _targetEntity.getBaseProperties().getRangedDefense();
			local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
			local head = _targetEntity.getArmor(this.Const.BodyPart.Head);
			_properties.MeleeSkill += 5;

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
::mods_hookNewObject("skills/actives/sling_stone_skill", function(o) 
{
o.m.DirectDamageMult = 0.30;
o.m.ActionPointCost = 4;
o.m.FatigueCost = 15;
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] клеток на равнине. При броске с возвышенности дальность увеличивается"
			}
		]);

		if (this.m.AdditionalAccuracy == 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + (-5 + this.m.AdditionalHitChance) + "%[/color] к шансу на попадание за каждую клетку до цели"
			});
		}
		else if (this.m.AdditionalAccuracy > 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.AdditionalAccuracy + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-10 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.AdditionalAccuracy + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-10 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
			});
		}

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]100%[/color] выбить из противника дух при попадании в голову"
		});

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

	o.isUsable = function()
	{
		if (this.getContainer().getActor().getSkills().hasSkill("perk.melee_archer"))
		{
			return !this.Tactical.isActive() || this.skill.isUsable();
		}
		else
		{
			return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += -5 + this.m.AdditionalHitChance;

			if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) 
			{
				_properties.RangedSkill -= 25;
			}
			return;
		}

		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += -5 + this.m.AdditionalHitChance;

			if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) 
			{
				_properties.RangedSkill -= 25;
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();
			local maxHP = _targetEntity.getHitpointsMax();
			local currentHP = _targetEntity.getHitpoints();
			local actor = this.getContainer().getActor();

			if (_bodyPart == this.Const.BodyPart.Head)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));

				if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " нанёс удар, в результате которого из " + this.Const.UI.getColorizedEntityName(_targetEntity) + " выбит дух");
				}
			}

			if (actor.getSkills().hasSkill("perk.crippling_strikes"))
			{
				if (currentHP < maxHP / 1.7)
				{
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/smite_skill", function(o) 
{
o.m.StunChance <- 75;
o.m.FatigueCost = 20;
	o.getTooltip = function()
	{
		local p = this.getContainer().buildPropertiesForUse(this, null);
		local damage_regular_min = this.Math.floor(p.DamageRegularMin * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_regular_max = this.Math.floor(p.DamageRegularMax * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_direct_max = this.Math.floor(damage_regular_max * (this.m.DirectDamageMult + p.DamageDirectAdd));
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
			text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_max + "[/color] урона, из которых [color=" + this.Const.UI.Color.DamageValue + "]0[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_direct_max + "[/color] игнорирует броню (урон по ОЗ)."
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

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] ошеломить противника при попадании"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color] ошеломить противника при попадании"
			});
		}

		return ret;
	}

	o.onUse = function( _user, _targetTile )
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

			if ((_user.getCurrentProperties().IsSpecializedInHammers || this.Math.rand(1, 100) <= this.m.StunChance) && !target.getSkills().hasSkill("effects.second_wind"))
			{
				target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " ошеломил противника " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + " на один ход");
				}
			}
		}

		return success;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
			return;
		}

		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
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
::mods_hookNewObject("skills/actives/spider_bite_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
});
::mods_hookNewObject("skills/actives/split", function(o) 
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Может поразить до двух целей"
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] к шансу на попадание"
			});
		}

		return ret;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onUse = function( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplit);
		local ret = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return ret;
		}

		local ownTile = _user.getTile();
		local dir = ownTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local forwardTile = _targetTile.getNextTile(dir);

			if (forwardTile.IsOccupiedByActor && forwardTile.getEntity().isAttackable() && this.Math.abs(forwardTile.Level - ownTile.Level) <= 1)
			{
				ret = this.attackEntity(_user, forwardTile.getEntity()) || ret;

				if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.flame_greatsword")
				{
					this.Time.scheduleEvent(this.TimeUnit.Real, 100, this.onApply.bindenv(this), {
						Skill = this,
						User = _user,
						TargetTile = forwardTile
					});
				}
			}
			else if (this.Math.abs(forwardTile.Level - ownTile.Level) <= 1)
			{
				if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.flame_greatsword")
				{
					this.Time.scheduleEvent(this.TimeUnit.Real, 100, this.onApply.bindenv(this), {
						Skill = this,
						User = _user,
						TargetTile = forwardTile
					});
				}
			}
		}

		if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.flame_greatsword")
		{
			this.Time.scheduleEvent(this.TimeUnit.Real, 100, this.onApply.bindenv(this), {
				Skill = this,
				User = _user,
				TargetTile = _targetTile
			});
		}

		return ret;
	}

	o.onApply <- function( _data )
	{
		local user = _data.User;
		local targetTile = _data.TargetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		local targets = [];
		if (targetTile.getEntity())
		{
			targets.push(_data.TargetTile);
		}
		if (!targetTile.getEntity())
		{
			targets.push(_data.TargetTile);
		}

		local p = {
			Type = "fire",
			Tooltip = "Здесь бушует огонь, раскаляя доспехи и обугливая плоть",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _data.User.isPlayerControlled(),
			Timeout = this.Time.getRound() + 3,
			Callback = this.Const.Tactical.Common.onApplyFire,
			function Applicable( _a )
			{
				return true;
			}

		};
		local removeFireEffect = this.new("scripts/skills/effects/remove_fire_effect");
		removeFireEffect.m.FireTiles = targets;
		_data.User.getSkills().add(removeFireEffect);

		foreach( tile in targets )
		{
			if (tile.Subtype != this.Const.Tactical.TerrainSubtype.Snow && tile.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow && tile.Type != this.Const.Tactical.TerrainType.ShallowWater && tile.Type != this.Const.Tactical.TerrainType.DeepWater)
			{
				if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire")
				{
					tile.Properties.Effect.Timeout = this.Time.getRound() + 3;
				}
				else
				{
					if (tile.Properties.Effect != null)
					{
						this.Tactical.Entities.removeTileEffect(tile);
					}

					tile.Properties.Effect = clone p;
					local particles = [];

					for( local i = 0; i < this.Const.Tactical.FireParticles.len(); i = ++i )
					{
						particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.FireParticles[i].Brushes, tile, this.Const.Tactical.FireParticles[i].Delay, this.Const.Tactical.FireParticles[i].Quantity, this.Const.Tactical.FireParticles[i].LifeTimeQuantity, this.Const.Tactical.FireParticles[i].SpawnRate, this.Const.Tactical.FireParticles[i].Stages));
					}

					this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
					tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
					tile.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
			}

			if (tile.IsOccupiedByActor)
			{
				this.Const.Tactical.Common.onApplyFire(tile, tile.getEntity());
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill -= 5;
			}
			return;
		}

		if (_skill == this)
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill -= 5;
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
::mods_hookNewObject("skills/actives/split_man", function(o) 
{
o.m.FatigueCost = 20;
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this)
		{
			this.m.ApplyBonusToBodyPart = _bodyPart == this.Const.BodyPart.Body ? this.Const.BodyPart.Head : this.Const.BodyPart.Body;
		}

		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local maxHP = _targetEntity.getHitpointsMax();
			local currentHP = _targetEntity.getHitpoints();
			local actor = this.getContainer().getActor();

			if (actor.getSkills().hasSkill("perk.crippling_strikes"))
			{
				if (currentHP < maxHP / 1.7)
				{
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/split_axe", function(o) 
{
o.m.DirectDamageMult = 0.4;
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/split_shield", function(o) 
{
	o.getTooltip = function()
	{
		local damage = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage();

		if (this.m.ApplyAxeMastery && this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
		{
			damage = damage + this.Math.max(1, damage / 2);
		}

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
			id = 7,
			type = "text",
			icon = "ui/icons/shield_damage.png",
			text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + damage + "[/color] урона щиту"
		});

		if (this.m.MaxRange > 1)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "] " + this.m.MaxRange + "[/color] клетки"
			});
		}

		if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() != null)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + 5 + "[/color] урона выносливости врага, истощая его"
			});
		}

		if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() == null)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + 2 + "[/color] урона выносливости врага, истощая его"
			});
		}

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes && this.m.ApplyAxeMastery && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() != null)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] ошеломить противника, если удалось расколоть его щит"
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes && this.m.ApplyAxeMastery && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() == null)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] ошеломить противника, если удалось расколоть его щит"
			});
		}

		if (this.m.ApplyAxeMastery && this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() != null)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] ошеломить противника при попадании в щит"
			});
		}

		if (this.m.MaxRange > 1 && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] к шансу на попадание при атаке целей, стоящих рядом, из-за большой длины оружия"
			});
		}

		return ret;
	}

	o.onAfterUpdate = function( _properties )
	{
		this.m.FatigueCostMult = this.m.ApplyAxeMastery && _properties.IsSpecializedInAxes ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() != null)
		{
			this.m.ActionPointCost = 6;
		}
		else
		{
			this.m.ActionPointCost = 4;
		}
	}

	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		return _targetTile.getEntity().isArmedWithShield();
	}

	o.onUse = function( _user, _targetTile )
	{
		local shield = _targetTile.getEntity().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);

		if (shield != null)
		{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplitShield);
			local damage = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage();

			if (this.m.ApplyAxeMastery && _user.getCurrentProperties().IsSpecializedInAxes)
			{
				damage = damage + this.Math.max(1, damage / 2);
			}

			local conditionBefore = shield.getCondition();
			shield.applyShieldDamage(damage);

			if (this.m.ApplyAxeMastery && this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() != null)
			{
				_targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " ошеломил противника " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + " на один ход");
			}

			if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() != null)
			{
				_targetTile.getEntity().setFatigue(_targetTile.getEntity().getFatigue() + 5);
			}

			if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() == null)
			{
				_targetTile.getEntity().setFatigue(_targetTile.getEntity().getFatigue() + 2);
			}

			if (shield.getCondition() == 0)
			{
				if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes && this.m.ApplyAxeMastery && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() != null)
				{
					_targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
				    this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " ошеломил противника " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + " на один ход");
				}

				if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes && this.m.ApplyAxeMastery && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getBlockedSlotType() == null)
				{
					_targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
				    this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " ошеломил противника " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + " на один ход");
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " использует умение 'Раскол щита' и уничтожает щит противника " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + "");
				}
			}
			else
			{
				if (this.m.SoundOnHit.len() != 0)
				{
					this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _targetTile.getEntity().getPos());
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " использует умение 'Раскол щита' и наносит щиту противника " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + " [b]" + (conditionBefore - shield.getCondition()) + "[/b] урона");
				}
			}

			if (!this.Tactical.getNavigator().isTravelling(_targetTile.getEntity()))
			{
				this.Tactical.getShaker().shake(_targetTile.getEntity(), _user.getTile(), 2, this.Const.Combat.ShakeEffectSplitShieldColor, this.Const.Combat.ShakeEffectSplitShieldHighlight, this.Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
					"shield_icon"
				], 1.0);
			}

			local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");

			if (overwhelm != null)
			{
				overwhelm.onTargetHit(this, _targetTile.getEntity(), this.Const.BodyPart.Body, 0, 0);
			}
		}

		if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.flame_greatsword")
		{
			this.Time.scheduleEvent(this.TimeUnit.Real, 100, this.onApply.bindenv(this), {
				Skill = this,
				User = _user,
				TargetTile = _targetTile
			});
		}

		return true;
	}

	o.onApply <- function( _data )
	{
		local user = _data.User;
		local targetTile = _data.TargetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		local targets = [];
		if (targetTile.getEntity())
		{
			targets.push(_data.TargetTile);
		}
		if (!targetTile.getEntity())
		{
			targets.push(_data.TargetTile);
		}

		local p = {
			Type = "fire",
			Tooltip = "Здесь бушует огонь, раскаляя доспехи и обугливая плоть",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _data.User.isPlayerControlled(),
			Timeout = this.Time.getRound() + 3,
			Callback = this.Const.Tactical.Common.onApplyFire,
			function Applicable( _a )
			{
				return true;
			}

		};
		local removeFireEffect = this.new("scripts/skills/effects/remove_fire_effect");
		removeFireEffect.m.FireTiles = targets;
		_data.User.getSkills().add(removeFireEffect);

		foreach( tile in targets )
		{
			if (tile.Subtype != this.Const.Tactical.TerrainSubtype.Snow && tile.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow && tile.Type != this.Const.Tactical.TerrainType.ShallowWater && tile.Type != this.Const.Tactical.TerrainType.DeepWater)
			{
				if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire")
				{
					tile.Properties.Effect.Timeout = this.Time.getRound() + 3;
				}
				else
				{
					if (tile.Properties.Effect != null)
					{
						this.Tactical.Entities.removeTileEffect(tile);
					}

					tile.Properties.Effect = clone p;
					local particles = [];

					for( local i = 0; i < this.Const.Tactical.FireParticles.len(); i = ++i )
					{
						particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.FireParticles[i].Brushes, tile, this.Const.Tactical.FireParticles[i].Delay, this.Const.Tactical.FireParticles[i].Quantity, this.Const.Tactical.FireParticles[i].LifeTimeQuantity, this.Const.Tactical.FireParticles[i].SpawnRate, this.Const.Tactical.FireParticles[i].Stages));
					}

					this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
					tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
					tile.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
			}

			if (tile.IsOccupiedByActor)
			{
				this.Const.Tactical.Common.onApplyFire(tile, tile.getEntity());
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this && this.m.MaxRange > 1)
		{
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
			else
			{
				this.m.HitChanceBonus = 0;
			}
		}
	}
});
::mods_hookNewObject("skills/actives/stab", function(o) 
{
o.m.DirectDamageMult = 0.35;

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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

	o.onUse = function( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}
});
::mods_hookNewObject("skills/actives/strike_down_skill", function(o) 
{
o.m.ActionPointCost = 5;
o.m.DirectDamageMult = 0.4;
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + this.Const.Combat.FatigueReceivedPerHit * 4 + "[/color] урона выносливости врага, истощая его"
		});

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] оглушить цель при попадании"
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onUse = function( _user, _targetTile )
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
			if (((_user.getCurrentProperties().IsSpecializedInMaces && this.Math.rand(0, 100) <= 100 - _targetTile.getEntity().getCurrentProperties().StunResist) || this.Math.rand(0, 100) <= (this.m.StunChance - _targetTile.getEntity().getCurrentProperties().StunResist)) && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasSkill("effects.stunned") && !target.getSkills().hasSkill("effects.second_wind"))
			{
				local stun = this.new("scripts/skills/effects/stunned_effect");
				target.getSkills().add(stun);
				stun.setTurns(1);
				
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
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " оглушает противника " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + " на один ход");
				}
			}
		}

		return success;
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.FatigueDealtPerHitMult += 4.0;
			_properties.DamageTotalMult *= 0.75;
			return;
		}

		if (_skill == this)
		{
			_properties.FatigueDealtPerHitMult += 4.0;
			_properties.DamageTotalMult *= 0.75;
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
::mods_hookNewObject("skills/actives/strike_skill", function(o) 
{
o.m.FatigueCost = 20;
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			if (!this.m.ApplyAxeMastery)
			{
				_properties.MeleeSkill += 5;
			}

			if (_targetEntity != null && (this.m.ApplyAxeMastery && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes || !this.m.ApplyAxeMastery && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -10;
			}
			else
			{
				this.m.HitChanceBonus = this.m.ApplyAxeMastery ? 0 : 5;
			}
			return;
		}

		if (_skill == this)
		{
			if (!this.m.ApplyAxeMastery)
			{
				_properties.MeleeSkill += 5;
			}

			if (_targetEntity != null && (this.m.ApplyAxeMastery && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes || !this.m.ApplyAxeMastery && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms) && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -10;
			}
			else
			{
				this.m.HitChanceBonus = this.m.ApplyAxeMastery ? 0 : 5;
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
::mods_hookNewObject("skills/actives/sweep_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/sweep_zoc_skill", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
});
::mods_hookNewObject("skills/actives/swing", function(o) 
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Может поразить до трёх целей"
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] к шансу на попадание"
			});
		}

		return ret;
	}

	o.onUse = function( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSwing);
		local ret = false;
		local ownTile = _user.getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		ret = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return ret;
		}

		local nextDir = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);

			if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				ret = this.attackEntity(_user, nextTile.getEntity()) || ret;

				if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.flame_greatsword")
				{
					this.Time.scheduleEvent(this.TimeUnit.Real, 100, this.onApply.bindenv(this), {
						Skill = this,
						User = _user,
						TargetTile = nextTile
					});
				}
			}
			else if (this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.flame_greatsword")
				{
					this.Time.scheduleEvent(this.TimeUnit.Real, 100, this.onApply.bindenv(this), {
						Skill = this,
						User = _user,
						TargetTile = nextTile
					});
				}
			}
		}

		if (!_user.isAlive() || _user.isDying())
		{
			return ret;
		}

		nextDir = nextDir - 1 >= 0 ? nextDir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir))
		{
			local nextTile = ownTile.getNextTile(nextDir);

			if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				ret = this.attackEntity(_user, nextTile.getEntity()) || ret;

				if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.flame_greatsword")
				{
					this.Time.scheduleEvent(this.TimeUnit.Real, 100, this.onApply.bindenv(this), {
						Skill = this,
						User = _user,
						TargetTile = nextTile
					});
				}
			}
			else if (this.Math.abs(nextTile.Level - ownTile.Level) <= 1)
			{
				if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.flame_greatsword")
				{
					this.Time.scheduleEvent(this.TimeUnit.Real, 100, this.onApply.bindenv(this), {
						Skill = this,
						User = _user,
						TargetTile = nextTile
					});
				}
			}
		}

		if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.flame_greatsword")
		{
			this.Time.scheduleEvent(this.TimeUnit.Real, 100, this.onApply.bindenv(this), {
				Skill = this,
				User = _user,
				TargetTile = _targetTile
			});
		}

		return ret;
	}

	o.onApply <- function( _data )
	{
		local user = _data.User;
		local targetTile = _data.TargetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		local targets = [];
		if (targetTile.getEntity())
		{
			targets.push(_data.TargetTile);
		}
		if (!targetTile.getEntity())
		{
			targets.push(_data.TargetTile);
		}

		local p = {
			Type = "fire",
			Tooltip = "Здесь бушует огонь, раскаляя доспехи и обугливая плоть",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _data.User.isPlayerControlled(),
			Timeout = this.Time.getRound() + 3,
			Callback = this.Const.Tactical.Common.onApplyFire,
			function Applicable( _a )
			{
				return true;
			}

		};
		local removeFireEffect = this.new("scripts/skills/effects/remove_fire_effect");
		removeFireEffect.m.FireTiles = targets;
		_data.User.getSkills().add(removeFireEffect);

		foreach( tile in targets )
		{
			if (tile.Subtype != this.Const.Tactical.TerrainSubtype.Snow && tile.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow && tile.Type != this.Const.Tactical.TerrainType.ShallowWater && tile.Type != this.Const.Tactical.TerrainType.DeepWater)
			{
				if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire")
				{
					tile.Properties.Effect.Timeout = this.Time.getRound() + 3;
				}
				else
				{
					if (tile.Properties.Effect != null)
					{
						this.Tactical.Entities.removeTileEffect(tile);
					}

					tile.Properties.Effect = clone p;
					local particles = [];

					for( local i = 0; i < this.Const.Tactical.FireParticles.len(); i = ++i )
					{
						particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.FireParticles[i].Brushes, tile, this.Const.Tactical.FireParticles[i].Delay, this.Const.Tactical.FireParticles[i].Quantity, this.Const.Tactical.FireParticles[i].LifeTimeQuantity, this.Const.Tactical.FireParticles[i].SpawnRate, this.Const.Tactical.FireParticles[i].Stages));
					}

					this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
					tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
					tile.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
			}

			if (tile.IsOccupiedByActor)
			{
				this.Const.Tactical.Common.onApplyFire(tile, tile.getEntity());
			}
		}
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill -= 5;

			}
			return;
		}

		if (_skill == this)
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.MeleeSkill -= 5;

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
::mods_hookNewObject("skills/actives/tail_slam_big_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageRegularMin += 60;
			_properties.DamageRegularMax += 120;
			_properties.DamageArmorMult *= 1.5;
			_properties.DamageDirectMult += 0.5;
			return;
		}

		if (_skill == this)
		{
			_properties.DamageRegularMin += 60;
			_properties.DamageRegularMax += 120;
			_properties.DamageArmorMult *= 1.5;
			_properties.DamageDirectMult += 0.5;
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
::mods_hookNewObject("skills/actives/tail_slam_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageRegularMin += 60;
			_properties.DamageRegularMax += 120;
			_properties.DamageArmorMult *= 1.5;
			_properties.DamageDirectMult += 0.5;
			return;
		}

		if (_skill == this)
		{
			_properties.DamageRegularMin += 60;
			_properties.DamageRegularMax += 120;
			_properties.DamageArmorMult *= 1.5;
			_properties.DamageDirectMult += 0.5;
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
::mods_hookNewObject("skills/actives/tail_slam_split_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
});
::mods_hookNewObject("skills/actives/tail_slam_zoc_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.DamageRegularMin += 60;
			_properties.DamageRegularMax += 120;
			_properties.DamageArmorMult *= 1.5;
			_properties.DamageDirectMult += 0.5;
			return;
		}

		if (_skill == this)
		{
			_properties.DamageRegularMin += 60;
			_properties.DamageRegularMax += 120;
			_properties.DamageArmorMult *= 1.5;
			_properties.DamageDirectMult += 0.5;
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
::mods_hookNewObject("skills/actives/taunt", function(o) 
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Вынудит цель в следующий свой ход вступить в бой и атаковать этого персонажа, если это возможно. Обратите внимание, что цели будут продолжать придерживаться своей стратегии и далеко не всегда полезут на рожон."
			}
		];
		return ret;
	}

	o.onUse = function( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		target.getAIAgent().setForcedOpponent(_user);
		target.getSkills().add(this.new("scripts/skills/effects/taunted_effect"));
		return true;
	}
});
::mods_hookNewObject("skills/actives/charge", function(o) 
{
o.m.FatigueCost = 7;
	o.onUpdate = function( _properties )
	{
		local items = this.getContainer().getActor().getItems();
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (this.getContainer().getActor().isArmedWithMeleeWeapon())
		{
			if (main != null && items.hasBlockedSlot(this.Const.ItemSlot.Offhand))
			{
				this.m.MinRange = 2;
			}
			else
			{
				this.m.MinRange = 1;
			}
        }
	}
});
::mods_hookNewObject("skills/actives/thresh", function(o) 
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		local hitchanceBonus = this.m.HitChanceBonus;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
		{
			hitchanceBonus = hitchanceBonus + 5;
		}

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + hitchanceBonus + "%[/color] к шансу на попадание"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] выбить дух из противника при попадании в голову"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Может поразить до шести целей"
			}
		]);
		return ret;
	}

	o.onUse = function( _user, _targetTile )
	{
		local ret = false;
		local ownTile = this.m.Container.getActor().getTile();
		local soundBackup = [];
		this.spawnAttackEffect(ownTile, this.Const.Tactical.AttackEffectThresh);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					if (ret && soundBackup.len() == 0)
					{
						soundBackup = this.m.SoundOnHit;
						this.m.SoundOnHit = [];
					}

					local success = this.attackEntity(_user, tile.getEntity());
					ret = success || ret;

					if (_user.isAlive() && !_user.isDying())
					{
		
					}
				}
			}
		}

		if (ret && this.m.SoundOnHit.len() == 0)
		{
			this.m.SoundOnHit = soundBackup;
		}

		return ret;
	}

	o.onTargetSelected = function( _targetTile )
	{
		local ownTile = this.m.Container.getActor().getTile();

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, tile, tile.Pos.X, tile.Pos.Y);
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
			{
				_properties.MeleeSkill -= 10;
			}
			else
			{
				_properties.MeleeSkill -= 15;
			}
			return;
		}

		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
			{
				_properties.MeleeSkill -= 10;
			}
			else
			{
				_properties.MeleeSkill -= 15;
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " нанёс удар, в результате которого из " + this.Const.UI.getColorizedEntityName(_targetEntity) + " выбит дух");
				}
			}

			if (actor.getSkills().hasSkill("perk.crippling_strikes"))
			{
				if (currentHP < maxHP / 1.7)
				{
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/throw_axe", function(o) 
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] клеток на равнине. При метании с возвышенности дальность увеличивается"
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
				text = "Осталось топоров: [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color]"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Топоры закончились[/color]"
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

	o.isUsable = function()
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
	
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/throw_balls", function(o) 
{
o.m.ActionPointCost = 3;
o.m.MaxRange = 3;
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local maxHP = _targetEntity.getHitpointsMax();
			local currentHP = _targetEntity.getHitpoints();
			local actor = this.getContainer().getActor();

			local rd = _targetEntity.getBaseProperties().getRangedDefense();
			local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
			local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

			if (actor.getSkills().hasSkill("perk.crippling_strikes"))
			{
				if (currentHP < maxHP / 1.7)
				{
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
			{
				_properties.RangedSkill += -25;
				_properties.HitChanceAdditionalWithEachTile -= 10;
			}
			else
			{
				_properties.RangedSkill += 20;
				_properties.HitChanceAdditionalWithEachTile -= 10;			
			}
			return;
		}

		if (_skill == this)
		{
			if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
			{
				_properties.RangedSkill += -25;
				_properties.HitChanceAdditionalWithEachTile -= 10;
			}
			else
			{
				_properties.RangedSkill += 20;
				_properties.HitChanceAdditionalWithEachTile -= 10;			
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
::mods_hookNewObject("skills/actives/throw_javelin", function(o) 
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] клеток на равнине. При броске с возвышенности дальность увеличивается"
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
				text = "Осталось копий: [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color]"
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

	o.isUsable = function()
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
::mods_hookNewObject("skills/actives/throw_net", function(o) 
{
o.m.AdditionalAccuracy <- 0,
o.m.AdditionalHitChance <- 0
o.m.IsUsingHitchance = true;
o.m.IsShieldRelevant = false;
o.m.IsRanged = true;

	o.onVerifyTarget = function( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsRooted)
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsImmuneToRoot)
		{
			return false;
		}

		return true;
	}
	
	o.getTooltip = function()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] клетки"
			}
		]);

		if (30 + this.m.AdditionalAccuracy >= 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (40 + this.m.AdditionalAccuracy) + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-10 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + (40 + this.m.AdditionalAccuracy) + "%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]" + (-10 + this.m.AdditionalHitChance) + "%[/color] за каждую клетку до цели"
			});
		}

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Игнорирует штраф к точности в ночное время."
		});

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Игнорирует бонус к защите дальнего боя от щита и от эффекта 'Стена щитов'."
		});

		if(this.getContainer().getActor().getCurrentProperties().IsSpecializedInThrowing)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Препятствия не снижают вероятность попадания."
			});
		}	
		return ret;
	}

	o.onAfterUpdate = function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();
	}

	o.onUse = function( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
                local ht = this.Math.rand(1, 100)

		if (ht > this.getHitchance(_targetTile.getEntity()))
		{
			_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).drop(_targetTile);
			_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
			 this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " бросает сеть в противника " + this.Const.UI.getColorizedEntityName(targetEntity) + ", но промахивается, поэтому сеть падает на землю ");
			return false;
		}

		if (!targetEntity.getCurrentProperties().IsImmuneToRoot)
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " бросает сеть и опутывает противника " + this.Const.UI.getColorizedEntityName(targetEntity));
			_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
			_user.getItems().equip(this.new("scripts/items/tools/broken_throwing_net"));
			_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).drop(_targetTile);
			_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
			targetEntity.getSkills().add(this.new("scripts/skills/effects/net_effect"));
			local breakFree = this.new("scripts/skills/actives/break_free_skill");
			breakFree.m.Icon = "skills/active_74.png";
			breakFree.m.IconDisabled = "skills/active_74_sw.png";
			breakFree.m.Overlay = "active_74";
			breakFree.m.SoundOnUse = this.m.SoundOnHitHitpoints;

			if (this.m.IsReinforced)
			{
				breakFree.setDecal("net_destroyed_02");
				breakFree.setChanceBonus(-15);
			}
			else
			{
				breakFree.setDecal("net_destroyed");
				breakFree.setChanceBonus(0);
			}

			targetEntity.getSkills().add(breakFree);
			local effect = this.Tactical.spawnSpriteEffect(this.m.IsReinforced ? "bust_net_02" : "bust_net", this.createColor("#ffffff"), _targetTile, 0, 10, 1.0, targetEntity.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !targetEntity.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), {
				TargetEntity = targetEntity,
				IsReinforced = this.m.IsReinforced
			});
		}
		else
		{
			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, targetEntity.getPos());
			}

			 this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " бросает сеть, но цель " + this.Const.UI.getColorizedEntityName(targetEntity) + " невосприимчива к захвату, поэтому сеть падает на землю ");
			_user.getItems().unequip(_user.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
			return false;
		}

	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (this.getContainer().getActor().getSkills().hasSkill("special.night"))
			{
				_properties.RangedSkillMult *= 1.428571428571429;
			}
			
			if(this.getContainer().getActor().getCurrentProperties().IsSpecializedInThrowing)
			{
				_properties.RangedAttackBlockedChanceMult *= 0.0;
			}
			
			local shield = _targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield) && _targetEntity.getSkills().hasSkill("effects.shieldwall"))
			{
				local shieldBonus = (this.m.IsRanged ? shield.getRangedDefense() : shield.getMeleeDefense()) * (_targetEntity.getCurrentProperties().IsSpecializedInShields ? 1.25 : 1.0);

				_properties.RangedSkill += 40 + shieldBonus + this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile += -10 + this.m.AdditionalHitChance;
			}
			else
			{
				_properties.RangedSkill += 40 + this.m.AdditionalAccuracy;
				_properties.HitChanceAdditionalWithEachTile += -10 + this.m.AdditionalHitChance;}
			return;
		}
	}

	o.onNetSpawn = function( _data )
	{
		local rooted = _data.TargetEntity.getSprite("status_rooted");
		rooted.setBrush(_data.IsReinforced ? "bust_net_02" : "bust_net");
		rooted.Visible = true;
		local rooted_back = _data.TargetEntity.getSprite("status_rooted_back");
		rooted_back.setBrush(_data.IsReinforced ? "bust_net_back_02" : "bust_net_back");
		rooted_back.Visible = true;
		_data.TargetEntity.setDirty(true);
	}

	o.getHitFactors = function( _targetTile )
	{
		local ret = [];
		local user = this.m.Container.getActor();
		local myTile = user.getTile();
		local targetEntity = _targetTile.IsOccupiedByActor ? _targetTile.getEntity() : null;

		if (this.m.HitChanceBonus > 0)
		{
			ret.push({
				icon = "ui/tooltips/positive.png",
				text = this.getName()
			});
		}

		if (!this.m.IsRanged && targetEntity != null && targetEntity.getSurroundedCount() != 0)
		{
			ret.push({
				icon = "ui/tooltips/positive.png",
				text = "Цель окружена"
			});
		}

		if (_targetTile.IsOccupiedByActor && targetEntity.getSkills().hasSkill("effects.smoke") && this.m.IsRanged)
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Цель в дыму"
			});
		}

		if (_targetTile.Level < this.m.Container.getActor().getTile().Level)
		{
			ret.push({
				icon = "ui/tooltips/positive.png",
				text = "Цель находится ниже"
			});
		}

		if (_targetTile.IsBadTerrain)
		{
			ret.push({
				icon = "ui/tooltips/positive.png",
				text = "Труднопроходимая местность"
			});
		}

		if (this.m.IsAttack)
		{
			local fast_adaption = this.m.Container.getSkillByID("perk.fast_adaption");

			if (fast_adaption != null && fast_adaption.isBonusActive())
			{
				ret.push({
					icon = "ui/tooltips/positive.png",
					text = "Быстрая адаптация"
				});
			}
		}

		if (this.m.IsTooCloseShown && this.m.HitChanceBonus < 0)
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Слишком близко"
			});
		}
		else if (this.m.HitChanceBonus < 0)
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = this.getName()
			});
		}

		if (_targetTile.Level > myTile.Level)
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Цель находится выше"
			});
		}

		if (myTile.IsBadTerrain)
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Труднопроходимая местность"
			});
		}

		if (this.m.IsShieldRelevant)
		{
			if (_targetTile.IsOccupiedByActor && targetEntity.isArmedWithShield())
			{
				ret.push({
					icon = "ui/tooltips/negative.png",
					text = "Вооружён щитом"
				});
			}
		}

		if (this.m.IsShieldwallRelevant)
		{
			if (_targetTile.IsOccupiedByActor && targetEntity.getSkills().hasSkill("effects.shieldwall"))
			{
				ret.push({
					icon = "ui/tooltips/negative.png",
					text = "Стена щитов"
				});
			}
		}

		if (_targetTile.IsOccupiedByActor && myTile.getDistanceTo(_targetTile) <= 1 && targetEntity.getSkills().hasSkill("effects.riposte"))
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Контратака"
			});
		}

		if (this.m.IsRanged && myTile.getDistanceTo(_targetTile) > 1)
		{
			if (_targetTile.IsOccupiedByActor)
			{
				ret.push({
					icon = "ui/tooltips/negative.png",
					text = "Клеток до цели: " + _targetTile.getDistanceTo(user.getTile())
				});
			}

			if (this.m.IsUsingHitchance)
			{
				local blockedTiles = this.Const.Tactical.Common.getBlockedTiles(myTile, _targetTile, user.getFaction(), true);

				if (blockedTiles.len() == 0 || (this.m.ID == "actives.throw_net" && this.getContainer().getActor().getCurrentProperties().IsSpecializedInThrowing))
				{
				}
				else
				{
					ret.push({
						icon = "ui/tooltips/negative.png",
						text = "Линия стрельбы заблокирована"
					});
				}
			}
		}

		if (this.m.IsAttack && _targetTile.IsOccupiedByActor && (targetEntity.getFlags().has("skeleton") || targetEntity.getSkills().hasSkill("racial.golem")))
		{
			if (this.m.IsRanged)
			{
				ret.push({
					icon = "ui/tooltips/negative.png",
					text = "Сопротивление против оружия дальнего боя"
				});
			}
			else if (this.m.ID == "actives.puncture" || this.m.ID == "actives.thrust" || this.m.ID == "actives.stab" || this.m.ID == "actives.deathblow" || this.m.ID == "actives.impale" || this.m.ID == "actives.rupture" || this.m.ID == "actives.prong" || this.m.ID == "actives.lunge")
			{
				ret.push({
					icon = "ui/tooltips/negative.png",
					text = "Сопротивление пробивающим атакам"
				});
			}
		}

		if (_targetTile.IsOccupiedByActor && targetEntity.getCurrentProperties().IsImmuneToStun && (this.m.ID == "actives.knock_out" || this.m.ID == "actives.knock_over" || this.m.ID == "actives.strike_down"))
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Сопротивление пробивающим атакам"
			});
		}

		if (_targetTile.IsOccupiedByActor && targetEntity.getCurrentProperties().IsImmuneToRoot && this.m.ID == "actives.throw_net")
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Невосприимчив к обездвиживанию"
			});
		}

		if (_targetTile.IsOccupiedByActor && (targetEntity.getCurrentProperties().IsImmuneToDisarm || targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) == null) && this.m.ID == "actives.disarm")
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Невосприимчив к разоружению"
			});
		}

		if (_targetTile.IsOccupiedByActor && targetEntity.getCurrentProperties().IsImmuneToKnockBackAndGrab && (this.m.ID == "actives.knock_back" || this.m.ID == "actives.hook" || this.m.ID == "actives.repel"))
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Невосприимчив к отталкиванию и притягиванию"
			});
		}

		if (this.m.IsRanged && user.getCurrentProperties().IsAffectedByNight && user.getSkills().hasSkill("special.night"))
		{
			ret.push({
				icon = "ui/tooltips/negative.png",
				text = "Ночное время"
			});
		}

		return ret;
	}

	o.onTargetSelected = function( _targetTile )
	{
		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInThrowing)
		{
			local userTile = this.m.Container.getActor().getTile();

			if (this.m.IsRanged && userTile.getDistanceTo(_targetTile) > 1)
			{
				local blockedTiles = this.Const.Tactical.Common.getBlockedTiles(userTile, _targetTile, 	this.m.Container.getActor().getFaction(), true);

				foreach( tile in blockedTiles )
				{
					this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.RangedSkillBlockedIcon, tile, tile.Pos.X, tile.Pos.Y);
				}
			}
		}
		else
		{
		}
	}
});
::mods_hookNewObject("skills/actives/throw_spear_skill", function(o) 
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		local damage = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/shield_damage.png",
			text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]" + damage + "[/color] урона щиту"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Имеет дальность в [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getMaxRange() + "[/color] клетки на равнине. Если же бросок осуществляется с возвышенности, то дальность увеличивается"
		});
		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && this.getContainer().getActor().getSkills().hasSkill("perk.melee_archer"))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+30%[/color] к шансу на попадание и [color=" + 	this.Const.UI.Color.NegativeValue + "]-10%[/color] за каждую клетку до цели"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+30%[/color] к шансу на попадание и [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] за каждую клетку до цели"
			});
		}
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Шанс [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] уменьшить на один ход защиту в ближнем и дальнем бою на [color=" + this.Const.UI.Color.PositiveValue + "]10[/color] при попадании в щит"
		});

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && !this.getContainer().getActor().getSkills().hasSkill("perk.melee_archer"))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Нельзя использовать, пока этот персонаж находится в режиме ближнего боя[/color]"
			});
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

		return ret;
	}

	o.isUsable = function()
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

	o.getAmmo = function()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item == null)
		{
			return 0;
		}

		return item.getAmmo();
	}

	o.consumeAmmo = function()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item != null)
		{
			item.consumeAmmo();
		}
	}

	o.onAfterUpdate = function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	o.onUse = function( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		this.consumeAmmo();
		local shield = targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield))
		{
			local target = _targetTile.getEntity();
			target.getSkills().add(this.new("scripts/skills/effects/stagered_effect"));
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " выбил дух из противника " + this.Const.UI.getColorizedEntityName(target) + " на один ход");
			local flip = !this.m.IsProjectileRotated && targetEntity.getPos().X > _user.getPos().X;
			local time = this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, time, this.onApplyShieldDamage.bindenv(this), {
				User = _user,
				Skill = this,
				TargetTile = _targetTile,
				Shield = shield,
				Damage = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage()
			});
		}
		else
		{
			local ret = this.attackEntity(_user, _targetTile.getEntity());
		}

		return true;
	}

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
			{
				_properties.RangedSkill += -25;
				_properties.HitChanceAdditionalWithEachTile -= 10;
			}
			else
			{
				_properties.RangedSkill += 20;
				_properties.HitChanceAdditionalWithEachTile -= 10;			
			}
			return;
		}

		if (_skill == this)
		{
			if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
			{
				_properties.RangedSkill += -25;
				_properties.HitChanceAdditionalWithEachTile -= 10;
			}
			else
			{
				_properties.RangedSkill += 20;
				_properties.HitChanceAdditionalWithEachTile -= 10;			
			}

			if (_targetEntity != null)
			{
				local shield = _targetEntity.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

				if (shield != null && shield.isItemType(this.Const.Items.ItemType.Shield))
				{
					this.m.IsUsingHitchance = false;
				}
				else
				{
					this.m.IsUsingHitchance = true;
				}
			}
			else
			{
				this.m.IsUsingHitchance = true;
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

	o.onApplyShieldDamage = function( _tag )
	{
		local conditionBefore = _tag.Shield.getCondition();
		_tag.Shield.applyShieldDamage(_tag.Damage);

		if (_tag.Shield.getCondition() == 0)
		{
			if (!_tag.User.isHiddenToPlayer() && _tag.TargetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_tag.User) + " уничтожает [color=#333333]щит[/color] персонажа " + this.Const.UI.getColorizedEntityName(_tag.TargetTile.getEntity()) + ".");
			}
		}
		else
		{
			if (!_tag.User.isHiddenToPlayer() && _tag.TargetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log("[color=#333333]Щит[/color] персонажа " + this.Const.UI.getColorizedEntityName(_tag.TargetTile.getEntity()) + " получает [color=#333333]" + (conditionBefore - _tag.Shield.getCondition()) + "[/color] урона.");
			}

			if (_tag.Skill.m.SoundOnHitShield.len() != 0)
			{
				this.Sound.play(_tag.Skill.m.SoundOnHitShield[this.Math.rand(0, _tag.Skill.m.SoundOnHitShield.len() - 1)], this.Const.Sound.Volume.Skill, _tag.TargetTile.getEntity().getPos());
			}
		}

		if (!this.Tactical.getNavigator().isTravelling(_tag.TargetTile.getEntity()))
		{
			this.Tactical.getShaker().shake(_tag.TargetTile.getEntity(), _tag.User.getTile(), 2, this.Const.Combat.ShakeEffectSplitShieldColor, this.Const.Combat.ShakeEffectSplitShieldHighlight, this.Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
				"shield_icon"
			], 1.0);
		}
	}
});
::mods_hookNewObject("skills/actives/uproot_skill", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
});
::mods_hookNewObject("skills/actives/uproot_small_skill", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
});
::mods_hookNewObject("skills/actives/uproot_small_zoc_skill", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
});
::mods_hookNewObject("skills/actives/uproot_zoc_skill", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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
});
::mods_hookNewObject("skills/actives/wardog_bite", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			return;
		}

		if (_skill == this)
		{
			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				local rd = _targetEntity.getBaseProperties().getRangedDefense();
				local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
				local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/warhound_bite", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			return;
		}

		if (_skill == this)
		{
			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				local rd = _targetEntity.getBaseProperties().getRangedDefense();
				local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
				local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/werewolf_bite", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			return;
		}

		if (_skill == this)
		{
			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				local rd = _targetEntity.getBaseProperties().getRangedDefense();
				local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
				local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/whip_skill", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));;
				    }
				}
			}
		}
	}

	o.onUse = function( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		if (success && !_targetTile.IsEmpty)
		{
			if (!target.isAlive() || target.isDying())
			{
				if (this.isKindOf(target, "lindwurm_tail") || !target.getCurrentProperties().IsImmuneToBleeding)
				{
					this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
				else
				{
					this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
			}
			else if (!target.getCurrentProperties().IsImmuneToBleeding && !target.getSkills().hasSkill("effects.second_wind") && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
			{
				local effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
				target.getSkills().add(effect);
				if (_user.isPlayerControlled())
				{
					_targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/XP_effect"));
				}
				effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
				target.getSkills().add(effect);
				this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
			else
			{
				this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
		}

		return success;
	}
});
::mods_hookNewObject("skills/actives/whip_slave_skill", function(o) 
{
o.m.ActionPointCost = 3;
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]1[/color] - [color=" + this.Const.UI.Color.DamageValue + "]3[/color] урона ОЗ сквозь броню"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Даёт выбранному непрощённому эффект 'Подстёгнут', увеличивая его характеристики на 3 хода. Чем выше уровень персонажа, использующего этот навык, тем выше прирост"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Поднимает боевой дух непрощённого до уровня 'устойчивый', если он был ниже"
			}
		];
		return ret;
	}
});
::mods_hookNewObject("skills/actives/wolf_bite", function(o) 
{
	o.onUpdate = function( _properties )
	{
		if (this.isUsable())
		{
			_properties.DamageRegularMin += 30;
			_properties.DamageRegularMax += 40;
			_properties.DamageArmorMult *= 0.7;
		}

		if (this.m.IsRestrained && this.isUsable())
		{
			_properties.DamageRegularMin = 30;
			_properties.DamageRegularMax = 40;
			_properties.DamageArmorMult = 0.7;
		}
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			return;
		}

		if (_skill == this)
		{
			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				local rd = _targetEntity.getBaseProperties().getRangedDefense();
				local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
				local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					

					if (_targetEntity.getFlags().has("undead") && !_targetEntity.getSkills().hasSkill("racial.ghoul"))
				    {
					    _targetEntity.getSkills().add(this.new("scripts/skills/effects/broken_bones_effect"));
				    }
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/zombie_bite", function(o) 
{
	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			return;
		}

		if (_skill == this)
		{
			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				local rd = _targetEntity.getBaseProperties().getRangedDefense();
				local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
				local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

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

	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
					
					
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/adrenaline_skill", function(o) 
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "В следующем ходу персонаж будет действовать раньше."
			}
		];
		return ret;
	}
});
::mods_hookNewObject("skills/actives/drink_antidote_skill", function(o) 
{
	o.onUse = function( _user, _targetTile )
	{
		local user = _targetTile.getEntity();
		this.spawnIcon("status_effect_97", _targetTile);

		if (_user.getID() == user.getID())
		{
			while (user.getSkills().hasSkill("effects.goblin_poison"))
			{
				user.getSkills().removeByID("effects.goblin_poison");
			}

			while (user.getSkills().hasSkill("effects.spider_poison"))
			{
				user.getSkills().removeByID("effects.spider_poison");
			}

			user.getSkills().add(this.new("scripts/skills/effects/antidote_effect"));

			if (!user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " выпивает противоядие");
			}

			if (this.m.Item != null && !this.m.Item.isNull())
			{
				this.m.Item.removeSelf();
			}

			this.Const.Tactical.Common.checkDrugEffect(user);
		}
		else
		{
			if (!_user.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " передаёт противоядие персонажу " + this.Const.UI.getColorizedEntityName(user));
			}

			this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
			local item = this.m.Item.get();
			_user.getItems().removeFromBag(item);
			user.getItems().addToBag(item);
		}

		return true;
	}
});
::mods_hookNewObject("skills/actives/lightning_storm_skill", function(o) 
{
	o.onImpact = function( _tag )
	{
		this.Tactical.EventLog.log("Молния ударяет в поле боя");
		this.Tactical.getCamera().quake(this.createVec(0, -1.0), 6.0, 0.16, 0.35);
		local actor = this.getContainer().getActor();

		foreach( i, t in _tag.m.AffectedTiles )
		{
			this.Time.scheduleEvent(this.TimeUnit.Real, i * 30, function ( _data )
			{
				local tile = _data.Tile;

				for( local i = 0; i < this.Const.Tactical.LightningParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(true, this.Const.Tactical.LightningParticles[i].Brushes, tile, this.Const.Tactical.LightningParticles[i].Delay, this.Const.Tactical.LightningParticles[i].Quantity, this.Const.Tactical.LightningParticles[i].LifeTimeQuantity, this.Const.Tactical.LightningParticles[i].SpawnRate, this.Const.Tactical.LightningParticles[i].Stages);
				}

				tile.clear(this.Const.Tactical.DetailFlag.SpecialOverlay);
				tile.Properties.IsMarkedForImpact = false;

				if ((tile.IsEmpty || tile.IsOccupiedByActor) && tile.Type != this.Const.Tactical.TerrainType.ShallowWater && tile.Type != this.Const.Tactical.TerrainType.DeepWater)
				{
					tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
					tile.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
				}

				if (tile.IsOccupiedByActor && !_data.User.isAlliedWith(tile.getEntity()))
				{
					local target = tile.getEntity();
					local hitInfo = clone this.Const.Tactical.HitInfo;
					hitInfo.DamageRegular = this.Math.rand(30, 40);
					hitInfo.DamageArmor = hitInfo.DamageRegular * 1.0;
					hitInfo.DamageDirect = 0.75;
					hitInfo.BodyPart = this.Const.BodyPart.Body;
					hitInfo.FatalityChanceMult = 0.0;
					hitInfo.Injuries = this.Const.Injury.BurningBody;
					target.onDamageReceived(_data.User, _data.Skill, hitInfo);
					local target = tile.getEntity();
					local hitInfo = clone this.Const.Tactical.HitInfo;
					hitInfo.DamageRegular = this.Math.rand(15, 20);
					hitInfo.DamageArmor = hitInfo.DamageRegular * 1.0;
					hitInfo.DamageDirect = 0.75;
					hitInfo.BodyPart = this.Const.BodyPart.Head;
					hitInfo.FatalityChanceMult = 0.0;
					hitInfo.Injuries = this.Const.Injury.BurningBody;
					target.onDamageReceived(_data.User, _data.Skill, hitInfo);
				}
			}, {
				Tile = t,
				Skill = this,
				User = actor
			});
		}

		_tag.m.AffectedTiles = [];

		if (_tag.m.HasCooldownAfterImpact)
		{
			_tag.m.Cooldown = 1;
		}

		this.Tactical.Entities.getFlags().set("LightningStrikesActive", this.Math.max(0, this.Tactical.Entities.getFlags().getAsInt("LightningStrikesActive") - 1));
	}
});
::mods_hookNewObject("skills/actives/kraken_devour_skill", function(o) 
{
o.m.IsAttack = true;
});
::mods_hookNewObject("skills/actives/charm_skill", function(o) 
{
	o.onDelayedEffect = function( _tag )
	{
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;
		local target = _targetTile.getEntity();
		local time = this.Tactical.spawnProjectileEffect("effect_heart_01", _user.getTile(), _targetTile, 0.33, 2.0, false, false);
		local self = this;
		this.Time.scheduleEvent(this.TimeUnit.Virtual, time, function ( _e )
		{
			local bonus = _targetTile.getDistanceTo(_user.getTile()) == 1 ? -5 : 0;

			if (target.checkMorale(0, -35 + bonus, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " сопротивляется очарованию благодаря своей решимости");
				}

				return false;
			}

			if (target.checkMorale(0, -35 + bonus, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " сопротивляется очарованию благодаря своей решимости");
				}

				return false;
			}

			this.m.Slaves.push(target.getID());
			local charmed = this.new("scripts/skills/effects/charmed_effect");
			charmed.setMasterFaction(_user.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : _user.getFaction());
			charmed.setMaster(self);
			target.getSkills().add(charmed);
			target.getSkills().add(this.new("scripts/skills/effects/witch_distracted_effect"));

			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " очарован Ведьмой");
			}

			_user.setCharming(true);
		}.bindenv(this), this);
	}
});
::mods_hookNewObject("skills/actives/reload_handgonne_skill", function(o) 
{
o.m.Spent <- false;
o.m.ActionPointCost = 6;
	o.getTooltip = function()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
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
		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Осталось зарядов: [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color]"
			});
		}
		else
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Не осталось пороха в пороховнице[/color]"
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

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && this.getContainer().getActor().getSkills().hasSkill("perk.melee_archer"))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Перезарядка спровоцирует атаку рядом стоящего врага![/color]"
			});
		}

		return ret;
	}

	o.onUse = function( _user, _targetTile )
	{
		this.consumeAmmo();
		this.getItem().setLoaded(true);
		this.getContainer().remove(this);
		if (_user.getSkills().hasSkill("perk.melee_archer"))
		{
			for( local i = 0; i != 6; i = ++i )
			{
				if (!_user.getTile().hasNextTile(i))
				{
				}
				else
				{
					local tile = _user.getTile().getNextTile(i);
					if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - _user.getTile().Level) <= 1 && !this.m.Spent)
					{
						local attacker = tile.getEntity();
						if (attacker.getSkills().getAttackOfOpportunity() != null)
						{
							local skill = attacker.getSkills().getAttackOfOpportunity();
							attacker.getSkills().add(this.new("scripts/skills/effects/counterattack_effect"));
							skill.useForFree(_user.getTile())
							this.m.Spent = true;
						}
					}
				}
			}
		}
		return true;
	}
	
	o.isUsable = function()
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

	o.onAfterUpdate = function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCrossbows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}
});
::mods_hookNewObject("skills/actives/reload_bolt", function(o) 
{
o.m.Spent <- false;
	o.getTooltip = function()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
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
		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Осталось болтов: [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color]"
			});
		}
		else
		{
			ret.push({
				id = 4,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Колчан опустел[/color]"
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

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && this.getContainer().getActor().getSkills().hasSkill("perk.melee_archer"))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Перезарядка спровоцирует атаку рядом стоящего врага![/color]"
			});
		}

		return ret;
	}

	o.onUse = function( _user, _targetTile )
	{
		this.consumeAmmo();
		this.getItem().setLoaded(true);
		this.getContainer().remove(this);
		if (_user.getSkills().hasSkill("perk.melee_archer"))
		{
			for( local i = 0; i != 6; i = ++i )
			{
				if (!_user.getTile().hasNextTile(i))
				{
				}
				else
				{
					local tile = _user.getTile().getNextTile(i);
					if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - _user.getTile().Level) <= 1 && !this.m.Spent)
					{
						local attacker = tile.getEntity();
						if (attacker.getSkills().getAttackOfOpportunity() != null)
						{
							local skill = attacker.getSkills().getAttackOfOpportunity();
							attacker.getSkills().add(this.new("scripts/skills/effects/counterattack_effect"));
							skill.useForFree(_user.getTile())
							this.m.Spent = true;
						}
					}
				}
			}
		}
		return true;
	}

	o.isUsable = function()
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

	o.onAfterUpdate = function( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCrossbows ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}
});
::mods_hookNewObject("skills/actives/throw_smoke_bomb_skill", function(o) 
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Покрывает [color=" + this.Const.UI.Color.DamageValue + "]7[/color] плиток дымом на один ход, позволяя всем внутри облака свободно перемещаться, игнорируя зоны контроля"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Снижает навык дальнего боя пытающимся поразить цель в облаке дыма на [color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color], аналогично снижает на [color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] навык дальнего боя всем, кто находится внутри облака"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Убирает эффекты с клеток, такие как огонь или миазмы"
		});
		return ret;
	}

	o.onApply = function( _data )
	{
		local targets = [];
		targets.push(_data.TargetTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_data.TargetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _data.TargetTile.getNextTile(i);
				targets.push(tile);
			}
		}

		local removeSmokeEffect = this.new("scripts/skills/effects/remove_smoke_effect");
		removeSmokeEffect.m.SmokeTiles = targets;
		_data.User.getSkills().add(removeSmokeEffect);

		this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], 1.0, _data.TargetTile.Pos);
		local p = {
			Type = "smoke",
			Tooltip = "Густой дым покрывает территорию, позволяя всем, кто находится внутри, свободно перемещаться и игнорировать зоны контроля, а также обеспечивая защиту от атак дальнего боя.",
			IsPositive = true,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = true,
			IsByPlayer = _data.User.isPlayerControlled(),
			Timeout = this.Time.getRound() + 2,
			Callback = this.Const.Tactical.Common.onApplySmoke,
			function Applicable( _a )
			{
				return true;
			}

		};

		foreach( tile in targets )
		{
			if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "smoke")
			{
				tile.Properties.Effect.Timeout = this.Time.getRound() + 2;
			}
			else
			{
				if (tile.Properties.Effect != null)
				{
					this.Tactical.Entities.removeTileEffect(tile);
				}

				tile.Properties.Effect = clone p;
				local particles = [];

				for( local i = 0; i < this.Const.Tactical.SmokeParticles.len(); i = ++i )
				{
					particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.SmokeParticles[i].Brushes, tile, this.Const.Tactical.SmokeParticles[i].Delay, this.Const.Tactical.SmokeParticles[i].Quantity, this.Const.Tactical.SmokeParticles[i].LifeTimeQuantity, this.Const.Tactical.SmokeParticles[i].SpawnRate, this.Const.Tactical.SmokeParticles[i].Stages));
				}

				this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);

				if (tile.IsOccupiedByActor)
				{
					this.Const.Tactical.Common.onApplySmoke(tile, tile.getEntity());
				}
			}
		}
	}
});
::mods_hookNewObject("skills/actives/throw_fire_bomb_skill", function(o) 
{
	o.onApply = function( _data )
	{
		local targets = [];
		targets.push(_data.TargetTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_data.TargetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _data.TargetTile.getNextTile(i);
				targets.push(tile);
			}
		}
		local removeFireGranadeEffect = this.new("scripts/skills/effects/remove_fire_granade_effect");
		removeFireGranadeEffect.m.FireGranadeTiles = targets;
		_data.User.getSkills().add(removeFireGranadeEffect);

		this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], 1.0, _data.TargetTile.Pos);
		local p = {
			Type = "fire",
			Tooltip = "Здесь бушует огонь, раскаляя доспехи и обугливая плоть",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _data.User.isPlayerControlled(),
			Timeout = this.Time.getRound() + 3,
			Callback = this.Const.Tactical.Common.onApplyFire,
			function Applicable( _a )
			{
				return true;
			}

		};

		foreach( tile in targets )
		{
			if (tile.Subtype != this.Const.Tactical.TerrainSubtype.Snow && tile.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow && tile.Type != this.Const.Tactical.TerrainType.ShallowWater && tile.Type != this.Const.Tactical.TerrainType.DeepWater)
			{
				if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire")
				{
					tile.Properties.Effect.Timeout = this.Time.getRound() + 3;
				}
				else
				{
					if (tile.Properties.Effect != null)
					{
						this.Tactical.Entities.removeTileEffect(tile);
					}

					tile.Properties.Effect = clone p;
					local particles = [];

					for( local i = 0; i < this.Const.Tactical.FireParticles.len(); i = ++i )
					{
						particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.FireParticles[i].Brushes, tile, this.Const.Tactical.FireParticles[i].Delay, this.Const.Tactical.FireParticles[i].Quantity, this.Const.Tactical.FireParticles[i].LifeTimeQuantity, this.Const.Tactical.FireParticles[i].SpawnRate, this.Const.Tactical.FireParticles[i].Stages));
					}

					this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
					tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
					tile.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
			}

			if (tile.IsOccupiedByActor)
			{
				this.Const.Tactical.Common.onApplyFire(tile, tile.getEntity());
			}
		}
	}
});
::mods_hookNewObject("skills/actives/miasma_skill", function(o) 
{
	o.onUse = function( _user, _targetTile )
	{
		local targets = [];
		targets.push(_targetTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);
				targets.push(tile);
			}
		}

		local removeMiasmaEffect = this.new("scripts/skills/effects/remove_miasma_effect");
		removeMiasmaEffect.m.MiasmaTiles = targets;
		_user.getSkills().add(removeMiasmaEffect);

		local p = {
			Type = "miasma",
			Tooltip = "Миазмы скопились здесь, отравляя любое живое создание",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = false,
			Timeout = this.Time.getRound() + 4,
			Callback = this.Const.Tactical.Common.onApplyMiasma,
			function Applicable( _a )
			{
				return !_a.getFlags().has("undead");
			}

		};

		foreach( tile in targets )
		{
			if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "miasma")
			{
				tile.Properties.Effect.Timeout = this.Time.getRound() + 4;
			}
			else
			{
				if (tile.Properties.Effect != null)
				{
					this.Tactical.Entities.removeTileEffect(tile);
				}

				tile.Properties.Effect = clone p;
				local particles = [];

				for( local i = 0; i < this.Const.Tactical.MiasmaParticles.len(); i = ++i )
				{
					particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.MiasmaParticles[i].Brushes, tile, this.Const.Tactical.MiasmaParticles[i].Delay, this.Const.Tactical.MiasmaParticles[i].Quantity, this.Const.Tactical.MiasmaParticles[i].LifeTimeQuantity, this.Const.Tactical.MiasmaParticles[i].SpawnRate, this.Const.Tactical.MiasmaParticles[i].Stages));
				}

				this.Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
			}
		}

		return true;
	}
});
})
