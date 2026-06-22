this.stun_helper_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.stun_helper";
		this.m.Name = "DDD";
		this.m.Icon = "ui/perks/perk_13.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.setActionPoints(actor.getActionPoints() + 30);
	}
	function onUpdate( _properties )
	{
		_properties.IsStunned = false;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

});

