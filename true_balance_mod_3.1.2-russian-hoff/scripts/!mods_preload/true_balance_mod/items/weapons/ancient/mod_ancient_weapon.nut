::mods_registerMod("mod_ancient_weapon", 1.8, "True Balance Mod Ancient Weapon");
::mods_queue("mod_ancient_weapon", "mod_true_balance", function() {
::mods_hookNewObject("items/weapons/ancient/ancient_spear", function(o) 
{
		o.m.IsDoubleGrippable = true;
		o.m.AddGenericSkill = true;
		o.m.ShowQuiver = false;
		o.m.ShowArmamentIcon = true;
		o.m.ArmamentIcon = "icon_ancient_spear_01";
		o.m.Value = 150;
		o.m.Condition = 36.0;
		o.m.ConditionMax = 36.0;
		o.m.StaminaModifier = -6;
		o.m.RegularDamage = 20;
		o.m.RegularDamageMax = 35;
		o.m.ArmorDamageMult = 1.0;
		o.m.DirectDamageMult = 0.30;
});
::mods_hookNewObject("items/weapons/ancient/rhomphaia", function(o) 
{
		o.m.Value = 1300;
		o.m.ShieldDamage = 0;
		o.m.Condition = 48.0;
		o.m.ConditionMax = 48.0;
		o.m.StaminaModifier = -10;
		o.m.RegularDamage = 55;
		o.m.RegularDamageMax = 65;
		o.m.ArmorDamageMult = 1.05;
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
::mods_hookNewObject("items/weapons/ancient/crypt_cleaver", function(o) 
{
		o.m.Value = 2000;
		o.m.Condition = 48.0;
		o.m.ConditionMax = 48.0;
		o.m.StaminaModifier = -16;
		o.m.RegularDamage = 60;
		o.m.RegularDamageMax = 80;
		o.m.ArmorDamageMult = 1.2;
		o.m.DirectDamageMult = 0.25;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local cleave = this.new("scripts/skills/actives/cleave");
		cleave.m.FatigueCost = 15;
		this.addSkill(cleave);
		local cleaves = this.new("scripts/skills/actives/decapitate");
		cleaves.m.FatigueCost = 25;
		this.addSkill(cleaves);
	}
});
::mods_hookNewObject("items/weapons/ancient/ancient_sword", function(o) 
{
		o.m.Value = 850;
		o.m.Condition = 42.0;
		o.m.ConditionMax = 42.0;
		o.m.StaminaModifier = -6;
		o.m.RegularDamage = 43;
		o.m.RegularDamageMax = 48;
		o.m.ArmorDamageMult = 0.65;
		o.m.DirectDamageMult = 0.20;
});
::mods_hookNewObject("items/weapons/ancient/bladed_pike", function(o) 
{
		o.m.Value = 600;
		o.m.ShieldDamage = 0;
		o.m.Condition = 30.0;
		o.m.ConditionMax = 30.0;
		o.m.StaminaModifier = -14;
		o.m.RangeMin = 1;
		o.m.RangeMax = 2;
		o.m.RangeIdeal = 2;
		o.m.RegularDamage = 55;
		o.m.RegularDamageMax = 80;
		o.m.ArmorDamageMult = 1.25;
		o.m.DirectDamageMult = 0.3;
		o.m.ChanceToHitHead = 5;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale");
		impale.m.Icon = "skills/active_54.png";
		impale.m.IconDisabled = "skills/active_54_sw.png";
		impale.m.Overlay = "active_54";
		impale.m.DirectDamageMult = 0.3;
		this.addSkill(impale);
		this.addSkill(this.new("scripts/skills/actives/repel"));
	}
});
::mods_hookNewObject("items/weapons/ancient/broken_ancient_sword", function(o) 
{
		o.m.Value = 200;
		o.m.Condition = 24.0;
		o.m.ConditionMax = 24.0;
		o.m.StaminaModifier = -3;
		o.m.RegularDamage = 35;
		o.m.RegularDamageMax = 40;
		o.m.ArmorDamageMult = 0.67;
		o.m.DirectDamageMult = 0.18;
});
::mods_hookNewObject("items/weapons/ancient/broken_bladed_pike", function(o) 
{
		o.m.Value = 350;
		o.m.ShieldDamage = 0;
		o.m.Condition = 26.0;
		o.m.ConditionMax = 26.0;
		o.m.StaminaModifier = -12;
		o.m.RangeMin = 1;
		o.m.RangeMax = 2;
		o.m.RangeIdeal = 2;
		o.m.RegularDamage = 35;
		o.m.RegularDamageMax = 55;
		o.m.ArmorDamageMult = 0.8;
		o.m.DirectDamageMult = 0.3;
		o.m.ChanceToHitHead = 5;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale");
		impale.m.Icon = "skills/active_54.png";
		impale.m.IconDisabled = "skills/active_54_sw.png";
		impale.m.Overlay = "active_54";
		impale.m.DirectDamageMult = 0.3;
		this.addSkill(impale);
		this.addSkill(this.new("scripts/skills/actives/repel"));
	}
});
})