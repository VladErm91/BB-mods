::mods_registerMod("mod_desert_devil", 1.8, "True Balance Mod Desert Devil");
::mods_queue("mod_desert_devil", "mod_true_balance", function() {
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

		if (this.ClassName == "desert_devil")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
		}
	};
});
::mods_hookExactClass("entity/tactical/humans/desert_devil", function ( a )
{
    a.onOtherActorDeath <- function ( _killer, _victim, _skill )
	{
		if (!this.m.IsAlive || this.m.IsDying)
		{
			return;
		}

		if (_victim.getType() == this.Const.EntityType.Slave && _victim.isAlliedWith(this))
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
		if (this.m.Type == this.Const.EntityType.BanditLeader || this.m.Type == this.Const.EntityType.BanditMarksman || this.m.Type == this.Const.EntityType.BanditPoacher || this.m.Type == this.Const.EntityType.BanditRaider || this.m.Type == this.Const.EntityType.BanditThug || this.m.Type == this.Const.EntityType.BarbarianBeastmaster || this.m.Type == this.Const.EntityType.BarbarianChampion || this.m.Type == this.Const.EntityType.BarbarianChosen || this.m.Type == this.Const.EntityType.BarbarianDrummer || this.m.Type == this.Const.EntityType.BarbarianMarauder || this.m.Type == this.Const.EntityType.BarbarianThrall || this.m.Type == this.Const.EntityType.BountyHunter || this.m.Type == this.Const.EntityType.DesertDevil || this.m.Type == this.Const.EntityType.DesertDevil || this.m.Type == this.Const.EntityType.DesertStalker || this.m.Type == this.Const.EntityType.Executioner || this.m.Type == this.Const.EntityType.Gladiator || this.m.Type == this.Const.EntityType.HedgeKnight || this.m.Type == this.Const.EntityType.Knight || this.m.Type == this.Const.EntityType.MasterArcher || this.m.Type == this.Const.EntityType.Mercenary || this.m.Type == this.Const.EntityType.MercenaryRanged || this.m.Type == this.Const.EntityType.Arbalester || this.m.Type == this.Const.EntityType.Billman || this.m.Type == this.Const.EntityType.Footman || this.m.Type == this.Const.EntityType.Greatsword || this.m.Type == this.Const.EntityType.Sergeant || this.m.Type == this.Const.EntityType.NomadArcher || this.m.Type == this.Const.EntityType.NomadCutthroat || this.m.Type == this.Const.EntityType.NomadLeader || this.m.Type == this.Const.EntityType.NomadOutlaw || this.m.Type == this.Const.EntityType.NomadSlinger || this.m.Type == this.Const.EntityType.Swordmaster)
		{
			if (_victim.getType() == this.Const.EntityType.Warhound || _victim.getType() == this.Const.EntityType.Wardog && _victim.isAlliedWith(this))
			{
				return;
			}
		}

		if (_victim.getFaction() == this.getFaction() && _victim.getCurrentProperties().TargetAttractionMult >= 0.5 && this.getCurrentProperties().IsAffectedByDyingAllies)
		{
			local difficulty = this.Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * this.Const.Morale.AllyKilledXPMult + this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.AllyKilledDistancePow);
			if (this.m.Skills.getSkillByID("effects.witnessed_execution") != null)
			{
				difficulty += 5
				this.getSkills().removeByID("effects.witnessed_execution");
			}
			
			this.checkMorale(-1, difficulty, this.Const.MoraleCheckType.Default, "", true);
		}
		else if (this.getAlliedFactions().find(_victim.getFaction()) == null)
		{
			local difficulty = this.Const.Morale.EnemyKilledBaseDifficulty + _victim.getXPValue() * this.Const.Morale.EnemyKilledXPMult - this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.EnemyKilledDistancePow);

			if (_killer != null && _killer.isAlive() && _killer.getID() == this.getID())
			{
				difficulty = difficulty + this.Const.Morale.EnemyKilledSelfBonus;
			}
			
			if (_killer != null && _killer.isAlive() && _killer.getID() == this.getID() && _killer.m.Skills.hasSkill("trait.bloodthirsty"))
			{
				difficulty = difficulty + 15;
			}

			this.checkMorale(1, difficulty);
		}
	}
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

		if (this.ClassName == "desert_devil")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bounty_hunter_melee_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})