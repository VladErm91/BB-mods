::mods_registerMod("mod_skeleton_heavy", 1.8, "True Balance Mod Skeleton Heavy");
::mods_queue("mod_skeleton_heavy", "mod_true_balance", function() {
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

		if (this.ClassName == "skeleton_heavy")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_skeleton_heavy_melee_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})