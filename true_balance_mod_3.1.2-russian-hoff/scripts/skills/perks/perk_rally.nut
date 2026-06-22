this.perk_rally <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rally";
		this.m.Name = this.Const.Strings.PerkName.Steadfast;
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.SoundOnUse = [];
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local bravery = this.Math.floor(actor.getCurrentProperties().getBravery() * 0.4);
		local actors = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local maxFat = actor.getFatigueMax();
		local currentFat = actor.getFatigue();
		local ratio = currentFat / maxFat;

		if (!actor.getSkills().hasSkill("effects.stunned") && actor.getMoraleState() != this.Const.MoraleState.Fleeing && ratio <= 0.75)
		{
			foreach( a in actors )
			{
				if (a.getID() == actor.getID())
				{
					continue;
				}

				if (myTile.getDistanceTo(a.getTile()) > 4)
				{
					continue;
				}

		     		if (myTile.getDistanceTo(a.getTile()) <= 4 && a.getMoraleState() == this.Const.MoraleState.Fleeing)
				{
					actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() - 5));
					actor.setFatigue(actor.getFatigue() + 25);
					actor.setDirty(true);
					this.Sound.play("sounds/combat/rally_the_troops_01.wav");
					this.spawnIcon("perk_42_active", this.m.Container.getActor().getTile());

					if (a.getFaction() == actor.getFaction() && !a.getSkills().hasSkill("effects.rallied"))
					{
						a.getSkills().removeByID("effects.sleeping");

						for( ; a.getMoraleState() >= this.Const.MoraleState.Steady;  )
						{
						}

						local difficulty = bravery;
						local distance = a.getTile().getDistanceTo(myTile) * 10;
						local morale = a.getMoraleState();

						if (a.getMoraleState() == this.Const.MoraleState.Fleeing)
						{
							a.checkMorale(this.Const.MoraleState.Wavering - this.Const.MoraleState.Fleeing, difficulty, this.Const.MoraleCheckType.Default, "status_effect_56");
						}
						else
						{
							a.checkMorale(1, difficulty - distance, this.Const.MoraleCheckType.Default, "status_effect_56");
						}

						if (morale != a.getMoraleState())
						{
							a.getSkills().add(this.new("scripts/skills/effects/rallied_effect"));
						}
					}
				}
			}
		}

		this.getContainer().add(this.new("scripts/skills/effects/rallied_effect"));
		return true;
	}

});

