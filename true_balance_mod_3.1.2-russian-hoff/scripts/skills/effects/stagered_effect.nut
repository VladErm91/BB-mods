this.stagered_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.stagered";
		this.m.Name = "Стеснён";
		this.m.Icon = "ui/perks/perk_13.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "Пилум застрял в щите, что не позволяет эффективно защищаться. Эффект пропадёт через [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] ход(а).";
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
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] к защите ближнего и дальнего боя на 2 хода."
			}
		];
	}

	function resetTime()
	{
		this.m.TurnsLeft = this.Math.max(2, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.spawnIcon("perk_13", this.m.Container.getActor().getTile());
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(2, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.spawnIcon("perk_13", this.m.Container.getActor().getTile());
	}

	function onUpdate( _properties )
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (off == null)
		{
	    	this.removeSelf();
	    }
	    
	    _properties.MeleeDefense -= 10;	
	    _properties.RangedDefense -= 10;	
	    this.m.IsHidden = false;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

