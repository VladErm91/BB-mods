this.quick_hands_effect <- this.inherit("scripts/skills/skill", {
	m = {
		isSpent = false,
	},
	function create()
	{
		this.m.ID = "effects.quick_hands";
		this.m.Name = "Инерция";
		this.m.Description = "Двуручное оружие слишком тяжёлое, чтобы быстро схватить его и, в то же время, точно прицелиться.";
		this.m.Icon = "skills/inertia.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15[/color] к навыку ближнего боя"
			}
		];
	}

	function onUpdate( _properties )
	{
		if (("State" in this.Tactical) && this.Tactical.State != null)
		{
		}
		else
		{
			return;
		}

		local items = this.getContainer().getActor().getItems();
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (this.getContainer().getActor().isPlayerControlled() && this.getContainer().getActor().isPlacedOnMap() && main != null && items.hasBlockedSlot(this.Const.ItemSlot.Offhand) && this.getContainer().getActor().isArmedWithMeleeWeapon())
		{
			this.m.IsHidden = false;
			_properties.MeleeSkill -= 15;
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}

	function onCombatStarted()
	{
		this.removeSelf();
	}
	
});

