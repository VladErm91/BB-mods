this.spearwalls <- this.inherit("scripts/skills/skill", {
	m = {
		BaseAttackName = "Thrust"
	},
	function create()
	{
		this.m.ID = "actives.spearwalls";
		this.m.Name = "Стена копий";
		this.m.Icon = "skills/active_23.png";
		this.m.IconDisabled = "skills/active_23_sw.png";
		this.m.Overlay = "active_23";
		this.m.SoundOnUse = [
			"sounds/combat/spearwall_01.wav",
			"sounds/combat/spearwall_02.wav",
			"sounds/combat/spearwall_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 30;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getDescription()
	{
		return "Приготовиться оттолкнуть любого противника, попавшего в радиус поражения оружия, предотвратив сближение с ним. Успешно поражённая цель получит лишь половину урона от умения 'Прорыв'. Нельзя использовать в режиме ближнего боя.";
	}

	function getTooltip()
	{
		local ret = [
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
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Нельзя использовать, пока этот персонаж находится в режиме ближнего боя[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears || !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) && !this.getContainer().hasSkill("effects.spearwall");
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInSpears)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 4;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Container.add(this.new("scripts/skills/effects/spearwall_effect"));

		if (!_user.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " использует умение 'Стена копий'");
		}

		return true;
		return false;
	}

	function onRemoved()
	{
		this.m.Container.removeByID("effects.spearwall");
	}

});

