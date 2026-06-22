this.hunt_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.hunt";
		this.m.Name = "Получай в голову!";
		this.m.Icon = "ui/perks/perk_15.png";
		this.m.Overlay = "perk_15";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Следующая атака попадёт в голову с вероятностью [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color].";
	}

	function onUpdate( _properties )
	{
		_properties.HitChance[this.Const.BodyPart.Head] = 100.0;
	}

	function onCombatStarted()
	{
		this.removeSelf();
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}

});

