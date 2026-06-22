::mods_registerMod("mod_goblin_ambusher", 1.8, "True Balance Mod Goblin Ambusher");
::mods_queue("mod_goblin_ambusher", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.GoblinAmbusher)
		{
			if (this.ClassName == "goblin_ambusher_low")
			{
				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 50)
				{
					local b = this.m.BaseProperties;
					b.IsSpecializedInBows = true;
					b.IsSpecializedInDaggers = true;
					b.Vision = 8;
					b.DamageDirectMult = 1.25;
					this.m.BaseProperties.MeleeSkill += 5;
					this.m.BaseProperties.RangedSkill += 5;
					this.m.BaseProperties.RangedDefense += 5;
					this.m.BaseProperties.MeleeDefense += 5;
					this.m.Skills.update();

					if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 180)
					{
						b.DamageDirectMult = 1.35;
					}
				}	
			}
			else
			{
				local b = this.m.BaseProperties;
				b.IsSpecializedInDaggers = true;
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_tm"));
			}
		}
	};
});
::mods_hookBaseClass("entity/tactical/goblin", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.m.Type == this.Const.EntityType.GoblinAmbusher)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_goblin_ranged_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})