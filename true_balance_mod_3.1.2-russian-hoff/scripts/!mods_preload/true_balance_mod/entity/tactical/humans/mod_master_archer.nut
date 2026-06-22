::mods_registerMod("mod_master_archer", 1.8, "True Balance Mod Master Archer");
::mods_queue("mod_master_archer", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("onAfterInit" in a))
	{
		a = a[a.SuperName];
	}

	local onAfterInit = a.onAfterInit;
	a.onAfterInit = function ()
	{
		onAfterInit();

		if (this.ClassName == "master_archer")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/effects/backstabber_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		}
	};
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

		if (this.ClassName == "master_archer")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bounty_hunter_ranged_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})