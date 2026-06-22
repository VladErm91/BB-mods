this.nett_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.nett";
		this.m.Name = "Захвачен";
		this.m.Description = "Персонаж захвачен и не может двигаться.";
		this.m.Icon = "skills/status_effect_58.png";
		this.m.IconMini = "status_effect_58_mini";
		this.m.Overlay = "status_effect_58";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
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
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Обездвижен[/color]"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsRooted = true;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});

