this.wolfrider_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.wolfrider";
		this.m.Name = "Жажда крови удовлетворена";
		this.m.Icon = "skills/status_effect_34.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().hasSkill("effects.wolf_first_attack"))
		{
			_properties.IsSkillUseDobleCost = true;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.m.Container.add(this.new("scripts/skills/effects/wolf_first_attack_effect"));
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.m.Container.add(this.new("scripts/skills/effects/wolf_first_attack_effect"));
	}
	
});

