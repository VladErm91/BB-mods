::mods_registerMod("mod_skeleton_elite", 1.8, "True Balance Mod Skeleton Elite");
::mods_queue("mod_skeleton_elite", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.SkeletonHeavy || this.m.Type == this.Const.EntityType.SkeletonBoss)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		}
	};
});
})