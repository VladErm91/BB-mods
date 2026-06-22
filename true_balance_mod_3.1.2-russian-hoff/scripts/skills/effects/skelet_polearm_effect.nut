this.skelet_polearm_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.skelet_polearm";
		this.m.Name = "Жажда крови удовлетворена";
		this.m.Icon = "skills/status_effect_34.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		_properties.MovementAPCostAdditional += 1;
		_properties.IsSkillUseHalfCost = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.m.Container.add(this.new("scripts/skills/effects/skelet_polearm_weapon_effect"));
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.m.Container.add(this.new("scripts/skills/effects/skelet_polearm_weapon_effect"));
	}
	
});

