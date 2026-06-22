::mods_registerMod("mod_warwolf", 1.8, "True Balance Mod WarWolf");
::mods_queue("mod_warwolf", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.Wolf)
		{
			local b = this.m.BaseProperties;
			b.DamageDirectMult = 1.25;
		}
	};
});
})