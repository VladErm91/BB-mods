this.mod_spider_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.Spider;
		this.m.Properties.TargetPriorityHitchanceMult = 0.5;
		this.m.Properties.TargetPriorityHitpointsMult = 0.25;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.25;
		this.m.Properties.TargetPriorityFleeingMult = 0.75;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.75;
		this.m.Properties.OverallDefensivenessMult = 0.0;
		this.m.Properties.OverallFormationMult = 0.5;
		this.m.Properties.EngageAgainstSpearwallMult = 1.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.33;
		this.m.Properties.EngageFlankingMult = 1.6;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.5;
		this.m.Properties.EngageLockDownTargetMult = 2.0;
		this.m.Properties.PreferCarefulEngage = false;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_roam"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_rotation"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
	}

	function onUpdate()
	{
		if (this.getActor().getHitpointsPct() < 1.0 && this.Math.rand(1, 100) <= 25)
		{
			this.m.Properties.EngageAgainstSpearwallMult = 1.33;
		}
		else
		{
			this.m.Properties.EngageAgainstSpearwallMult = 1.0;
		}

		local eggs = 0;

		foreach( a in this.m.KnownAllies )
		{
			if (a.getType() == this.Const.EntityType.SpiderEggs)
			{
				eggs = ++eggs;
			}
		}

		if (!this.Tactical.State.isAutoRetreat() && eggs > 0)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Retreat] = 0.0;
		}
		else
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Retreat] = 1.0;
		}
	}

});

