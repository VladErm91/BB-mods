::mods_registerMod("mod_goblin_wolfrider", 1.8, "True Balance Mod Goblin Wolfrider");
::mods_queue("mod_goblin_wolfrider", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.m.Type == this.Const.EntityType.GoblinWolfrider)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_goblin_wolfrider_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
::mods_hookBaseClass("entity/tactical/goblin", function ( a )
{
	while (!("onAfterInit" in a))
	{
		a = a[a.SuperName];
	}

	local onAfterInit = a.onAfterInit;
	a.onAfterInit = function ()
	{
		onAfterInit();

		if (this.m.Type == this.Const.EntityType.GoblinWolfrider)
		{
			this.m.Skills.add(this.new("scripts/skills/effects/wolfrider_effect"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
			}
			
			local b = this.m.BaseProperties;
			b.AdditionalActionPointCost = -1;
			local wolf_bite = this.new("scripts/skills/actives/wolf_bite");
			wolf_bite.setRestrained(true);
			wolf_bite.m.ActionPointCost = 0;
		}
	};
});
})