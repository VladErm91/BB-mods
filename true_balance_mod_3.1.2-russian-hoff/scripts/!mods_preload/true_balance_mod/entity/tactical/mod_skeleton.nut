::mods_registerMod("mod_skeleton", 1.8, "True Balance Mod Skeleton");
::mods_queue("mod_skeleton", "mod_true_balance", function() {
::mods_hookDescendants("entity/tactical/skeleton", function (o) {

    while (!("onInit" in o)) o = o[o.SuperName];
    local onInit = o.onInit;        
    o.onInit = function() 
    {
        onInit()

		this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
		this.m.Skills.add(this.new("scripts/skills/effects/buckler_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_riposte"));
        this.m.Skills.add(this.new("scripts/skills/effects/ripostes_effect"));
		this.m.Skills.removeByID("perk.battle_forged");

		if (this.ClassName == "skeleton_medium_polearm" || this.ClassName == "skeleton_heavy_polearm")
		{
			this.m.Skills.add(this.new("scripts/skills/effects/skelet_polearm_effect"));
			this.m.ActionPoints = 10;
			this.m.BaseProperties.ActionPoints = 10;
			this.m.Skills.update();
		}	
		if (this.ClassName == "skeleton_priest")
		{
			this.m.Skills.removeByID("actives.rotation");
		}	
	}	
});
})

