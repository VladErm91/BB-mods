this.buckler_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Spent = true
	},
	function create()
	{
		this.m.ID = "effects.buckler";
		this.m.Name = "Отражение";
		this.m.Description = "Позволяет персонажу эффективно защититься от первого полученного удара";
		this.m.Icon = "ui/perks/perk_02.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local def;
		local deb;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		{
			def = 10;
			deb = 5;
		}
		else
		{
			def = 10;
			deb = 5;	
		}
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + def + "[/color] к защите от первой атаки в ближнем бою"
			}
		];
	}

	function onUpdate( _properties )
	{
		if (!this.m.Spent && this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null && (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).getID() == "shield.buckler" || this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).getID() == "shield.goblin_heavy_shield" || this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).getID() == "shield.goblin_light_shield")  && this.getContainer().getActor().getMoraleState() != this.Const.MoraleState.Fleeing)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
			{
				_properties.MeleeDefense += 12;
			}
			else
			{
				_properties.MeleeDefense += 10;
			}
			this.m.IsHidden = false;
		}
		else
		{
			this.m.IsHidden = true;
		}
	}

	function onMissed( _attacker, _skill )
	{	
		if (!_skill.isRanged())
		{
			if (!this.isHidden())
			{
				this.m.Spent = true;
			}
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (!this.isHidden())
		{
			this.m.Spent = true;
		}
	}

	function onTurnStart()
	{
		this.m.Spent = false;
	}

	function onCombatStarted()
	{
		this.m.Spent = false;
	}
});

