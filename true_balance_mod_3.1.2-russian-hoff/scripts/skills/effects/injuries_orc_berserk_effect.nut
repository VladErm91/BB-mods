this.injuries_orc_berserk_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.injuries_orc_berserk";
		this.m.Name = "Невосприимчив к травмам";
		this.m.Icon = "ui/perks/perk_57.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
	}
	
});

