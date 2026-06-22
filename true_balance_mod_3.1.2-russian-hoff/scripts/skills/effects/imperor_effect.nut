this.imperor_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.imperor";
		this.m.Name = "Решимость императора";
		this.m.Icon = "skills/status_effect_108.png";
		this.m.Description = "Одновременное ношение 'Доспехов императора' и 'Шлема императора' предотвращает проверку боевого духа при потере ОЗ и шанс 100% выжить, если ОЗ достигли нуля.";
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
				text = "Имеет [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] шанс выжить, если пал в бою и сохранил при этом голову на плечах"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Не проводится проверка боевого духа при потере ОЗ"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.SurviveWithInjuryChanceMult *= 3.72;
	}

});

