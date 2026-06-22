this.perk_full_force <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.full_force";
		this.m.Name = this.Const.Strings.PerkName.FullForce;
		this.m.Description = this.Const.Strings.PerkDescription.FullForce;
		this.m.Icon = "ui/perks/perk_18.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local fat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local mainhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
		}

		if (mainhand != null)
		{
			fat = fat + mainhand.getStaminaModifier();
		}

		if (offhand != null)
		{
			fat = fat + offhand.getStaminaModifier();
		}

		if (this.getContainer().getActor().isArmedWithMeleeWeapon())
		{
			local bonus = this.Math.abs(fat / 3);
			_properties.DamageRegularMin *= 1.0 + 0.01 * this.Math.floor(bonus);
			local mindamage = _properties.DamageRegularMin;
			local maxdamage = _properties.DamageRegularMax;
			if (maxdamage < mindamage)
			{	
				local difference = _properties.DamageRegularMin - _properties.DamageRegularMax;
				_properties.DamageRegularMax = _properties.DamageRegularMin;
				_properties.DamageRegularMin = _properties.DamageRegularMax - difference;
			}
	    }
    }

});