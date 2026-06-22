this.second_wind_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.second_wind";
		this.m.Name = "Обрёл второе дыхание";
		this.m.Icon = "ui/perks/perk_04.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "Этот персонаж обрёл второе дыхание. Но в этом бою такое вряд ли повторится вновь.";
	}

	function onCombatStarted()
	{
		this.removeSelf();
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

});

