this.hunt_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.hunt";
		this.m.Name = "Дурной глаз";
		this.m.Description = "Отменить возможность нанести удар в голову с шансом 100%.";
		this.m.Icon = "skills/active_156.png";
		this.m.Overlay = "active_156";
		this.m.SoundOnUse = [
			"sounds/combat/perfect_focus_01.wav"
		];
		this.m.SoundVolume = 0.5;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Снимает возможность нанести удар в голову с шансом 100%."
			}
		];
		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.getContainer().hasSkill("effects.hunt");
	}

	function onCombatStarted()
	{
		this.removeSelf();
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().hasSkill("effects.hunt"))
		{
			this.removeSelf();
		}
	}

	function onUse( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		this.removeSelf();

		if (this.getContainer().hasSkill("effects.hunt"))
		{
			this.m.Container.removeByID("effects.hunt");
			return true;
		}

		return false;
	}

});

