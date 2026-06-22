::mods_registerMod("mod_traits", 1.8, "True Balance Mod Traits");
::mods_queue("mod_traits", "mod_true_balance", function() {
::mods_hookNewObject("skills/traits/bloodthirsty_trait", function(o) 
{
	o.getTooltip = function()
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
				text = "При убийстве отрубает голову (если это позволяет оружие)."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Высокая вероятность убийства повысит боевой дух."
			}
		];
	}
});
::mods_hookNewObject("skills/traits/cocky_trait", function(o) 
{
	o.getTooltip = function()
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] к решимости"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] к инициативе"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] к навыку ближнего боя"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] к навыку дальнего боя"
			}
		];
	}

	o.onUpdate = function( _properties )
	{
		_properties.Bravery += 5;
		_properties.Initiative += 5;
		_properties.MeleeDefense += -5;
		_properties.RangedDefense += -5;
	}
});
::mods_hookNewObject("skills/traits/drunkard_trait", function(o) 
{
	o.getTooltip = function()
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
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] к решимости"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] к навыку ближнего боя"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] к навыку дальнего боя"
			}
		];
	}

	o.onUpdate = function( _properties )
	{
		_properties.Bravery += 10;
		_properties.MeleeSkill += -5;
		_properties.RangedSkill += -5;
	}
});
::mods_hookNewObject("skills/traits/huge_trait", function(o) 
{
	o.getTooltip = function()
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
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] к урону в ближнем бою"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] к защите в ближнем бою"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] к защите в дальнем бою"
			}
		];
	}

	o.onUpdate = function( _properties )
	{
		_properties.MeleeDamageMult *= 1.1;
		_properties.MeleeDefense -= 5;
		_properties.RangedDefense -= 10;
	}
});
})
