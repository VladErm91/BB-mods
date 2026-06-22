::mods_registerMod("mod_legendary_weapon", 1.8, "True Balance Mod Legendary Weapon");
::mods_queue("mod_legendary_weapon", "mod_true_balance", function() {
::mods_hookNewObject("items/weapons/legendary/lightbringer_sword", function(o) 
{
		o.m.Condition = 90.0;
		o.m.ConditionMax = 90.0;
		o.m.StaminaModifier = -8;
		o.m.Value = 20000;
		o.m.RegularDamage = 55;
		o.m.RegularDamageMax = 60;
		o.m.ArmorDamageMult = 0.75;
		o.m.DirectDamageMult = 0.2;
});
::mods_hookNewObject("items/weapons/legendary/obsidian_dagger", function(o) 
{
		o.m.StaminaModifier = -3;
		o.m.RegularDamage = 30;
		o.m.RegularDamageMax = 40;
		o.m.ArmorDamageMult = 0.60;
		o.m.DirectDamageMult = 0.35;
});
})