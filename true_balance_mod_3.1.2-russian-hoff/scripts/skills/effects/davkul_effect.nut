this.davkul_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.davkul";
		this.m.Name = "Благословение Давкула";
		this.m.Icon = "skills/status_effect_108.png";
		this.m.Description = "Одновременное ношение 'Взгляда Давкула' и 'Аспекта Давкула' даёт персонажу невосприимчивость к страху и умениям, воздействующим на разум.";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
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
				text = "Дает невосприимчивость к страху и умениям, воздействующим на разум"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] *= 1000.0;
	}

});

