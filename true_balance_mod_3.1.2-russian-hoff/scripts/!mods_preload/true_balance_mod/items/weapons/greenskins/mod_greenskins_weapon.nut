::mods_registerMod("mod_greenskins_weapon", 1.8, "True Balance Mod Greenskins Weapon");
::mods_queue("mod_greenskins_weapon", "mod_true_balance", function() {
::mods_hookNewObject("items/weapons/greenskins/goblin_falchion", function(o) 
{
		o.m.Value = 900;
		o.m.Condition = 52.0;
		o.m.ConditionMax = 52.0;
		o.m.StaminaModifier = -4;
		o.m.RegularDamage = 40;
		o.m.RegularDamageMax = 50;
		o.m.ArmorDamageMult = 0.60;
		o.m.DirectDamageMult = 0.20;
});
::mods_hookNewObject("items/weapons/greenskins/goblin_notched_blade", function(o) 
{
		o.m.Value = 350;
		o.m.Categories = "Кинжал, одноручное";
		o.m.Condition = 44.0;
		o.m.ConditionMax = 44.0;
		o.m.StaminaModifier = -3;
		o.m.RegularDamage = 25;
		o.m.RegularDamageMax = 35;
		o.m.ArmorDamageMult = 0.6;
		o.m.DirectDamageMult = 0.25;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local slash = this.new("scripts/skills/actives/stab");
		slash.m.Icon = "skills/active_77.png";
		slash.m.IconDisabled = "skills/active_77_sw.png";
		slash.m.Overlay = "active_77";
		slash.m.DirectDamageMult = 0.25;
		this.addSkill(slash);
		this.addSkill(this.new("scripts/skills/actives/deathblow_skill"));
	}
});
::mods_hookNewObject("items/weapons/greenskins/goblin_spiked_balls", function(o) 
{
		o.m.RegularDamageMax = 30;
		o.m.ArmorDamageMult = 0.6;
		o.m.Ammo = 8;
		o.m.AmmoMax = 8;
		o.m.RangeMax = 3;

	o.getAmmoCost = function()
	{
		return 2;
	}
});
::mods_hookNewObject("items/weapons/greenskins/goblin_spear", function(o) 
{
		o.m.Value = 300;
		o.m.Condition = 36.0;
		o.m.ConditionMax = 36.0;
		o.m.StaminaModifier = -3;
		o.m.RegularDamage = 25;
		o.m.RegularDamageMax = 35;
		o.m.ArmorDamageMult = 0.7;
		o.m.DirectDamageMult = 0.35;
});
::mods_hookNewObject("items/weapons/greenskins/orc_flail_2h", function(o) 
{
		o.m.ArmamentIcon = "icon_orc_weapon_05";
		o.m.Value = 1300;
		o.m.ShieldDamage = 0;
		o.m.Condition = 64.0;
		o.m.ConditionMax = 64.0;
		o.m.StaminaModifier = -30;
		o.m.RegularDamage = 50;
		o.m.RegularDamageMax = 100;
		o.m.ArmorDamageMult = 1.25;
		o.m.DirectDamageMult = 0.3;
		o.m.ChanceToHitHead = 15;
		o.m.FatigueOnSkillUse = 5;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/pound");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/thresh");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/pounds");
		this.addSkill(skill)
	}
});
})
