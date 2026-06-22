this.perk_riposte <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.riposte";
		this.m.Name = this.Const.Strings.PerkName.FullForce;
		this.m.Description = this.Const.Strings.PerkDescription.FullForce;
		this.m.Icon = "ui/perks/perk_18.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTurnStart()
	{
		this.m.Container.add(this.new("scripts/skills/effects/ripostes_effect"));
	}

});