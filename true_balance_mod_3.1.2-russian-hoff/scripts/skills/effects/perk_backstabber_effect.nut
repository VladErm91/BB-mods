this.perk_backstabber_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.perk_backstabber";
		this.m.Name = this.Const.Strings.PerkName.Backstabber;
		this.m.Description = this.Const.Strings.PerkDescription.Backstabber;
		this.m.Icon = "ui/perks/perk_40.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTurnStart()
	{
		this.m.Container.add(this.new("scripts/skills/effects/backstabber_effect"));
		this.m.Container.removeByID("effects.no_backstabber");
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();

		if ((_skill.getID() == "actives.puncture" && !actor.getSkills().hasSkill("effects.y_dagger")) || (_skill.getID() == "actives.puncture" && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers))
		{
			this.m.Container.removeByID("effects.backstabber");
			this.m.Container.add(this.new("scripts/skills/effects/no_backstabber_effect"));
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		local actor = this.getContainer().getActor();

		if ((_skill.getID() == "actives.puncture" && !actor.getSkills().hasSkill("effects.y_dagger")) || (_skill.getID() == "actives.puncture" && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers))
		{
			this.m.Container.removeByID("effects.backstabber");
			this.m.Container.add(this.new("scripts/skills/effects/no_backstabber_effect"));
		}
	}

	function onCombatStarted()
	{
		this.m.Container.add(this.new("scripts/skills/effects/backstabber_effect"));
		this.m.Container.removeByID("effects.no_backstabber");
	}

});

