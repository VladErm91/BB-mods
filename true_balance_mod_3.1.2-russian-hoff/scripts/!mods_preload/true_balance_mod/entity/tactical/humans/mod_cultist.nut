::mods_registerMod("mod_cultist", 1.8, "True Balance Mod Cultist");
::mods_queue("mod_cultist", "mod_true_balance", function() {
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

		if (this.ClassName == "cultist")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
		}
	};
});
})