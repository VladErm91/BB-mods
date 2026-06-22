this.ghoul_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.ghoul";
		this.m.Name = "Яд";
		this.m.Description = "TODO";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		local num = this.Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction()).len();
		_properties.Bravery += (num - 1) * 3;
	}

});

