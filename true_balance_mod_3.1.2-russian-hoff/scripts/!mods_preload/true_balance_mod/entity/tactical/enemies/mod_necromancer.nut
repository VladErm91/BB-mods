::mods_registerMod("mod_necromancer", 1.8, "True Balance Mod Necromancer");
::mods_queue("mod_necromancer", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.Necromancer)
		{
			if (this.m.IsMiniboss)
			{
				this.m.Skills.add(this.new("scripts/skills/actives/raise_undead_champion"));
				this.m.Skills.removeByID("actives.raise_undead");
			}

			this.m.Skills.add(this.new("scripts/skills/perks/perk_false_believer"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
			}
	
			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
				this.m.Skills.add(this.new("scripts/skills/effects/perk_backstabber_effect"));
			}
		}
	};
});
})