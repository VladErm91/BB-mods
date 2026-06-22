::mods_registerMod("mod_barbarian_madman", 1.8, "True Balance Mod Barbarian Madman");
::mods_queue("mod_barbarian_madman", "mod_true_balance", function() {
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

		if (this.ClassName == "barbarian_madman")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			local b = this.m.BaseProperties;
			b.IsImmuneToPoison = true;
		}
	};
});
})