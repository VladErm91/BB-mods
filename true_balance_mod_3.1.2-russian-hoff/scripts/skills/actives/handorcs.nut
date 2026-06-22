this.handorcs <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.handorcs";
		this.m.Name = "Рукопашная";
		this.m.Description = "Стандартный удар в рукопашном бою. Дай волю кулакам!";
		this.m.KilledString = "Забит до смерти";
		this.m.Icon = "skills/active_08.png";
		this.m.IconDisabled = "skills/active_08_sw.png";
		this.m.Overlay = "active_222";
		this.m.SoundOnUse = [
			"sounds/combat/hand_01.wav",
			"sounds/combat/hand_02.wav",
			"sounds/combat/hand_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsSerialized = false;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] к шансу на попадание"
		});
		return ret;
	}

	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return (mainhand == null || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable();
	}

	function isHidden()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return mainhand != null && !this.getContainer().hasSkill("effects.disarmed") || this.skill.isHidden();
	}

	function onUpdate( _properties )
	{
		if (this.isUsable())
		{
			_properties.DamageRegularMin = 20;
			_properties.DamageRegularMax = 30;
			_properties.DamageArmorMult = 0.7;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null && _skill == this)
		{
			_properties.MeleeSkill -= 10;
			return;
		}

		if (_skill == this)
		{
			_properties.MeleeSkill -= 10;
			local rd = _targetEntity.getBaseProperties().getRangedDefense();
			local body = _targetEntity.getArmor(this.Const.BodyPart.Body);
			local head = _targetEntity.getArmor(this.Const.BodyPart.Head);

			if (_targetEntity.getSkills().hasSkill("perk.blend_in"))
			{
				if (body < head)
				{
					_properties.HitChance[this.Const.BodyPart.Head] += rd;
				}

				if (body > head)
				{
					_properties.HitChance[this.Const.BodyPart.Head] -= rd * 0.4;
				}
			}
		}
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

