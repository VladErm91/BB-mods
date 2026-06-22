this.perk_recoversa <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.recoversa";
		this.m.Name = this.Const.Strings.PerkName.Steadfast;
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.SoundOnUse = [];
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local maxFat = actor.getFatigueMax();
		local currentFat = actor.getFatigue();
		local ratio = currentFat / maxFat;

		if (!actor.getSkills().hasSkill("effects.stunned") && (ratio > 0.75))
		{
			actor.setFatigue(actor.getFatigue() / 1.3);
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() - 9));
			actor.setDirty(true);
			this.spawnIcon("perk_54_active", this.m.Container.getActor().getTile());
			actor.playSound(this.Const.Sound.ActorEvent.Fatigue, this.Const.Sound.Volume.Actor * actor.getSoundVolume(this.Const.Sound.ActorEvent.Fatigue));
		}
	}

});

