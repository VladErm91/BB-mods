this.dagger_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.dagger";
		this.m.Name = "Готов быстро и скрытно нанести удар";
		this.m.Icon = "ui/perks/perk_51.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsHidden = true;
	}

	function onTurnStart()
	{
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers)
		{
			this.m.Container.add(this.new("scripts/skills/effects/y_dagger_effect"));
		}	
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();

		if (_skill.getID() == "actives.puncture" && ((!actor.getSkills().hasSkill("effects.backstabber") && !actor.getSkills().hasSkill("effects.no_backstabber")) || (actor.getSkills().hasSkill("effects.backstabber"))))
		{
			this.m.Container.removeByID("effects.y_dagger");
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		local actor = this.getContainer().getActor();

		if (_skill.getID() == "actives.puncture" && ((!actor.getSkills().hasSkill("effects.backstabber") && !actor.getSkills().hasSkill("effects.no_backstabber")) || (actor.getSkills().hasSkill("effects.backstabber"))))
		{
			this.m.Container.removeByID("effects.y_dagger");
		}
	}

	function onCombatStarted()
	{
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers)
		{
			this.m.Container.add(this.new("scripts/skills/effects/y_dagger_effect"));
		}	
	}
});

