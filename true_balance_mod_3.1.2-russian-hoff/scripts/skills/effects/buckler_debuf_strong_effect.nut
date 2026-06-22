this.buckler_debuf_strong_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.buckler_debuf_strong";
		this.m.Name = "Уязвим";
		this.m.Description = "Удар персонажа был отражен баклером, что сделало его уязвимым для последующих атак";
		this.m.Icon = "ui/perks/perk_22.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-7[/color] к защите в ближнем бою"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense -= 7;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}
});

