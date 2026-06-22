this.recovers_skill <- this.inherit("scripts/skills/skill", {
	m = {
		CanRecover = true,
	},
	function create()
	{
		this.m.ID = "actives.recovers";
		this.m.Name = "Небольшая передышка";
		this.m.Description = "Позволяет персонажу отдохнуть в течение хода, чтобы восстановить свои силы.";
		this.m.Icon = "skills/small_recover.png";
		this.m.IconDisabled = "ui/perks/perk_54_active_sw.png";
		this.m.Overlay = "small_recover";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 5;
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
				text = "Текущая накопленная усталость снижается на 25%"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().hasSkill("effects.bersrs"))
		{
			this.m.CanRecover = false;
		}
		else
		{
			this.m.CanRecover = true;
		}	
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.m.CanRecover;
	}

	function onTurnStart()
	{
		this.m.CanRecover = true;
	}

	function onUse( _user, _targetTile )
	{
		_user.setFatigue(_user.getFatigue() / 1.3);

		if (!_user.isHiddenToPlayer())
		{
			_user.playSound(this.Const.Sound.ActorEvent.Fatigue, this.Const.Sound.Volume.Actor * _user.getSoundVolume(this.Const.Sound.ActorEvent.Fatigue));
		}

		return true;
	}

});

