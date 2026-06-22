::mods_registerMod("mod_helmets", 1.8, "True Balance Mod Helmets");
::mods_queue("mod_helmets", "mod_true_balance", function() {
::mods_hookNewObject("items/helmets/barbute_helmet", function(o) 
{
		o.m.Value = 2000;
		o.m.Condition = 190;
		o.m.ConditionMax = 190;
		o.m.StaminaModifier = -9;
		o.m.Vision = -2;
});
::mods_hookNewObject("items/helmets/dented_nasal_helmet", function(o) 
{
		o.m.Value = 350;
		o.m.Condition = 110;
		o.m.ConditionMax = 110;
		o.m.StaminaModifier = -6;
		o.m.Vision = -1;
});
::mods_hookNewObject("items/helmets/reinforced_mail_coif", function(o) 
{
		o.m.Condition = 95;
		o.m.ConditionMax = 95;
		o.m.StaminaModifier = -4;
});
::mods_hookNewObject("items/helmets/greatsword_hat", function(o) 
{
		o.m.Condition = 80;
		o.m.ConditionMax = 80;
});
::mods_hookNewObject("items/helmets/oriental/gladiator_helmet", function(o) 
{
		o.m.StaminaModifier = -12;
});
::mods_hookNewObject("items/helmets/greatsword_faction_helm", function(o) 
{
		o.m.Value = 1800;
		o.m.Condition = 160;
		o.m.ConditionMax = 160;
		o.m.StaminaModifier = -7;
		o.m.Vision = -1;
});
::mods_hookNewObject("items/helmets/ancient/ancient_honorguard_helmet", function(o) 
{
		o.m.Value = 1000;
		o.m.Condition = 170;
		o.m.ConditionMax = 170;
		o.m.StaminaModifier = -11;
		o.m.Vision = -3;
});
::mods_hookNewObject("items/helmets/barbarians/crude_metal_helmet", function(o) 
{
		o.m.StaminaModifier = -10;
});
::mods_hookNewObject("items/helmets/barbarians/crude_faceguard_helmet", function(o) 
{
		o.m.StaminaModifier = -12;
});
::mods_hookNewObject("items/helmets/barbarians/closed_scrap_metal_helmet", function(o) 
{
		o.m.StaminaModifier = -14;
});
::mods_hookNewObject("items/helmets/barbarians/heavy_horned_plate_helmet", function(o) 
{
		o.m.StaminaModifier = -18;
});
})