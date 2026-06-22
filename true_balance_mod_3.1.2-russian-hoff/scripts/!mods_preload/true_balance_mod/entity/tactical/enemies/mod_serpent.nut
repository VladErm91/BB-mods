::mods_registerMod("mod_serpent", 1.8, "True Balance Mod Serpent");
::mods_queue("mod_serpent", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.Serpent)
		{
			this.m.Skills.removeByID("perk.backstabber");

			if (this.World.getTime().Days >= 30)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			}
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

		if (this.m.Type == this.Const.EntityType.Serpent)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_serpent_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})