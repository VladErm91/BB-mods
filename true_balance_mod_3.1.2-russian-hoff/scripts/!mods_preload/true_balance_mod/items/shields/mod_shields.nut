::mods_registerMod("mod_shields", 1.8, "True Balance Mod Shields");
::mods_queue("mod_shields", "mod_true_balance", function() {
::mods_hookNewObject("items/shields/buckler_shield", function(o) 
{
	o.m.Condition = 5;
	o.m.ConditionMax = 5;
	o.onEquip = function()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}
});
::mods_hookNewObject("items/shields/greenskins/goblin_heavy_shield", function(o) 
{		
		o.m.Condition = 5;
		o.m.ConditionMax = 5;
		o.m.StaminaModifier = -5;
});
::mods_hookNewObject("items/shields/greenskins/goblin_light_shield", function(o) 
{
		o.m.Value = 30;
		o.m.Condition = 3;
		o.m.ConditionMax = 3;
		o.m.StaminaModifier = -3;
});
::mods_hookNewObject("items/shields/special/craftable_lindwurm_shield", function(o) 
{
		o.m.Condition = 72;
		o.m.ConditionMax = 72;
		o.m.MeleeDefense = 18;
});
})