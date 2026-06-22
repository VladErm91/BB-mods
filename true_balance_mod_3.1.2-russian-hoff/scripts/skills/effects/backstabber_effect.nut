this.backstabber_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.backstabber";
		this.m.Name = "Готов нанести быстрый и неожиданный удар";
		this.m.Icon = "ui/perks/perk_59.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

});

