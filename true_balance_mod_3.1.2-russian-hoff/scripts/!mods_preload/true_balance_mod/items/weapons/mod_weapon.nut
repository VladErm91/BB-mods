::mods_registerMod("mod_weapon", 1.8, "True Balance Mod Weapon");
::mods_queue("mod_weapon", "mod_true_balance", function() {
::mods_hookExactClass("items/weapons/weapon", function(o) 
{
	o.getTooltip = function()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 65,
			type = "text",
			text = this.m.Categories
		});
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.ConditionMax > 1)
		{
			result.push({
				id = 4,
				type = "progressbar",
				icon = "ui/icons/asset_supplies.png",
				value = this.getCondition(),
				valueMax = this.getConditionMax(),
				text = "" + this.getCondition() + " / " + this.getConditionMax() + "",
				style = "armor-body-slim"
			});
		}

		if (this.m.RegularDamage > 0)
		{
			result.push({
				id = 4,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Базовый урон [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamage + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.RegularDamageMax + "[/color]"
			});
		}

		if (this.m.DirectDamageMult > 0)
		{
			result.push({
				id = 64,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor((this.m.DirectDamageMult + this.m.DirectDamageAdd) * 100) + "%[/color] урона, игнорирующего броню"
			});
		}

		if (this.m.ArmorDamageMult > 0)
		{
			result.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "[color=" + this.Const.UI.Color.DamageValue + "]" + this.Math.floor(this.m.ArmorDamageMult * 100) + "%[/color] повреждение брони"
			});
		}

		if (this.m.ShieldDamage > 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/shield_damage.png",
				text = "Повреждение щита [color=" + this.Const.UI.Color.DamageValue + "]" + this.m.ShieldDamage + "[/color]"
			});
		}

		if (this.m.ChanceToHitHead > 0)
		{
			result.push({
				id = 9,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "Шанс попадания в голову [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ChanceToHitHead + "%[/color]"
			});
		}

		if (this.m.AdditionalAccuracy > 0)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Дополнительно [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.AdditionalAccuracy + "%[/color] к шансу на попадание"
			});
		}
		else if (this.m.AdditionalAccuracy < 0)
		{
			result.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Дополнительно [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.AdditionalAccuracy + "%[/color] к шансу на попадание"
			});
		}

		if (this.m.RangeMax > 1 && this.getID() != "weapon.fencing_sword" && this.getID() != "weapon.named_fencing_sword" && this.getID() != "weapon.estoc" && this.getID() != "weapon.named_estoc")
		{
			result.push({
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Дальность [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getRangeMax() + "[/color] клетки"
			});
		}

		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Выносливость [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}

		if (this.m.FatigueOnSkillUse > 0 && (this.getContainer() == null || !this.getContainer().getActor().getCurrentProperties().IsProficientWithHeavyWeapons))
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Умения оружия тратят на [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.FatigueOnSkillUse + "[/color] больше выносливости"
			});
		}
		else if (this.m.FatigueOnSkillUse > 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Умения оружия тратят на [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.FatigueOnSkillUse + "[/color] больше выносливости"
			});
		}
		else if (this.m.FatigueOnSkillUse < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Умения оружия тратят на [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.FatigueOnSkillUse + "[/color] меньше выносливости"
			});
		}

		if (this.m.AmmoMax > 0)
		{
			if (this.m.Ammo != 0)
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/icons/ammo.png",
					text = "Осталось выстрелов: [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color]"
				});
			}
			else
			{
				result.push({
					id = 10,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]Нет боеприпасов[/color]"
				});
			}
		}

		return result;
	}
});
::mods_hookNewObject("items/weapons/arming_sword", function(o) 
{
	o.m.StaminaModifier = -6;
	o.m.Value = 1250;
	o.m.RegularDamage = 45;
	o.m.RegularDamageMax = 50;
	o.m.ArmorDamageMult = 0.65;
	o.m.DirectDamageMult = 0.20;
});
::mods_hookNewObject("items/weapons/longsword", function(o) 
{
	o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/longsword_slash"));
		local skillToAdd = this.new("scripts/skills/actives/overhead_strike");
		skillToAdd.setStunChance(this.m.StunChance);
		this.addSkill(skillToAdd);
		this.addSkill(this.new("scripts/skills/actives/split"));
		this.addSkill(this.new("scripts/skills/actives/swing"));
	}
});
::mods_hookNewObject("items/weapons/bludgeon", function(o) 
{
	o.m.Value = 90;
	o.m.Condition = 64.0;
	o.m.ConditionMax = 64.0;
	o.m.StaminaModifier = -7;
	o.m.RegularDamage = 20;
	o.m.RegularDamageMax = 35;
	o.m.ArmorDamageMult = 0.9;
	o.m.DirectDamageMult = 0.4;
});
::mods_hookNewObject("items/weapons/boar_spear", function(o) 
{
	o.m.Value = 750;
	o.m.Condition = 64.0;
	o.m.ConditionMax = 64.0;
	o.m.StaminaModifier = -8;
	o.m.RegularDamage = 30;
	o.m.RegularDamageMax = 35;
	o.m.ArmorDamageMult = 0.90;
	o.m.DirectDamageMult = 0.35;
});
::mods_hookNewObject("items/weapons/dagger", function(o) 
{
	o.m.Condition = 40.0;
	o.m.ConditionMax = 40.0;
	o.m.StaminaModifier = -2;
	o.m.Value = 180;
	o.m.RegularDamage = 20;
	o.m.RegularDamageMax = 30;
	o.m.ArmorDamageMult = 0.60;
	o.m.DirectDamageMult = 0.35;
});
::mods_hookNewObject("items/weapons/falchion", function(o) 
{
	o.m.Value = 500;
	o.m.Condition = 48.0;
	o.m.ConditionMax = 48.0;
	o.m.StaminaModifier = -6;
	o.m.RegularDamage = 40;
	o.m.RegularDamageMax = 50;
	o.m.ArmorDamageMult = 0.55;
	o.m.DirectDamageMult = 0.20;
});
::mods_hookNewObject("items/weapons/fencing_sword", function(o) 
{
	o.m.Condition = 48.0;
	o.m.ConditionMax = 48.0;
	o.m.StaminaModifier = -4;
	o.m.Value = 1550;
	o.m.RangeMin = 1;
	o.m.RangeMax = 2;
	o.m.RangeIdeal = 2;
	o.m.RegularDamage = 40;
	o.m.RegularDamageMax = 55;
	o.m.ArmorDamageMult = 0.60;
	o.m.DirectDamageMult = 0.20;
});
::mods_hookNewObject("items/weapons/fighting_axe", function(o) 
{
	o.m.Value = 1900;
	o.m.ShieldDamage = 16;
	o.m.Condition = 80.0;
	o.m.ConditionMax = 80.0;
	o.m.StaminaModifier = -12;
	o.m.RegularDamage = 35;
	o.m.RegularDamageMax = 55;
	o.m.ArmorDamageMult = 1.3;
	o.m.DirectDamageMult = 0.3;
});
::mods_hookNewObject("items/weapons/fighting_spear", function(o) 
{
	o.m.Value = 1500;
	o.m.Condition = 72.0;
	o.m.ConditionMax = 72.0;
	o.m.StaminaModifier = -10;
	o.m.RegularDamage = 35;
	o.m.RegularDamageMax = 40;
	o.m.ArmorDamageMult = 1.0;
	o.m.DirectDamageMult = 0.35;
});
::mods_hookNewObject("items/weapons/flail", function(o) 
{
	o.m.Value = 1400;
	o.m.ShieldDamage = 0;
	o.m.Condition = 72.0;
	o.m.ConditionMax = 72.0;
	o.m.StaminaModifier = -8;
	o.m.RegularDamage = 30;
	o.m.RegularDamageMax = 55;
	o.m.ArmorDamageMult = 1.1;
	o.m.DirectDamageMult = 0.3;
	o.m.ChanceToHitHead = 0;
});
::mods_hookNewObject("items/weapons/goedendag", function(o) 
{
	o.m.Value = 600;
	o.m.ShieldDamage = 0;
	o.m.Condition = 64.0;
	o.m.ConditionMax = 64.0;
	o.m.StaminaModifier = -14;
	o.m.RegularDamage = 40;
	o.m.RegularDamageMax = 50;
	o.m.ArmorDamageMult = 0.65;
	o.m.DirectDamageMult = 0.50;
	o.m.ChanceToHitHead = 5;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local penetrate = this.new("scripts/skills/actives/penetrate_goedendag");
		penetrate.m.Icon = "skills/active_128.png";
		penetrate.m.IconDisabled = "skills/active_128_sw.png";
		penetrate.m.Overlay = "active_128";
		this.addSkill(penetrate);
		local lunge = this.new("scripts/skills/actives/lunge_goedendag");
		lunge.m.Name = "Прокол";
		lunge.m.Description = "Сильный дальний удар, позволяющий застать врага врасплох. Чем быстрее персонаж, тем больше урона он нанесёт.";
		lunge.m.DirectDamageMult = 0.50;
		lunge.setFatigueCost(30);
		lunge.m.ActionPointCost = 6;
		lunge.m.Icon = "skills/lunge_estoc.png";
		lunge.m.IconDisabled = "skills/lunge_estoc_sw.png";
		lunge.m.Overlay = "lunge_estoc";
		this.addSkill(lunge);
		local knockOut = this.new("scripts/skills/actives/goedendag_knock_out");
		knockOut.m.Icon = "skills/active_127.png";
		knockOut.m.IconDisabled = "skills/active_127_sw.png";
		knockOut.m.Overlay = "active_127";
		knockOut.m.ActionPointCost = 6;
		knockOut.setFatigueCost(knockOut.getFatigueCostRaw() + 5);
		this.addSkill(knockOut);
	}
});
::mods_hookNewObject("items/weapons/knife", function(o) 
{
		o.m.Value = 30;
		o.m.StaminaModifier = -1;
		o.m.Condition = 32.0;
		o.m.ConditionMax = 32.0;
		o.m.RegularDamage = 15;
		o.m.RegularDamageMax = 20;
		o.m.ArmorDamageMult = 0.50;
		o.m.DirectDamageMult = 0.35;
});
::mods_hookNewObject("items/weapons/military_pick", function(o) 
{
		o.m.Value = 900;
		o.m.ShieldDamage = 0;
		o.m.Condition = 80.0;
		o.m.ConditionMax = 80.0;
		o.m.StaminaModifier = -10;
		o.m.RegularDamage = 25;
		o.m.RegularDamageMax = 35;
		o.m.ArmorDamageMult = 2.0;
		o.m.DirectDamageMult = 0.5;
});
::mods_hookNewObject("items/weapons/militia_spear", function(o) 
{
		o.m.Value = 180;
		o.m.Condition = 48.0;
		o.m.ConditionMax = 48.0;
		o.m.StaminaModifier = -6;
		o.m.RegularDamage = 25;
		o.m.RegularDamageMax = 30;
		o.m.ArmorDamageMult = 0.85;
		o.m.DirectDamageMult = 0.35;
});
::mods_hookNewObject("items/weapons/morning_star", function(o) 
{
		o.m.Categories = "Булава, одноручное";
		o.m.IconLarge = "weapons/melee/morning_star_old_01.png";
		o.m.Icon = "weapons/melee/morning_star_old_01_70x70.png";
		o.m.SlotType = this.Const.ItemSlot.Mainhand;
		o.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		o.m.IsDoubleGrippable = true;
		o.m.AddGenericSkill = true;
		o.m.ShowQuiver = false;
		o.m.ShowArmamentIcon = true;
		o.m.ArmamentIcon = "icon_morning_star_old_01";
		o.m.Value = 600;
		o.m.ShieldDamage = 0;
		o.m.Condition = 72.0;
		o.m.ConditionMax = 72.0;
		o.m.StaminaModifier = -8;
		o.m.RegularDamage = 30;
		o.m.RegularDamageMax = 45;
		o.m.ArmorDamageMult = 1.0;
		o.m.DirectDamageMult = 0.4;
});
::mods_hookNewObject("items/weapons/noble_sword", function(o) 
{
		o.m.Condition = 72.0;
		o.m.ConditionMax = 72.0;
		o.m.StaminaModifier = -8;
		o.m.Value = 2500;
		o.m.RegularDamage = 50;
		o.m.RegularDamageMax = 55;
		o.m.ArmorDamageMult = 0.70;
		o.m.DirectDamageMult = 0.20;
});
::mods_hookNewObject("items/weapons/pickaxe", function(o) 
{
		o.m.Value = 120;
		o.m.ShieldDamage = 0;
		o.m.Condition = 56.0;
		o.m.ConditionMax = 56.0;
		o.m.StaminaModifier = -12;
		o.m.RegularDamage = 20;
		o.m.RegularDamageMax = 30;
		o.m.ArmorDamageMult = 1.5;
		o.m.DirectDamageMult = 0.5;
});
::mods_hookNewObject("items/weapons/pike", function(o) 
{
		o.m.Value = 900;
		o.m.ShieldDamage = 0;
		o.m.Condition = 64.0;
		o.m.ConditionMax = 64.0;
		o.m.StaminaModifier = -14;
		o.m.RangeMin = 1;
		o.m.RangeMax = 2;
		o.m.RangeIdeal = 2;
		o.m.RegularDamage = 60;
		o.m.RegularDamageMax = 80;
		o.m.ArmorDamageMult = 1.0;
		o.m.DirectDamageMult = 0.35;
		o.m.ChanceToHitHead = 5;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale");
		impale.m.Icon = "skills/active_54.png";
		impale.m.IconDisabled = "skills/active_54_sw.png";
		impale.m.Overlay = "active_54";
		impale.m.DirectDamageMult = 0.35;
		this.addSkill(impale);
		this.addSkill(this.new("scripts/skills/actives/repel"));
		local long_impale = this.new("scripts/skills/actives/long_impale");
		long_impale.m.DirectDamageMult = 0.45;
		long_impale.m.Icon = "skills/disembovel.png";
		long_impale.m.IconDisabled = "skills/disembovel_sw.png";
		this.addSkill(long_impale);
	}
});
::mods_hookNewObject("items/weapons/ancient/bladed_pike", function(o) 
{
	o.onEquip = function()
	{
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale");
		impale.m.Icon = "skills/active_54.png";
		impale.m.IconDisabled = "skills/active_54_sw.png";
		impale.m.Overlay = "active_54";
		this.addSkill(impale);
		this.addSkill(this.new("scripts/skills/actives/repel"));
		this.addSkill(this.new("scripts/skills/actives/long_impale"))
	}
});
::mods_hookNewObject("items/weapons/ancient/broken_bladed_pike", function(o) 
{
	o.onEquip = function()
	{
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale");
		impale.m.Icon = "skills/active_54.png";
		impale.m.IconDisabled = "skills/active_54_sw.png";
		impale.m.Overlay = "active_54";
		this.addSkill(impale);
		this.addSkill(this.new("scripts/skills/actives/repel"));
		this.addSkill(this.new("scripts/skills/actives/long_impale"))
	}
});
::mods_hookNewObject("items/weapons/pitchfork", function(o) 
{
		o.m.Value = 150;
		o.m.ShieldDamage = 0;
		o.m.Condition = 40.0;
		o.m.ConditionMax = 40.0;
		o.m.StaminaModifier = -14;
		o.m.RangeMin = 1;
		o.m.RangeMax = 2;
		o.m.RangeIdeal = 2;
		o.m.RegularDamage = 30;
		o.m.RegularDamageMax = 50;
		o.m.ArmorDamageMult = 0.75;
		o.m.DirectDamageMult = 0.35;
		o.m.ChanceToHitHead = 5;
});
::mods_hookNewObject("items/weapons/reinforced_wooden_flail", function(o) 
{
		o.m.Value = 300;
		o.m.ShieldDamage = 0;
		o.m.Condition = 40.0;
		o.m.ConditionMax = 40.0;
		o.m.StaminaModifier = -7;
		o.m.RegularDamage = 25;
		o.m.RegularDamageMax = 45;
		o.m.ArmorDamageMult = 0.9;
		o.m.ChanceToHitHead = 0;
		o.m.DirectDamageMult = 0.3;
});
::mods_hookNewObject("items/weapons/rondel_dagger", function(o) 
{
		o.m.Condition = 50.0;
		o.m.ConditionMax = 50.0;
		o.m.Value = 400;
		o.m.StaminaModifier = -3;
		o.m.RegularDamage = 25;
		o.m.RegularDamageMax = 35;
		o.m.ArmorDamageMult = 0.65;
		o.m.DirectDamageMult = 0.35;
});
::mods_hookNewObject("items/weapons/scimitar", function(o) 
{
		o.m.Value = 1000;
		o.m.Condition = 48.0;
		o.m.ConditionMax = 48.0;
		o.m.StaminaModifier = -6;
		o.m.RegularDamage = 45;
		o.m.RegularDamageMax = 50;
		o.m.ArmorDamageMult = 0.55;
		o.m.DirectDamageMult = 0.20;
});
::mods_hookNewObject("items/weapons/scramasax", function(o) 
{
		o.m.Value = 700;
		o.m.Condition = 56.0;
		o.m.ConditionMax = 56.0;
		o.m.StaminaModifier = -8;
		o.m.RegularDamage = 35;
		o.m.RegularDamageMax = 50;
		o.m.ArmorDamageMult = 0.76;
		o.m.DirectDamageMult = 0.22;
});
::mods_hookNewObject("items/weapons/shamshir", function(o) 
{
		o.m.Value = 2200;
		o.m.Condition = 72.0;
		o.m.ConditionMax = 72.0;
		o.m.StaminaModifier = -8;
		o.m.RegularDamage = 50;
		o.m.RegularDamageMax = 55;
		o.m.ArmorDamageMult = 0.60;
		o.m.DirectDamageMult = 0.20;
});
::mods_hookNewObject("items/weapons/shortsword", function(o) 
{
		o.m.ID = "weapon.shortsword";
		o.m.Name = "Короткий меч";
		o.m.Description = "Короткий необработанный железный меч с несколькими вмятинами и зазубринами, которым легко орудовать одной рукой.";
		o.m.Categories = "Меч, одноручное";
		o.m.IconLarge = "weapons/melee/sword_001.png";
		o.m.Icon = "weapons/melee/sword_001_70x70.png";
		o.m.SlotType = this.Const.ItemSlot.Mainhand;
		o.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		o.m.IsDoubleGrippable = true;
		o.m.AddGenericSkill = true;
		o.m.ShowQuiver = false;
		o.m.ShowArmamentIcon = true;
		o.m.ArmamentIcon = "icon_sword_001";
		o.m.Value = 350;
		o.m.Condition = 48.0;
		o.m.ConditionMax = 48.0;
		o.m.StaminaModifier = -4;
		o.m.RegularDamage = 35;
		o.m.RegularDamageMax = 45;
		o.m.ArmorDamageMult = 0.60;
		o.m.DirectDamageMult = 0.20;
});
::mods_hookNewObject("items/weapons/spetum", function(o) 
{
		o.m.Value = 850;
		o.m.ShieldDamage = 0;
		o.m.Condition = 60.0;
		o.m.ConditionMax = 60.0;
		o.m.StaminaModifier = -14;
		o.m.RangeMin = 1;
		o.m.RangeMax = 2;
		o.m.RangeIdeal = 2;
		o.m.RegularDamage = 55;
		o.m.RegularDamageMax = 75;
		o.m.ArmorDamageMult = 1.0;
		o.m.DirectDamageMult = 0.3;
		o.m.ChanceToHitHead = 5;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local prong = this.new("scripts/skills/actives/prong_skill");
		this.addSkill(prong);
		local spearwall = this.new("scripts/skills/actives/spearwalls");
		spearwall.m.Icon = "skills/active_124.png";
		spearwall.m.IconDisabled = "skills/active_124_sw.png";
		spearwall.m.Overlay = "active_124";
		spearwall.m.BaseAttackName = prong.getName();
		spearwall.setFatigueCost(spearwall.getFatigueCostRaw() + 5);
		this.addSkill(spearwall);
	}
});
::mods_hookNewObject("items/weapons/staff_sling", function(o) 
{
		o.m.BlockedSlotType = null;
		o.m.AddGenericSkill = true;
		o.m.IsDoubleGrippable = true;
		o.m.ShowQuiver = true;
		o.m.ShowArmamentIcon = true;
		o.m.ArmamentIcon = "icon_sling_01";
		o.m.Value = 150;
		o.m.StaminaModifier = -4;
		o.m.RangeMin = 2;
		o.m.RangeMax = 6;
		o.m.RangeIdeal = 6;
		o.m.Condition = 50.0;
		o.m.ConditionMax = 50.0;
		o.m.RegularDamage = 20;
		o.m.RegularDamageMax = 35;
		o.m.ArmorDamageMult = 0.9;
		o.m.DirectDamageMult = 0.25;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local sling_stone = this.new("scripts/skills/actives/sling_stone_skill");
		sling_stone.m.DirectDamageMult = 0.25;
		this.addSkill(sling_stone);
		this.addSkill(this.new("scripts/skills/actives/sling_ball_skill"));
	}
});
::mods_hookNewObject("items/weapons/three_headed_flail", function(o) 
{
		o.m.IsDoubleGrippable = true;
		o.m.IsAgainstShields = true;
		o.m.AddGenericSkill = true;
		o.m.ShowQuiver = false;
		o.m.ShowArmamentIcon = true;
		o.m.ArmamentIcon = "icon_flail_three_headed_01";
		o.m.Value = 1600;
		o.m.ShieldDamage = 0;
		o.m.Condition = 60.0;
		o.m.ConditionMax = 60.0;
		o.m.StaminaModifier = -10;
		o.m.RegularDamage = 30;
		o.m.RegularDamageMax = 75;
		o.m.ArmorDamageMult = 1.0;
		o.m.DirectDamageMult = 0.3;
		o.m.ChanceToHitHead = 0;
});
::mods_hookNewObject("items/weapons/throwing_spear", function(o) 
{
	o.m.Value = 400;
	o.m.Ammo = 1;
	o.m.AmmoMax = 1;
	o.m.AmmoCost = 6;
	o.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Defensive;
	
	o.getTooltip = function()
	{
		local result = o.weapon.getTooltip();
		return result;
	}
	
	o.isAmountShown = function()
	{
		return true;
	}

	o.getAmountString = function()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}
	
	o.setAmmo = function( _a )
	{
		this.m.Ammo = _a;

		if (this.m.Ammo > 0)
		{
			this.m.Name = "Метательное копьё";
			this.m.IconLarge = "weapons/ranged/throwing_spear_01.png";
			this.m.Icon = "weapons/ranged/throwing_spear_01_70x70.png";
			this.m.ShowArmamentIcon = true;
		}
		else
		{
			this.m.Name = "Метательное копьё (использовано)";
			this.m.IconLarge = "weapons/ranged/javelins_01_bag.png";
			this.m.Icon = "weapons/ranged/javelins_01_bag_70x70.png";
			this.m.ShowArmamentIcon = false;
		}

		this.updateAppearance();
	}
	
	o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/throw_sper_skill"));
		this.addSkill(this.new("scripts/skills/actives/throw_spear_skill"));
	}
});
::mods_hookNewObject("items/weapons/two_handed_flail", function(o) 
{
		o.m.AddGenericSkill = true;
		o.m.ShowQuiver = false;
		o.m.ShowArmamentIcon = true;
		o.m.ArmamentIcon = "icon_flail_two_handed_02";
		o.m.Value = 1800;
		o.m.ShieldDamage = 0;
		o.m.Condition = 80.0;
		o.m.ConditionMax = 80.0;
		o.m.StaminaModifier = -16;
		o.m.RegularDamage = 50;
		o.m.RegularDamageMax = 80;
		o.m.ArmorDamageMult = 1.15;
		o.m.DirectDamageMult = 0.3;
		o.m.ChanceToHitHead = 15;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/pound");
		skill.m.Icon = "skills/active_129.png";
		skill.m.IconDisabled = "skills/active_129_sw.png";
		skill.m.Overlay = "active_129";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/thresh");
		skill.m.Icon = "skills/active_130.png";
		skill.m.IconDisabled = "skills/active_130_sw.png";
		skill.m.Overlay = "active_130";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/pounds");
		skill.m.Icon = "skills/distant_pound.png";
		skill.m.IconDisabled = "skills/distant_pound_sw.png";
		skill.m.Overlay = "distant_pound";
		this.addSkill(skill);
	}
});
::mods_hookNewObject("items/weapons/two_handed_flanged_mace", function(o) 
{
		o.m.Value = 1900;
		o.m.ShieldDamage = 26;
		o.m.Condition = 120.0;
		o.m.ConditionMax = 120.0;
		o.m.StaminaModifier = -16;
		o.m.RegularDamage = 75;
		o.m.RegularDamageMax = 95;
		o.m.ArmorDamageMult = 1.25;
		o.m.DirectDamageMult = 0.4;
		o.m.ChanceToHitHead = 0;
});
::mods_hookNewObject("items/weapons/two_handed_mace", function(o) 
{
		o.m.Value = 1000;
		o.m.ShieldDamage = 20;
		o.m.Condition = 80.0;
		o.m.ConditionMax = 80.0;
		o.m.StaminaModifier = -14;
		o.m.RegularDamage = 50;
		o.m.RegularDamageMax = 75;
		o.m.ArmorDamageMult = 1.15;
		o.m.DirectDamageMult = 0.4;
		o.m.ChanceToHitHead = 0;
});
::mods_hookNewObject("items/weapons/two_handed_wooden_flail", function(o) 
{
		o.m.Value = 500;
		o.m.ShieldDamage = 0;
		o.m.Condition = 56.0;
		o.m.ConditionMax = 56.0;
		o.m.StaminaModifier = -14;
		o.m.RegularDamage = 35;
		o.m.RegularDamageMax = 60;
		o.m.ArmorDamageMult = 0.8;
		o.m.DirectDamageMult = 0.3;
		o.m.ChanceToHitHead = 15;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/pound");
		skill.m.Icon = "skills/active_129.png";
		skill.m.IconDisabled = "skills/active_129_sw.png";
		skill.m.Overlay = "active_129";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/thresh");
		skill.m.Icon = "skills/active_130.png";
		skill.m.IconDisabled = "skills/active_130_sw.png";
		skill.m.Overlay = "active_130";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/pounds");
		skill.m.Icon = "skills/distant_pound.png";
		skill.m.IconDisabled = "skills/distant_pound_sw.png";
		skill.m.Overlay = "distant_pound";
		this.addSkill(skill);
	}
});
::mods_hookNewObject("items/weapons/warbrand", function(o) 
{
		o.m.Value = 1800;
		o.m.ShieldDamage = 0;
		o.m.Condition = 64.0;
		o.m.ConditionMax = 64.0;
		o.m.StaminaModifier = -10;
		o.m.RegularDamage = 60;
		o.m.RegularDamageMax = 75;
		o.m.ArmorDamageMult = 0.75;
		o.m.DirectDamageMult = 0.2;
		o.m.ChanceToHitHead = 5;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local slash = this.new("scripts/skills/actives/warbrand_slash");
		slash.m.FatigueCost = 13;
		this.addSkill(slash);
		this.addSkill(this.new("scripts/skills/actives/split"));
		this.addSkill(this.new("scripts/skills/actives/swing"));
	}
});
::mods_hookNewObject("items/weapons/warfork", function(o) 
{
		o.m.Value = 400;
		o.m.ShieldDamage = 0;
		o.m.Condition = 50.0;
		o.m.ConditionMax = 50.0;
		o.m.StaminaModifier = -10;
		o.m.RangeMin = 1;
		o.m.RangeMax = 2;
		o.m.RangeIdeal = 2;
		o.m.RegularDamage = 40;
		o.m.RegularDamageMax = 60;
		o.m.ArmorDamageMult = 0.90;
		o.m.DirectDamageMult = 0.3;
		o.m.ChanceToHitHead = 5;
		
	o.onEquip = function()
	{
		this.weapon.onEquip();
		local prong = this.new("scripts/skills/actives/prong_skill");
		prong.m.Icon = "skills/active_174.png";
		prong.m.IconDisabled = "skills/active_174_sw.png";
		prong.m.Overlay = "active_174";
		this.addSkill(prong);
		local spearwall = this.new("scripts/skills/actives/spearwalls");
		spearwall.m.Icon = "skills/active_173.png";
		spearwall.m.IconDisabled = "skills/active_173_sw.png";
		spearwall.m.Overlay = "active_173";
		spearwall.m.BaseAttackName = prong.getName();
		spearwall.setFatigueCost(spearwall.getFatigueCostRaw() + 5);
		this.addSkill(spearwall);
	}
});
::mods_hookNewObject("items/weapons/warhammer", function(o) 
{
		o.m.Value = 1800;
		o.m.ShieldDamage = 0;
		o.m.Condition = 100.0;
		o.m.ConditionMax = 100.0;
		o.m.StaminaModifier = -10;
		o.m.RegularDamage = 30;
		o.m.RegularDamageMax = 40;
		o.m.ArmorDamageMult = 2.25;
		o.m.DirectDamageMult = 0.5;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/hammer"));
		this.addSkill(this.new("scripts/skills/actives/crush_armor"));
	}
});
::mods_hookNewObject("items/weapons/winged_mace", function(o) 
{
		o.m.Value = 1700;
		o.m.ShieldDamage = 0;
		o.m.Condition = 80.0;
		o.m.ConditionMax = 80.0;
		o.m.StaminaModifier = -10;
		o.m.RegularDamage = 35;
		o.m.RegularDamageMax = 55;
		o.m.ArmorDamageMult = 1.1;
		o.m.DirectDamageMult = 0.4;
});
::mods_hookNewObject("items/weapons/woodcutters_axe", function(o) 
{
		o.m.Value = 400;
		o.m.ShieldDamage = 30;
		o.m.Condition = 48.0;
		o.m.ConditionMax = 48.0;
		o.m.StaminaModifier = -14;
		o.m.RegularDamage = 45;
		o.m.RegularDamageMax = 70;
		o.m.ArmorDamageMult = 1.25;
		o.m.DirectDamageMult = 0.4;
		o.m.ChanceToHitHead = 0;
});
::mods_hookNewObject("items/weapons/wooden_flail", function(o) 
{
		o.m.IsAgainstShields = true;
		o.m.AddGenericSkill = true;
		o.m.ShowQuiver = false;
		o.m.ShowArmamentIcon = true;
		o.m.ArmamentIcon = "icon_flail_02";
		o.m.Value = 40;
		o.m.ShieldDamage = 0;
		o.m.Condition = 32.0;
		o.m.ConditionMax = 32.0;
		o.m.StaminaModifier = -6;
		o.m.RegularDamage = 15;
		o.m.RegularDamageMax = 25;
		o.m.ArmorDamageMult = 0.6;
		o.m.DirectDamageMult = 0.3;
		o.m.ChanceToHitHead = 0;
});
})
