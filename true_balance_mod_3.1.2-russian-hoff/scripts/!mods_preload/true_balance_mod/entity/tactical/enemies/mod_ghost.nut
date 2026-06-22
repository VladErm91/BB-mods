::mods_registerMod("mod_ghost", 1.8, "True Balance Mod Ghost");
::mods_queue("mod_ghost", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.Ghost)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_ghost_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
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

		if (this.m.Type == this.Const.EntityType.Ghost)
		{
			this.m.Skills.add(this.new("scripts/skills/effects/follen_movement_effect"));
		}
		
		if (this.ClassName == "ghost_knight")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_blend_in"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
			this.m.Skills.removeByID("perk.anticipation");
		}
	};
});
})