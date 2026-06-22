this.antistun_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},
	function create()
	{
		this.m.ID = "effects.antistun";
		this.m.Name = "Невосприимчивость к оглушению ([color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft * 25 + "[/color])";
		this.m.Icon = "skills/stun_resist.png";
		this.m.IconMini = "stun_resist_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = "Невосприимчивость к оглушению"
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Шанс оглушить противника умениями оружия уменьшен на [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft * 25 + "[/color]."
			}
		];
	}

	function resetTime()
	{
		this.m.TurnsLeft = 3;
	}

	function onAdded()
	{
		this.m.TurnsLeft = 3;
	}

	function onUpdate( _properties )
	{
		_properties.StunResist += 25 * this.m.TurnsLeft;
	}

	function onTurnEnd()
	{
		--this.m.TurnsLeft;
		this.m.Name = "Невосприимчивость к оглушению ([color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft * 25 + "[/color])";
		
		if (this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

