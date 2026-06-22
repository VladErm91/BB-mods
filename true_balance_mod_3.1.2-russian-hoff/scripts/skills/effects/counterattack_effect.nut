this.counterattack_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.counterattack";
		this.m.Name = "Шанс";
		this.m.Icon = "skills/stun_resist.png";
		this.m.IconMini = "stun_resist_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 0.75;
		_properties.MeleeSkill -= 20;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.removeSelf();
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

});

