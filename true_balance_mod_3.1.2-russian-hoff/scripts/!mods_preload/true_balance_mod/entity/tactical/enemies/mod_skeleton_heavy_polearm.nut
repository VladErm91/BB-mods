::mods_registerMod("mod_skeleton_heavy_polearm", 1.8, "True Balance Mod Skeleton Heavy Polearm");
::mods_queue("mod_skeleton_heavy_polearm", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/skeleton", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.ClassName == "skeleton_heavy_polearm")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_skeleton_heavy_polearm_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
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

		if (this.ClassName == "skeleton_heavy_polearm")
		{
			local b = this.m.BaseProperties;
			b.IsSpecializedInPolearms = true;
			this.m.Skills.add(this.new("scripts/skills/actives/long_impale_skeleton"));
		}
	};
});
})