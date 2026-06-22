::mods_registerMod("faction_unfriendly", 1.8, "True Balance Mod Faction Unfrendly");
::mods_queue("faction_unfriendly", "mod_hooks(>=17)", function() {	
::mods_hookBaseClass("factions/faction", function(o)
{
	o.addPlayerRelationEx <- function ( _r, _reason = "")
	{
		this.m.PlayerRelation = this.Math.minf(100.0, this.Math.max(0.0, this.m.PlayerRelation + _r));
		this.updatePlayerRelation();

		if (_reason != "")
		{
			if (this.m.PlayerRelationChanges.len() >= 1 && this.m.PlayerRelationChanges[0].Text == _reason)
			{
				this.m.PlayerRelationChanges[0].Time = this.Time.getVirtualTimeF();
			}
			else
			{
				if (this.m.PlayerRelationChanges.len() >= 6)
				{
					this.m.PlayerRelationChanges.remove(this.m.PlayerRelationChanges.len() - 1);
				}

				this.m.PlayerRelationChanges.insert(0, {
					Positive = _r >= 0 ? true : false,
					Text = _reason,
					Time = this.Time.getVirtualTimeF()
				});
			}
		}
		if (_reason == "Выбрал не ту сторону в войне")
		{
			this.World.Statistics.getFlags().increment("Chose_Side");
		}
	}

	o.normalizeRelation <- function()
	{
		if (!this.m.IsRelationDecaying)
		{
			return;
		}

		if ((this.World.FactionManager.m.GreaterEvil.Type == 1 || this.World.FactionManager.m.GreaterEvil.Type == 4) && this.World.FactionManager.m.GreaterEvil.Phase == this.Const.World.GreaterEvilPhase.Live && !this.World.Statistics.getFlags().has("Chose_Side") && this.World.Flags.get("StartCrisisDay") && this.World.getTime().Days - this.World.Flags.get("StartCrisisDay") >= 3)
		{
			local unfriendly = 29.0 //or whatever
			if (this.m.PlayerRelation > unfriendly) 
			{
				this.setPlayerRelation(this.Math.maxf(unfriendly, this.m.PlayerRelation - this.m.RelationDecayPerDay * 8 * this.World.Assets.m.RelationDecayGoodMult));
			}
			else if (this.m.PlayerRelation < unfriendly)
			{
				this.setPlayerRelation(this.Math.minf(unfriendly, this.m.PlayerRelation + this.m.RelationDecayPerDay * this.World.Assets.m.RelationDecayBadMult));
			}

			if (this.m.PlayerRelationChanges.len() != 0 && this.m.PlayerRelationChanges[this.m.PlayerRelationChanges.len() - 1].Time + this.Const.World.Assets.RelationTimeOut < this.Time.getVirtualTimeF())
			{
				this.m.PlayerRelationChanges.remove(this.m.PlayerRelationChanges.len() - 1);
			}
		}
		else
		{
			if (this.m.PlayerRelation > 50.0)
			{
				this.setPlayerRelation(this.Math.maxf(50.0, this.m.PlayerRelation - this.m.RelationDecayPerDay * this.World.Assets.m.RelationDecayGoodMult));
			}
			else if (this.m.PlayerRelation < 50.0)
			{
				this.setPlayerRelation(this.Math.minf(50.0, this.m.PlayerRelation + this.m.RelationDecayPerDay * this.World.Assets.m.RelationDecayBadMult));
			}

			if (this.m.PlayerRelationChanges.len() != 0 && this.m.PlayerRelationChanges[this.m.PlayerRelationChanges.len() - 1].Time + this.Const.World.Assets.RelationTimeOut < this.Time.getVirtualTimeF())
			{
				this.m.PlayerRelationChanges.remove(this.m.PlayerRelationChanges.len() - 1);
			}
		}
	}
});
})
