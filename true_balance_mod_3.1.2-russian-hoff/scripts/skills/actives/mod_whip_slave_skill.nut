this.mod_whip_slave_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.mod_whip_slave";
		this.m.Name = "Подстёгивание";
		this.m.Description = "Напомните непрощённым кто их хозяин, хорошенько выпоров их, чтобы они отдали всё, вплоть до своей жизни.";
		this.m.KilledString = "Захлёстан до смерти";
		this.m.Icon = "skills/active_214.png";
		this.m.IconDisabled = "skills/active_214_sw.png";
		this.m.Overlay = "active_214";
		this.m.SoundOnUse = [
			"sounds/combat/dlc6/whip_slave_01.wav",
			"sounds/combat/dlc6/whip_slave_02.wav",
			"sounds/combat/dlc6/whip_slave_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
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
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Наносит [color=" + this.Const.UI.Color.DamageValue + "]1[/color] - [color=" + this.Const.UI.Color.DamageValue + "]3[/color] урона, игнорирующего броню"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Даёт выбранному непрощённому эффект 'Подстёгнут', увеличивая его характеристики на 3 хода. Чем выше уровень персонажа, использующего этот навык, тем выше прирост."
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Поднимает боевой дух непрощённого до уровня 'устойчивый', если он был ниже"
			}
		];
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getType() != this.Const.EntityType.Slave)
		{
			return false;
		}
		
		if (_targetTile.getEntity().getSkills().hasSkill("effects.whipped"))
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local t = _targetTile.getEntity();
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = this.Math.rand(1, 3);
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		t.onDamageReceived(_user, this, hitInfo);

		if (t.isAlive() && !t.isDying())
		{
			if (t.getSkills().hasSkill("effects.whipped"))
			{
				local s = t.getSkills().getSkillByID("effects.whipped");
				s.onRefresh();
				s.setLevel(this.Math.max(11, _user.getLevel()));
				t.getSkills().update();
			}
			else
			{
				local s = this.new("scripts/skills/effects/whipped_effect");
				s.setLevel(this.Math.max(11, _user.getLevel()));
				t.getSkills().add(s);
			}

			if (t.getMoraleState() < this.Const.MoraleState.Steady)
			{
				t.setMoraleState(this.Const.MoraleState.Steady);
			}
		}

		return true;
	}

});

