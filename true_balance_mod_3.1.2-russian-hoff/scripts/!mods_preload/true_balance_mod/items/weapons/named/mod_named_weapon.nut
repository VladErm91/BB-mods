::mods_registerMod("mod_named_weapon", 1.8, "True Balance Mod Named Weapon");
::mods_queue("mod_named_weapon", "mod_true_balance", function() {
::mods_hookNewObject("items/weapons/named/named_flail", function(o) 
{
		o.m.Condition = 72.0;
		o.m.ConditionMax = 72.0;
		o.m.StaminaModifier = -8;
		o.m.RegularDamage = 30;
		o.m.RegularDamageMax = 55;
		o.m.DirectDamageMult = 0.3;
		o.m.ArmorDamageMult = 1.1;
		o.m.ChanceToHitHead = 0;
		o.m.FatigueOnSkillUse = 0;
		o.randomizeValues();
});
::mods_hookBaseClass("items/weapons/named/named_weapon", function(o) 
{
	o.randomizeValues <- function()
	{
		if (this.m.ConditionMax > 1)
		{
			this.m.Condition = this.Math.round(this.m.Condition * this.Math.rand(90, 140) * 0.01) * 1.0;
			this.m.ConditionMax = this.m.Condition;
		}

		local available = [];
		available.push(function ( _i )
		{
			local f = this.Math.rand(110, 130) * 0.01;
			_i.m.RegularDamage = this.Math.round(_i.m.RegularDamage * f);
			_i.m.RegularDamageMax = this.Math.round(_i.m.RegularDamageMax * f);
		});
		available.push(function ( _i )
		{
			_i.m.ArmorDamageMult = _i.m.ArmorDamageMult + this.Math.rand(10, 30) * 0.01;
		});

		if (this.m.ChanceToHitHead > 0)
		{
			available.push(function ( _i )
			{
				_i.m.ChanceToHitHead = _i.m.ChanceToHitHead + this.Math.rand(10, 20);
			});
		}

		available.push(function ( _i )
		{
			_i.m.DirectDamageAdd = _i.m.DirectDamageAdd + this.Math.rand(8, 16) * 0.01;
		});

		if (this.m.StaminaModifier <= -10)
		{
			available.push(function ( _i )
			{
				_i.m.StaminaModifier = this.Math.round(_i.m.StaminaModifier * this.Math.rand(50, 80) * 0.01);
			});
		}

		if (this.m.AmmoMax > 0)
		{
			available.push(function ( _i )
			{
				_i.m.AmmoMax = _i.m.AmmoMax + this.Math.rand(1, 3);
				_i.m.Ammo = _i.m.AmmoMax;
			});
		}

		if (this.m.AdditionalAccuracy != 0 || this.isItemType(this.Const.Items.ItemType.RangedWeapon))
		{
			available.push(function ( _i )
			{
				_i.m.AdditionalAccuracy = _i.m.AdditionalAccuracy + this.Math.rand(5, 15);
			});
		}

		available.push(function ( _i )
		{
			_i.m.FatigueOnSkillUse = _i.m.FatigueOnSkillUse - this.Math.rand(1, 3);
		});

		for( local n = 2; n != 0 && available.len() != 0; n = --n )
		{
			local r = this.Math.rand(0, available.len() - 1);
			available[r](this);
			available.remove(r);
		}
	}
});	
::mods_hookNewObject("items/weapons/named/named_crypt_cleaver", function(o) 
{
o.m.ShieldDamage = o.m.ShieldDamage - 16;
o.m.Condition = o.m.Condition + 7;
o.m.ConditionMax = o.m.ConditionMax + 7;
	o.onEquip = function()
	{
		this.named_weapon.onEquip();
		local cleave = this.new("scripts/skills/actives/cleave");
		cleave.m.FatigueCost = 15;
		this.addSkill(cleave);
		local cleaves = this.new("scripts/skills/actives/decapitate");
		cleaves.m.FatigueCost = 25;
		this.addSkill(cleaves);
	}
});
::mods_hookNewObject("items/weapons/named/named_dagger", function(o) 
{
		o.m.RegularDamage = o.m.RegularDamage + 5;
		o.m.StaminaModifier = -3;
		o.m.RegularDamageMax = o.m.RegularDamageMax - 5;
		o.m.ArmorDamageMult = o.m.ArmorDamageMult - 5 * 0.01;
		o.m.DirectDamageMult = o.m.DirectDamageMult + 15 * 0.01;
});
::mods_hookNewObject("items/weapons/named/named_bladed_pike", function(o) 
{
		o.m.Condition = o.m.Condition + 13;
		o.m.ConditionMax = o.m.ConditionMax + 13;

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
::mods_hookNewObject("items/weapons/named/named_warscythe", function(o) 
{
		o.m.Condition = o.m.Condition + 10;
		o.m.ConditionMax = o.m.ConditionMax + 10;
});
::mods_hookNewObject("items/weapons/named/named_khopesh", function(o) 
{
		o.m.Condition = o.m.Condition + 5;
		o.m.ConditionMax = o.m.ConditionMax + 5;
});
::mods_hookNewObject("items/weapons/named/named_fencing_sword", function(o) 
{		
		o.m.RangeMin = 1;
		o.m.RangeMax = 2;
		o.m.RangeIdeal = 2;
		o.m.RegularDamage = o.m.RegularDamage + 5;
		o.m.RegularDamageMax = o.m.RegularDamageMax + 5;
		o.m.ArmorDamageMult = o.m.ArmorDamageMult - 15 * 0.01;
});
::mods_hookNewObject("items/weapons/named/named_goblin_falchion", function(o) 
{
		o.m.RegularDamage = o.m.RegularDamage + 10;
		o.m.RegularDamageMax = o.m.RegularDamageMax + 5;
		o.m.ArmorDamageMult = o.m.ArmorDamageMult - 1 * 0.1;
});
::mods_hookNewObject("items/weapons/named/named_goblin_heavy_bow", function(o) 
{
		o.m.RegularDamage = o.m.RegularDamage + 10;
		o.m.RegularDamageMax = o.m.RegularDamageMax + 5;
		o.m.Condition = o.m.Condition + 6.0;
		o.m.ConditionMax = o.m.ConditionMax + 6.0;
});
::mods_hookNewObject("items/weapons/named/named_goblin_pike", function(o) 
{
		o.m.RegularDamage = o.m.RegularDamage + 5;
		o.m.RegularDamageMax = o.m.RegularDamageMax + 5;
		o.m.Condition = o.m.Condition + 14.0;
		o.m.ConditionMax = o.m.ConditionMax + 14.0;
});
::mods_hookNewObject("items/weapons/named/named_goblin_spear", function(o) 
{
		o.m.RegularDamage = o.m.RegularDamage + 5;
		o.m.DirectDamageMult = o.m.DirectDamageMult + 10 * 0.01;
		o.m.Condition = o.m.Condition + 16.0;
		o.m.ConditionMax = o.m.ConditionMax + 16.0;
});
::mods_hookNewObject("items/weapons/named/named_handgonne", function(o) 
{
		o.m.RegularDamageMax = o.m.RegularDamageMax - 20;
		o.m.RegularDamage = o.m.RegularDamage + 5;
		o.m.DirectDamageMult = o.m.DirectDamageMult + 10 * 0.01;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/fire_handgonne_skill"));
		this.addSkill(this.new("scripts/skills/effects/nofire_effect"));

		if (!this.m.IsLoaded)
		{
			this.addSkill(this.new("scripts/skills/actives/reload_handgonne_skill"));
		}
	}
});
::mods_hookNewObject("items/weapons/named/named_pike", function(o) 
{
		o.m.DirectDamageMult = o.m.DirectDamageMult + 5 * 0.01;

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
		this.addSkill(long_impale);
	}
});
::mods_hookNewObject("items/weapons/named/named_qatal_dagger", function(o) 
{
		o.m.StaminaModifier = -4;
		o.m.RegularDamageMax = o.m.RegularDamageMax - 5;
		o.m.ArmorDamageMult = o.m.ArmorDamageMult - 5 * 0.01;
		o.m.DirectDamageMult = o.m.DirectDamageMult + 5 * 0.01;

	o.onEquip = function()
	{
		this.named_weapon.onEquip();
		local s = this.new("scripts/skills/actives/stab");
		s.m.Icon = "skills/active_198.png";
		s.m.IconDisabled = "skills/active_198_sw.png";
		s.m.Overlay = "active_198";
		s.m.DirectDamageMult = 0.25;
		this.addSkill(s);
		this.addSkill(this.new("scripts/skills/actives/deathblow_skill"));
	}
});
::mods_hookNewObject("items/weapons/named/named_rusty_warblade", function(o) 
{
o.m.ShieldDamage = o.m.ShieldDamage - 16;
o.m.Condition = o.m.Condition + 5;
o.m.ConditionMax = o.m.ConditionMax + 5;
	o.onEquip = function()
	{
		this.named_weapon.onEquip();
		local cleave = this.new("scripts/skills/actives/cleave");
		cleave.m.Icon = "skills/active_182.png";
		cleave.m.IconDisabled = "skills/active_182_sw.png";
		cleave.m.Overlay = "active_182";
		cleave.m.FatigueCost = 15;
		this.addSkill(cleave);
		local cleaves = this.new("scripts/skills/actives/decapitate");
		cleaves.m.FatigueCost = 25;
		this.addSkill(cleaves);
	}
});
::mods_hookNewObject("items/weapons/named/named_shamshir", function(o) 
{
		o.m.RegularDamage = o.m.RegularDamage + 5;
		o.m.RegularDamageMax = o.m.RegularDamageMax + 5;
		o.m.ArmorDamageMult = o.m.ArmorDamageMult - 15 * 0.01;
});
::mods_hookNewObject("items/weapons/named/named_spear", function(o) 
{
		o.m.DirectDamageMult = o.m.DirectDamageMult + 10 * 0.01;
});
::mods_hookNewObject("items/weapons/named/named_spetum", function(o) 
{
		o.m.DirectDamageMult = o.m.DirectDamageMult + 5 * 0.01;

	o.onEquip = function()
	{
		this.named_weapon.onEquip();
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
::mods_hookNewObject("items/weapons/named/named_sword", function(o) 
{
		o.m.RegularDamage = o.m.RegularDamage + 5;
		o.m.RegularDamageMax = o.m.RegularDamageMax + 5;
		o.m.ArmorDamageMult = o.m.ArmorDamageMult - 15 * 0.01;
});
::mods_hookNewObject("items/weapons/named/named_three_headed_flail", function(o) 
{
		o.m.Condition = 60.0;
		o.m.ConditionMax = 60.0;
		o.m.StaminaModifier = -10;
		o.m.RegularDamage = 30;
		o.m.RegularDamageMax = 75;
		o.m.DirectDamageMult = 0.3;
		o.m.ArmorDamageMult = 1.0;
		o.m.ChanceToHitHead = 0;
		o.m.FatigueOnSkillUse = 0;
		o.randomizeValues();
});
::mods_hookNewObject("items/weapons/named/named_two_handed_flail", function(o) 
{
	o.m.RegularDamage = o.m.RegularDamage + 5;
	o.m.RegularDamageMax = o.m.RegularDamageMax - 10;
	o.m.ArmorDamageMult = o.m.ArmorDamageMult + 5 * 0.01;
	o.onEquip = function()
	{
		this.named_weapon.onEquip();
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
::mods_hookNewObject("items/weapons/named/named_two_handed_mace", function(o) 
{
		o.m.DirectDamageMult = o.m.DirectDamageMult - 10 * 0.01;
});
::mods_hookNewObject("items/weapons/named/named_two_handed_scimitar", function(o) 
{
o.m.Value = 3800;
o.m.ShieldDamage = o.m.ShieldDamage - 16;
	o.onEquip = function()
	{
		this.named_weapon.onEquip();
		local cleave = this.new("scripts/skills/actives/cleave");
		cleave.m.Icon = "skills/active_210.png";
		cleave.m.IconDisabled = "skills/active_210_sw.png";
		cleave.m.Overlay = "active_210";
		cleave.m.FatigueCost = 15;
		this.addSkill(cleave);
		local cleaves = this.new("scripts/skills/actives/decapitate");
		cleaves.m.FatigueCost = 25;
		this.addSkill(cleaves);
	}
});
::mods_hookNewObject("items/weapons/named/named_two_handed_spiked_mace", function(o) 
{
		o.m.DirectDamageMult = o.m.DirectDamageMult - 10 * 0.01;
		o.m.RegularDamage = o.m.RegularDamage + 10;
		o.m.RegularDamageMax = o.m.RegularDamageMax + 10;
});
::mods_hookNewObject("items/weapons/named/named_skullhammer", function(o) 
{
		o.m.RegularDamage = o.m.RegularDamage + 5;
		o.m.RegularDamageMax = o.m.RegularDamageMax + 10;
});
::mods_hookNewObject("items/weapons/named/named_warbrand", function(o) 
{
		o.m.RegularDamage = o.m.RegularDamage + 10;

	o.onEquip = function()
	{
		this.named_weapon.onEquip();
		local slash = this.new("scripts/skills/actives/warbrand_slash");
		slash.m.FatigueCost = 13;
		this.addSkill(slash);
		this.addSkill(this.new("scripts/skills/actives/split"));
		this.addSkill(this.new("scripts/skills/actives/swing"));
	}
});
::mods_hookNewObject("items/weapons/named/named_warhammer", function(o) 
{
		o.m.StaminaModifier = o.m.StaminaModifier - 2;
		o.m.Value = 3800;
});
::mods_hookNewObject("items/weapons/named/named_axe", function(o) 
{
		o.m.Value = 3900;
});
::mods_hookNewObject("items/weapons/named/named_mace", function(o) 
{
		o.m.Value = 3700;
});
::mods_hookNewObject("items/weapons/named/named_greataxe", function(o) 
{
		o.m.Value = 4200;
});
::mods_hookNewObject("items/weapons/named/named_two_handed_mace", function(o) 
{
		o.m.Value = 3900;
});
})