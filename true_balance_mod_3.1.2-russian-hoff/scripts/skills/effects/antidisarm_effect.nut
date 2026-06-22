this.antidisarm_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},
	function create()
	{
		this.m.ID = "effects.antidisarm";
		this.m.Name = "Невосприимчивость к обезоруживанию ([color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft * 25 + "[/color])";
		this.m.Description = "Шанс нанести удар с использованием умения 'Обезоруживание' уменьшается на [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft * 25 + "[/color]";
		this.m.Icon = "skills/disarm_resist.png";
		this.m.IconMini = "disarm_resist_mini";
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
				text = "Невосприимчивость к обезоруживанию"
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
				text = "Шанс нанести удар с использованием умения 'Обезоруживание' уменьшается на [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft * 25 + "[/color]."
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
		_properties.DisarmResist += 25 * this.m.TurnsLeft;
	}

	function onTurnEnd()
	{
		--this.m.TurnsLeft;
		this.m.Name = "Невосприимчивость к обезоруживанию ([color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft * 25 + "[/color])";
		
		if (this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

