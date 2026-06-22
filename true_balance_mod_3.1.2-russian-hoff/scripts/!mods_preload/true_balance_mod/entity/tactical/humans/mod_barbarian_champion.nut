::mods_registerMod("mod_barbarian_champion", 1.8, "True Balance Mod Barbarian Champion");
::mods_queue("mod_barbarian_champion", "mod_true_balance", function() {
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

		if (this.ClassName == "barbarian_champion")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
		}
	};
});
})