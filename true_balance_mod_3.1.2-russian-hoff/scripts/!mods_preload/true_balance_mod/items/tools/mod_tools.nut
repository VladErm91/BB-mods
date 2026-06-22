::mods_registerMod("mod_tools", 1.8, "True Balance Mod Tools");
::mods_queue("mod_tools", "mod_true_balance", function() {
::mods_hookNewObject("items/tools/player_banner", function(o) 
{
		o.m.StaminaModifier = -15;
		o.m.RangeMin = 1;
		o.m.RangeMax = 2;
		o.m.RangeIdeal = 2;
		o.m.RegularDamage = 50;
		o.m.RegularDamageMax = 70;
		o.m.ArmorDamageMult = 1.0;
		o.m.DirectDamageMult = 0.35;
		o.m.Variant = 5;
});
})