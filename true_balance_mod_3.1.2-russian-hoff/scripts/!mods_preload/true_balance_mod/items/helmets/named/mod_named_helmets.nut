::mods_registerMod("mod_named_helmets", 1.8, "True Balance Mod Named Helmets");
::mods_queue("mod_named_helmets", "mod_true_balance", function() {
::mods_hookNewObject("items/helmets/named/named_steppe_helmet_with_mail", function(o) 
{
		o.m.Condition = o.m.Condition - 20;
		o.m.ConditionMax = o.m.ConditionMax - 20;
		o.m.StaminaModifier = o.m.StaminaModifier + 1;
});
::mods_hookNewObject("items/helmets/named/wolf_helmet", function(o) 
{
		o.m.StaminaModifier = o.m.StaminaModifier - 1;
});
::mods_hookNewObject("items/helmets/named/named_metal_skull_helmet", function(o) 
{
		o.m.Condition = o.m.Condition - 10;
		o.m.ConditionMax = o.m.ConditionMax - 10;
		o.m.StaminaModifier = o.m.StaminaModifier + 1;
});
::mods_hookNewObject("items/helmets/named/named_metal_nose_horn_helmet", function(o) 
{
		o.m.Condition = o.m.Condition - 10;
		o.m.ConditionMax = o.m.ConditionMax - 10;
		o.m.StaminaModifier = o.m.StaminaModifier + 1;
});
})