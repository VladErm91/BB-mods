this.perk_blend_in <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.blend_in";
		this.m.Name = this.Const.Strings.PerkName.QuickReflexes;
		this.m.Description = this.Const.Strings.PerkDescription.QuickReflexes;
		this.m.Icon = "ui/perks/clarity_circle.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;

	}

	function getDescription()
	{
		return "Персонаж получает возможность перенаправить вражеские удары на самую бронированную часть тела, с шансом, равным его защите дальнего боя.";
	}

	function getTooltip()
	{
		local rd = this.getContainer().getActor().getBaseProperties().getRangedDefense();
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
				text = "Если шлем прочнее доспеха, то вероятность нанести удар в голову составляет [color=" + this.Const.UI.Color.PositiveValue + "]+" + rd  + "%[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Если доспех прочнее шлема, то вероятность нанести удар в голову составляет [color=" + this.Const.UI.Color.PositiveValue + "]-" + rd * 0.4 + "%[/color]"
			}
		];
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (!actor.getSkills().hasSkill("effects.parry"))
		{
			actor.getSkills().add(this.new("scripts/skills/effects/parry_effect"));
		}
	}

});

