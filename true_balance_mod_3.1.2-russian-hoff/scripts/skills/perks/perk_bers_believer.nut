this.perk_bers_believer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.bers_believer";
		this.m.Name = this.Const.Strings.PerkName.TrueBeliever;
		this.m.Description = this.Const.Strings.PerkDescription.TrueBeliever;
		this.m.Icon = "ui/perks/perk_09.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByLosingHitpoints = false;
	}

});

