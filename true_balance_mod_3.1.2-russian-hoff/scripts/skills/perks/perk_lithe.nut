this.perk_lithe <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.lithe";
		this.m.Name = this.Const.Strings.PerkName.Steadfast;
		this.m.Icon = "ui/perks/sunderingstrikes_circle.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		local fm = this.Math.floor(this.getChance() * 100);
		return fm >= 100;
	}

	function getDescription()
	{
		return "Стань специалистом по средней броне, чтобы поглощать вражеские атаки!";
	}

	function getTooltip()
	{  
		local armor = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local headarmor = this.getContainer().getActor().getArmor(this.Const.BodyPart.Head);
		local bodyarmor = this.getContainer().getActor().getArmor(this.Const.BodyPart.Body);

		if (body != null)
		{
			armor = armor + bodyarmor;
		}

		if (head != null)
		{
			armor = armor + headarmor;
		}

		local fm = this.Math.round(this.getChance() * 100);
		local tooltip = this.skill.getTooltip();

		if (armor <= 450 && fm < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Полученный урон брони уменьшается на [color=" + this.Const.UI.Color.PositiveValue + "]" + 15 + "%[/color], а урон, проходящий сквозь броню на [color=" + this.Const.UI.Color.PositiveValue + "]" + 30 + "%[/color]"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Шлем и доспех этого персонажа слишком тяжелы[/color]"
			});
		}

		return tooltip;
	}

	function getChance()
	{
		local fat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
		}

		fat = this.Math.min(0, fat);
		local ret = this.Math.minf(1.0, 1.0 - 0.36 + this.Math.pow(this.Math.abs(fat), 1.0) * 0.01);
		return ret;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		local armor = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local headarmor = this.getContainer().getActor().getArmor(this.Const.BodyPart.Head);
		local bodyarmor = this.getContainer().getActor().getArmor(this.Const.BodyPart.Body);

		if (body != null)
		{
			armor = armor + bodyarmor;
		}

		if (head != null)
		{
			armor = armor + headarmor;
		}
		
		local fm = this.Math.round(this.getChance() * 100);

		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		_properties.DamageReceivedArmorMult *= 0.85;

		if (armor <= 450 && fm < 100 && _hitInfo.BodyPart == this.Const.BodyPart.Head)
		{
			_properties.DamageReceivedDirectMult *= 0.7;
		}

		if (armor <= 450 && fm < 100 && _hitInfo.BodyPart == this.Const.BodyPart.Body)
		{
			_properties.DamageReceivedDirectMult *= 0.7;
		}
	}

});

