this.y_dagger_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.y_dagger";
		this.m.Name = "Мастер кинжала";
		this.m.Icon = "ui/perks/perk_51.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Позволяет повторно использовать умение 'Прокол', не провоцируя контратаку."
		});
		return tooltip;
	}

});

