::mods_registerMod("mod_oriental_weapon", 1.8, "True Balance Mod Oriental Weapon");
::mods_queue("mod_oriental_weapon", "mod_true_balance", function() {
::mods_hookNewObject("items/weapons/oriental/composite_bow", function(o) 
{
		o.m.Value = 600;
		o.m.StaminaModifier = -6;
		o.m.RangeMin = 2;
		o.m.RangeMax = 7;
		o.m.RangeIdeal = 7;
		o.m.Condition = 80.0;
		o.m.ConditionMax = 80.0;
		o.m.RegularDamage = 40;
		o.m.RegularDamageMax = 55;
		o.m.ArmorDamageMult = 0.7;
		o.m.DirectDamageMult = 0.35;
});
::mods_hookNewObject("items/weapons/oriental/firelance", function(o) 
{
		o.m.Condition = 48.0;
		o.m.ConditionMax = 48.0;
		o.m.StaminaModifier = -12;
		o.m.RegularDamage = 30;
		o.m.RegularDamageMax = 35;
		o.m.ArmorDamageMult = 1.1;
		o.m.DirectDamageMult = 0.30;
		o.m.ShieldDamage = 0;
		o.m.ChanceToHitHead = 0;
		o.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.MeleeWeapon;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local thrust = this.new("scripts/skills/actives/thrust");
		thrust.m.DirectDamageMult = 0.30;
		this.addSkill(thrust);
		this.addSkill(this.new("scripts/skills/actives/ignite_firelance_skill"));
	}
});
::mods_hookNewObject("items/weapons/oriental/handgonne", function(o) 
{
		o.m.StaminaModifier = -12;
		o.m.Condition = 60.0;
		o.m.ConditionMax = 60.0;
		o.m.RegularDamage = 40;
		o.m.RegularDamageMax = 55;
		o.m.ArmorDamageMult = 1.0;
		o.m.DirectDamageMult = 0.35;

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
::mods_hookNewObject("items/weapons/oriental/heavy_southern_mace", function(o) 
{
		o.m.Value = 1700;
		o.m.ShieldDamage = 0;
		o.m.Condition = 80.0;
		o.m.ConditionMax = 80.0;
		o.m.StaminaModifier = -10;
		o.m.RegularDamage = 35;
		o.m.RegularDamageMax = 50;
		o.m.ArmorDamageMult = 1.2;
		o.m.DirectDamageMult = 0.4;
});
::mods_hookNewObject("items/weapons/oriental/light_southern_mace", function(o) 
{
		o.m.Value = 400;
		o.m.ShieldDamage = 0;
		o.m.Condition = 72.0;
		o.m.ConditionMax = 72.0;
		o.m.StaminaModifier = -8;
		o.m.RegularDamage = 30;
		o.m.RegularDamageMax = 40;
		o.m.ArmorDamageMult = 1.1;
		o.m.DirectDamageMult = 0.4;
});
::mods_hookNewObject("items/weapons/oriental/nomad_mace", function(o) 
{
		o.m.Condition = 64.0;
		o.m.ConditionMax = 64.0;
		o.m.StaminaModifier = -7;
		o.m.RegularDamage = 25;
		o.m.RegularDamageMax = 35;
		o.m.ArmorDamageMult = 0.9;
		o.m.DirectDamageMult = 0.4;
});
::mods_hookNewObject("items/weapons/oriental/nomad_sling", function(o) 
{
		o.m.BlockedSlotType = null;
		o.m.IsDoubleGrippable = true;
		o.m.Value = 300;
		o.m.StaminaModifier = -6;
		o.m.RangeMin = 2;
		o.m.RangeMax = 6;
		o.m.RangeIdeal = 6;
		o.m.Condition = 56.0;
		o.m.ConditionMax = 56.0;
		o.m.RegularDamage = 25;
		o.m.RegularDamageMax = 40;
		o.m.ArmorDamageMult = 1.0;
		o.m.DirectDamageMult = 0.30;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/sling_stone_skill"));
		this.addSkill(this.new("scripts/skills/actives/sling_balls_skill"));
	}
});
::mods_hookNewObject("items/weapons/oriental/qatal_dagger", function(o) 
{
		o.m.Condition = 60.0;
		o.m.ConditionMax = 60.0;
		o.m.StaminaModifier = -4;
		o.m.Value = 1000;
		o.m.RegularDamage = 30;
		o.m.RegularDamageMax = 40;
		o.m.ArmorDamageMult = 0.65;
		o.m.DirectDamageMult = 0.25;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local s = this.new("scripts/skills/actives/stab");
		s.m.Icon = "skills/active_198.png";
		s.m.IconDisabled = "skills/active_198_sw.png";
		s.m.Overlay = "active_198";
		s.m.DirectDamageMult = 0.25;
		this.addSkill(s);
		this.addSkill(this.new("scripts/skills/actives/deathblow_skill"));
	}
});
::mods_hookNewObject("items/weapons/oriental/saif", function(o) 
{
		o.m.Value = 350;
		o.m.Condition = 48.0;
		o.m.ConditionMax = 48.0;
		o.m.StaminaModifier = -4;
		o.m.RegularDamage = 40;
		o.m.RegularDamageMax = 45;
		o.m.ArmorDamageMult = 0.50;
		o.m.DirectDamageMult = 0.20;
});
::mods_hookNewObject("items/weapons/oriental/two_handed_saif", function(o) 
{
		o.m.Value = 2000;
		o.m.Condition = 54.0;
		o.m.ConditionMax = 54.0;
		o.m.StaminaModifier = -10;
		o.m.RegularDamage = 50;
		o.m.RegularDamageMax = 70;
		o.m.ArmorDamageMult = 0.9;
		o.m.DirectDamageMult = 0.25;

	o.onEquip = function()
	{
		this.weapon.onEquip();
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
::mods_hookNewObject("items/weapons/oriental/two_handed_scimitar", function(o) 
{
		o.m.ShieldDamage = 16;
		o.m.Condition = 64.0;
		o.m.ConditionMax = 64.0;
		o.m.StaminaModifier = -14;
		o.m.RegularDamage = 65;
		o.m.RegularDamageMax = 85;
		o.m.ArmorDamageMult = 1.1;
		o.m.DirectDamageMult = 0.25;

	o.onEquip = function()
	{
		this.weapon.onEquip();
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
})