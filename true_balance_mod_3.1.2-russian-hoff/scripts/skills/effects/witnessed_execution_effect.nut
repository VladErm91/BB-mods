this.witnessed_execution_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.witnessed_execution";
		this.m.Name = "Жажда крови удовлетворена";
		this.m.Icon = "skills/status_effect_34.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.Overlay = "active_34";
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

});

