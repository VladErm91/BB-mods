::mods_registerMod("mod_slave", 1.8, "True Balance Mod Slave");
::mods_queue("mod_slave", "mod_true_balance", function() {
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

		if (this.ClassName == "slave" || this.ClassName == "slave_northern")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.BaseProperties.MeleeSkill += 5;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 30)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
			}
		}
	};
});
::mods_hookBaseClass("entity/tactical/human", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.ClassName == "slave")
		{
			this.getFlags().add("slave_minion");
		}
	};
});
})