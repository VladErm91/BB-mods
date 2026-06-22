::mods_registerMod("mod_goblin_shaman", 1.8, "True Balance Mod Goblin Shaman");
::mods_queue("mod_goblin_shaman", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.GoblinShaman)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_goblin_shaman_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})