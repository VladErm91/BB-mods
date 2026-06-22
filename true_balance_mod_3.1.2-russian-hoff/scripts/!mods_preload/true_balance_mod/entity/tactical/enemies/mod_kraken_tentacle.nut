::mods_registerMod("mod_kraken_tentacle", 1.8, "True Balance Mod Kraken Tentacle");
::mods_queue("mod_kraken_tentacle", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.KrakenTentacle)
		{
			this.m.Skills.add(this.new("scripts/skills/effects/swamps_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_false_believer"));
		}
	};
});
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

		if (this.m.Type == this.Const.EntityType.KrakenTentacle)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_kraken_tentacle_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})