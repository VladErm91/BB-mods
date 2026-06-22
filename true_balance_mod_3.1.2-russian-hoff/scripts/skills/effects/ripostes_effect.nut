this.ripostes_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ripostes";
		this.m.Name = "Контратака";
		this.m.Icon = "skills/status_effect_33.png";
		this.m.IconMini = "status_effect_33_mini";
		this.m.Overlay = "status_effect_33";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function getDescription()
	{
		return "Этот персонаж готов немедленно ответить на любую неудачную попытку атаковать его в ближнем бою.";
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.getSkills().hasSkill("effects.stunned"))
		{
			_properties.IsRipostings = true;
		}	
	}

});

