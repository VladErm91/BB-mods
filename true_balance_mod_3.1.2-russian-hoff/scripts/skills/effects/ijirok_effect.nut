this.ijirok_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ijirok";
		this.m.Name = "Плоть Иджирока";
		this.m.Icon = "skills/status_effect_108.png";
		this.m.Description = "Одновременное ношение 'Брони Иджирока' и 'Шлема Иджирока' даёт персонажу невосприимчивость к новым травмам, получаемым во время боя.";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
	}

	function getTooltip()
	{
		return [
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
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Невосприимчив к непостоянным травмам"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByInjuries = false;
	}

});

