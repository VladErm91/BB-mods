this.skelet_polearm_weapon_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.skelet_polearm_weapon";
		this.m.Name = "Жажда крови удовлетворена";
		this.m.Icon = "skills/status_effect_34.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		_properties.IsSkillUseDobleCost = true;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
	
});

