this.remove_quick_hands_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.remove_quick_hands";
		this.m.Name = "Отключить 'Ловкость рук'";
		this.m.Description = "Не следует торопиться, оружие должно удобно лежать в руках.";
		this.m.Icon = "skills/active_13_off.png";
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
				text = "Снимает эффект 'Ловкость рук'"
			}
		];
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.getContainer().getActor().getSkills().add(this.new("scripts/skills/actives/add_quick_hands_skill"));
		this.removeSelf();
		return true;
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}
});

