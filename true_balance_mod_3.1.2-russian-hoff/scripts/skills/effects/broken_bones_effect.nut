this.broken_bones_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.broken_bones";
		this.m.Name = "Сломанные кости";
		this.m.Icon = "ui/injury/injury_icon_04.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.Overlay = "injury_icon_04";
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		return actor.getSkills().hasSkill("racial.ghoul");
	}
	
	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.getSkills().hasSkill("racial.ghoul"))
		{
			_properties.DamageTotalMult *= 0.85;
		}	
	}

});

