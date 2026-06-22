::mods_registerMod("mod_kraken", 1.8, "True Balance Mod Kraken");
::mods_queue("mod_kraken", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.Kraken)
		{
			local b = this.m.BaseProperties;
			b.IsRooted = false;
			this.m.ActionPointCosts = this.Const.SameMovementAPCost;
			this.m.Skills.add(this.new("scripts/skills/effects/swamps_effect"));
			this.m.Skills.add(this.new("scripts/skills/effects/kraken_movement_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_false_believer"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_bers_believer"));
		}
	};
});
::mods_hookExactClass("entity/tactical/enemies/kraken", function ( a )
{
	a.onDamageReceived = function ( _attacker, _skill, _hitInfo )
	{
		if (this.m.Type == this.Const.EntityType.Kraken)
		{
			_hitInfo.BodyPart = this.Const.BodyPart.Head;
			local ret = this.actor.onDamageReceived(_attacker, _skill, _hitInfo);

			if (!this.m.IsEnraged && (this.m.TentaclesDestroyed >= 4 || this.getHitpointsPct() <= 0.75))
			{
				this.playSound(this.Const.Sound.ActorEvent.Other1, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1] * this.m.SoundVolumeOverall);
				this.m.IsEnraged = true;

				foreach( t in this.m.Tentacles )
				{
					if (!t.isNull() && t.isAlive() && t.getHitpoints() > 0)
					{
						t.setMode(1);
					}
				}
			}

			return ret;
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

		if (this.m.Type == this.Const.EntityType.Kraken)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_kraken_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})