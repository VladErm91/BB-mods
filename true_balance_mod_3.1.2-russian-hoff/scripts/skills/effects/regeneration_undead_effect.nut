this.regeneration_undead_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.regeneration_undead";
		this.m.Name = "Нужно больше крови!";
		this.m.Icon = "ui/perks/perk_36.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.getHitpointsMax() == actor.getHitpoints())
		{
			this.removeSelf();
		}
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + actor.getHitpointsMax() / 2));
		actor.onUpdateInjuryLayer();
		this.removeSelf();
	}

});

