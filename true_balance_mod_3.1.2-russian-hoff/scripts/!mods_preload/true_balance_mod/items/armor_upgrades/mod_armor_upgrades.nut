::mods_registerMod("mod_armor_upgrades", 1.8, "True Balance Mod Armor Upgrades");
::mods_queue("mod_armor_upgrades", "mod_true_balance", function() {
::mods_hookNewObject("items/armor_upgrades/light_gladiator_upgrade", function(o) 
{
		o.m.StaminaModifier = 3;
});
::mods_hookNewObject("items/armor_upgrades/heavy_gladiator_upgrade", function(o) 
{
		o.m.StaminaModifier = 8;
});
::mods_hookNewObject("items/armor_upgrades/hyena_fur_upgrade", function(o) 
{
	o.getTooltip = function()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] к прочности"
		});
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] к инициативе"
		});
		return result;
	}

	o.onArmorTooltip = function( _result )
	{
		_result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] к инициативе"
		});
	}

	o.onUpdateProperties = function( _properties )
	{
		_properties.Initiative += 10;
	}
});
::mods_hookNewObject("items/armor_upgrades/lindwurm_scales_upgrade", function(o) 
{
		o.m.StaminaModifier = 2;

	o.getTooltip = function()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 13,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+60[/color] к прочности"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-2[/color] к выносливости"
		});
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Не подвержен воздействию кислотной крови Линдвурма"
		});
		return result;
	}
});
::mods_hookNewObject("items/armor_upgrades/serpent_skin_upgrade", function(o) 
{
		o.m.StaminaModifier = 1;
	o.getTooltip = function()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+30[/color] к прочности"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-1[/color] к выносливости"
		});
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Уменьшает урон от огня и огнестрельного оружия на [color=" + this.Const.UI.Color.NegativeValue + "]33%[/color]"
		});
		return result;
	}
});
::mods_hookNewObject("items/armor_upgrades/double_mail_upgrade", function(o) 
{
	o.m.Value = 150;
});
::mods_hookNewObject("items/armor_upgrades/mail_patch_upgrade", function(o) 
{
	o.m.Value = 150;
});
::mods_hookNewObject("items/armor_upgrades/metal_plating_upgrade", function(o) 
{
	o.m.Value = 250;
});
::mods_hookNewObject("items/armor_upgrades/joint_cover_upgrade", function(o) 
{
	o.m.Value = 250;
});
})
