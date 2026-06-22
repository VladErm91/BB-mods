::mods_registerMod("mod_ghoul", 1.8, "True Balance Mod Ghoul");
::mods_queue("mod_ghoul", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.Ghoul)
		{
			this.m.Skills.add(this.new("scripts/skills/racial/ghoul_racial"));
		}
	};
});
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("onOtherActorDeath" in a))
	{
		a = a[a.SuperName];
	}

	a.onOtherActorDeath = function ( _killer, _victim, _skill )
	{
		if (!this.m.IsAlive || this.m.IsDying)
		{
			return;
		}

		if (_victim.getXPValue() <= 1)
		{
			return;
		}

		if (this.m.Type == this.Const.EntityType.Ghoul)
		{
			if (_victim.getType() == this.Const.EntityType.Zombie || _victim.getType() == this.Const.EntityType.ZombieBetrayer || _victim.getType() == this.Const.EntityType.ZombieBoss || _victim.getType() == this.Const.EntityType.ZombieKnight || _victim.getType() == this.Const.EntityType.ZombieYeoman || _victim.getType() == this.Const.EntityType.ZombieTreasureHunter && _victim.isAlliedWith(this))
			{
				return;
			}
		}

		if (_victim.getFaction() == this.getFaction() && _victim.getCurrentProperties().TargetAttractionMult >= 0.5 && this.getCurrentProperties().IsAffectedByDyingAllies)
		{
			local difficulty = this.Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * this.Const.Morale.AllyKilledXPMult + this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.AllyKilledDistancePow);
			this.checkMorale(-1, difficulty, this.Const.MoraleCheckType.Default, "", true);
		}
		else if (this.getAlliedFactions().find(_victim.getFaction()) == null)
		{
			local difficulty = this.Const.Morale.EnemyKilledBaseDifficulty + _victim.getXPValue() * this.Const.Morale.EnemyKilledXPMult - this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.EnemyKilledDistancePow);

			if (_killer != null && _killer.isAlive() && _killer.getID() == this.getID())
			{
				difficulty = difficulty + this.Const.Morale.EnemyKilledSelfBonus;
			}

			this.checkMorale(1, difficulty);
		}
	};
});
})