this.perk_melee_archer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.melee_archer";
		this.m.Name = this.Const.Strings.PerkName.MeleeArcher;
		this.m.Description = this.Const.Strings.PerkDescription.MeleeArcher;
		this.m.Icon = "ui/perks/melee_archer.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});

