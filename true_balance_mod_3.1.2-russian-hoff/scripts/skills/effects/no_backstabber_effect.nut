this.no_backstabber_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.no_backstabber";
		this.m.Name = "Первый неожиданный удар уже был нанесен";
		this.m.Icon = "ui/perks/perk_59.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;
	}

});

