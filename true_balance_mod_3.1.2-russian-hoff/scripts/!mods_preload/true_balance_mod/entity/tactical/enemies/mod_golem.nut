::mods_registerMod("mod_golem", 1.8, "True Balance Mod Golem");
::mods_queue("mod_golem", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.SandGolem)
		{
			local b = this.m.BaseProperties;
			b.IsImmuneToRoot = true;
		}
	};
});
})