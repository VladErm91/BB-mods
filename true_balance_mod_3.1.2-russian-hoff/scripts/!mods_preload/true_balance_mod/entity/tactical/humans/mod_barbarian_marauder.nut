::mods_registerMod("mod_barbarian_marauder", 1.8, "True Balance Mod Barbarian Marauder");
::mods_queue("mod_barbarian_marauder", "mod_true_balance", function() {
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

		if (this.ClassName == "barbarian_marauder")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.removeByID("perk.bullseye");

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
			}
		}
	};
});
})