::mods_registerMod("mod_goblin", 1.8, "True Balance Mod Goblin");
::mods_queue("mod_goblin", "mod_true_balance", function() {
::mods_hookDescendants("entity/tactical/goblin", function (o) {

    while (!("onInit" in o)) o = o[o.SuperName];
    local onInit = o.onInit;        
    o.onInit = function() 
    {
        onInit()

        this.m.Skills.add(this.new("scripts/skills/perks/perk_riposte"));
        this.m.Skills.add(this.new("scripts/skills/effects/ripostes_effect"));
        this.m.Skills.add(this.new("scripts/skills/effects/buckler_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recoversa"));
	}	
});
})

