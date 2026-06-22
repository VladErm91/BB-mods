this.add_quick_hands_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.add_quick_hands";
		this.m.Name = "Добавить 'Ловкость рук'";
		this.m.Description = "Всегда готов мгновенно выхватить оружие!";
		this.m.Icon = "skills/active_13_on.png";
		this.m.SoundOnUse = [];
		this.m.SoundVolume = 0.5;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Last;
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
				text = "Добавляет эффект 'Ловкость рук'"
			}
		];
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/actives/remove_quick_hands_skill"));
		this.removeSelf();
		return true;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}
	
	function onCombatFinished()
	{
		this.removeSelf();
	}

});

