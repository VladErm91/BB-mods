this.berserk_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.berserk";
		this.m.Name = "Нужно больше крови!";
		this.m.Icon = "ui/perks/perk_36.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();

		if (!actor.getSkills().hasSkill("effects.bersr") && actor.getMoraleState() != this.Const.MoraleState.Breaking)
		{
			actor.checkMorale(-1, -15, this.Const.MoraleCheckType.MentalAttack);
		}
	}

});

