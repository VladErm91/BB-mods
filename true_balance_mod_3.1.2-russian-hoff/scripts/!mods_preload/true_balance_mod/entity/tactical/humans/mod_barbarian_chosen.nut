::mods_registerMod("mod_barbarian_chosen", 1.8, "True Balance Mod Barbarian Chosen");
::mods_queue("mod_barbarian_chosen", "mod_true_balance", function() {
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

		if (this.ClassName == "barbarian_chosen")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		}
	};
});
})