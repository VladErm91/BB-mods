::mods_registerMod("mod_goblin_leader", 1.8, "True Balance Mod Goblin Leader");
::mods_queue("mod_goblin_leader", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.GoblinLeader)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 50)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
			}
		}	
	};
});
::mods_hookBaseClass("entity/tactical/goblin", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.m.Type == this.Const.EntityType.GoblinLeader)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_goblin_leader_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})