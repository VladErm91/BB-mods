::mods_registerMod("mod_racial", 1.8, "True Balance Mod Racial");
::mods_queue("mod_racial", "mod_true_balance", function() {
::mods_hookNewObject("skills/racial/skeleton_racial", function(o) 
{
	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null)
		{
			return;
		}

		if (_skill.getID() == "actives.aimed_shot" || _skill.getID() == "actives.quick_shot")
		{
			_properties.DamageReceivedRegularMult *= 0.1;
		}
		else if (_skill.getID() == "actives.shoot_bolt" || _skill.getID() == "actives.shoot_stake" || _skill.getID() == "actives.sling_stone" || _skill.getID() == "actives.fire_handgonne")
		{
			_properties.DamageReceivedRegularMult *= 0.33;
		}
		else if (_skill.getID() == "actives.throw_javelin" || _skill.getID() == "actives.ignite_firelance")
		{
			_properties.DamageReceivedRegularMult *= 0.25;
		}
		else if (_skill.getID() == "actives.puncture" || _skill.getID() == "actives.thrust" || _skill.getID() == "actives.stab" || _skill.getID() == "actives.deathblow" || _skill.getID() == "actives.impale" || _skill.getID() == "actives.rupture" || _skill.getID() == "actives.prong" || _skill.getID() == "actives.lunge" || _skill.getID() == "actives.run_through" || _skill.getID() == "actives.penetrate" || _skill.getID() == "actives.long_impale" || _skill.getID() == "actives.long_impale_skeleton")
		{
			_properties.DamageReceivedRegularMult *= 0.5;
		}
	}
});
::mods_hookNewObject("skills/racial/golem_racial", function(o) 
{
	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null)
		{
			return;
		}

		if (_skill.getID() == "actives.aimed_shot" || _skill.getID() == "actives.quick_shot")
		{
			_properties.DamageReceivedRegularMult *= 0.1;
		}
		else if (_skill.getID() == "actives.shoot_bolt" || _skill.getID() == "actives.shoot_stake" || _skill.getID() == "actives.sling_stone" || _skill.getID() == "actives.fire_handgonne")
		{
			_properties.DamageReceivedRegularMult *= 0.33;
		}
		else if (_skill.getID() == "actives.throw_javelin" || _skill.getID() == "actives.ignite_firelance")
		{
			_properties.DamageReceivedRegularMult *= 0.25;
		}
		else if (_skill.getID() == "actives.puncture" || _skill.getID() == "actives.thrust" || _skill.getID() == "actives.stab" || _skill.getID() == "actives.deathblow" || _skill.getID() == "actives.impale" || _skill.getID() == "actives.rupture" || _skill.getID() == "actives.prong" || _skill.getID() == "actives.lunge" || _skill.getID() == "actives.run_through" || _skill.getID() == "actives.penetrate" || _skill.getID() == "actives.long_impale" || _skill.getID() == "actives.long_impale_skeleton")
		{
			_properties.DamageReceivedRegularMult *= 0.5;
		}
	}
});
::mods_hookNewObject("skills/racial/spider_racial", function(o) 
{
	o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints < this.Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (!_targetEntity.isAlive())
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

		this.spawnIcon("status_effect_54", _targetEntity.getTile());
		local poison = _targetEntity.getSkills().getSkillByID("effects.spider_poison");

		if (poison == null)
		{
			local effect = this.new("scripts/skills/effects/spider_poison_effect");
			_targetEntity.getSkills().add(effect);
		}
		else
		{
			_targetEntity.checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
			poison.resetTime();
		}
	}
});
})
