::mods_registerMod("mod_human", 1.8, "True Balance Mod Human");
::mods_queue("mod_human", "mod_true_balance", function() {
::mods_hookDescendants("entity/tactical/human", function (o) {

    while (!("onInit" in o)) o = o[o.SuperName];
    local onInit = o.onInit;        
    o.onInit = function() 
    {
        onInit()

    	this.m.Skills.add(this.new("scripts/skills/actives/recovers_skill"));
       	this.m.Skills.add(this.new("scripts/skills/perks/perk_riposte"));
        this.m.Skills.add(this.new("scripts/skills/effects/ripostes_effect"));
       	this.m.Skills.add(this.new("scripts/skills/perks/perk_simple_weapon"));
       	this.m.Skills.add(this.new("scripts/skills/perks/perk_ijirok"));
       	this.m.Skills.add(this.new("scripts/skills/perks/perk_imperor"));
       	this.m.Skills.add(this.new("scripts/skills/perks/perk_davkul"));
		this.m.Skills.add(this.new("scripts/skills/effects/dagger_effect"));
		this.m.Skills.add(this.new("scripts/skills/effects/buckler_effect"));
	}
});	
::mods_hookBaseClass("entity/tactical/human", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.ClassName == "bandit_raider_low" || this.ClassName == "bandit_raider" || this.ClassName == "bandit_thug" || this.ClassName == "cultist" || this.ClassName == "nomad_cutthroat" || this.ClassName == "nomad_outlaw" || this.ClassName == "bandit_raider_wolf")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bandit_melee_agent");
			this.m.AIAgent.setActor(this);
		}

		if (this.ClassName == "bandit_leader" || this.ClassName == "nomad_leader")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bandit_leader_melee_agent");
			this.m.AIAgent.setActor(this);
		}

		if (this.ClassName == "bounty_hunter" || this.ClassName == "desert_devil" || this.ClassName == "executioner" || this.ClassName == "gladiator" || this.ClassName == "cultist" || this.ClassName == "hedge_knight" || this.ClassName == "mercenary" || this.ClassName == "mercenary_low" || this.ClassName == "swordmaster")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bounty_hunter_melee_agent");
			this.m.AIAgent.setActor(this);
		}

		if (this.ClassName == "hedge_knight")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_hedge_knight_melee_agent");
			this.m.AIAgent.setActor(this);
		}

		if (this.ClassName == "knight" || this.ClassName == "noble_greatsword")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_knight_melee_agent");
			this.m.AIAgent.setActor(this);
		}

		if (this.ClassName == "militia" || this.ClassName == "militia_captain" || this.ClassName == "militia_veteran")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_militia_melee_agent");
			this.m.AIAgent.setActor(this);
		}

		if (this.ClassName == "militia_ranged")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_militia_ranged_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})
