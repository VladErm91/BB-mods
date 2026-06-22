this.nofire_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.nofire";
		this.m.Name = "Жажда крови удовлетворена";
		this.m.Icon = "skills/status_effect_34.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsRemovedAfterBattle = false;
	}

	function onCombatStarted()
	{
		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInCrossbows)
		{
			this.getItem().setLoaded(false);
			local skillToAdd = this.new("scripts/skills/actives/reload_handgonne_skill");
			skillToAdd.setItem(this.getItem());
			skillToAdd.setFatigueCost(this.Math.max(0, skillToAdd.getFatigueCostRaw() + this.getItem().m.FatigueOnSkillUse));
			this.getContainer().add(skillToAdd);
		}
	}
});

