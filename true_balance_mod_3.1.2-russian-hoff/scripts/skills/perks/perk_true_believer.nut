this.perk_true_believer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.true_believer";
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
		_properties.IsAffectedByFleeingAllies = false;
	}

	function onAdded()
	{
		if (this.m.Container.hasSkill("trait.pessimist") || this.m.Container.hasSkill("trait.irrational"))
		{
			this.m.Container.removeByID("trait.pessimist");
			this.m.Container.removeByID("trait.irrational");
			this.m.Container.add(this.new("scripts/skills/traits/optimist_trait"));
		}
	}

});

