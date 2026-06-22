::mods_registerMod("mod_accessory", 1.8, "True Balance Mod Accessory");
::mods_queue("mod_accessory", "mod_true_balance", function() {
::mods_hookNewObject("items/accessory/poison_item", function(o) 
{
		o.m.StaminaModifier = null;
		o.m.SlotType = this.Const.ItemSlot.None;
		o.m.IsAllowedInBag = true;
		o.m.ItemType = this.Const.Items.ItemType.Usable;
		o.m.IsDroppedAsLoot = true;
		o.m.IsUsable = true;
		o.m.ShowOnCharacter = null;

	o.getTooltip = function()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 65,
			type = "text",
			text = "Нажмите ПКМ или перетащите на выбранного персонажа, чтобы использовать. Исчезает после использования."
		});
		return result;
	}

	o.onPutIntoBag = function()
	{
	}

	o.onEquip = function()
	{
	}

	o.onUse = function( _actor, _item = null )
	{
		if (_actor.getSkills().hasSkill("effects.poison_coat"))
		{
			return false;
		}
		else
		{
			this.Sound.play("sounds/combat/poison_applied_0" + this.Math.rand(1, 2) + ".wav", this.Const.Sound.Volume.Inventory);
			_actor.getSkills().add(this.new("scripts/skills/effects/poison_coat_effect"));
			return true;
		}
	}

	o.getTime <- function()
	{
		if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			return this.World.State.getCombatStartTime();
		}
		else
		{
			return this.Time.getVirtualTimeF();
		}
	}
});
::mods_hookNewObject("items/accessory/spider_poison_item", function(o) 
{
		o.m.StaminaModifier = null;
		o.m.SlotType = this.Const.ItemSlot.None;
		o.m.IsAllowedInBag = false;
		o.m.ItemType = this.Const.Items.ItemType.Usable;
		o.m.IsDroppedAsLoot = true;
		o.m.IsUsable = true;
		o.m.ShowOnCharacter = null;

	o.getTooltip = function()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 65,
			type = "text",
			text = "Нажмите ПКМ или перетащите на выбранного персонажа, чтобы использовать. Исчезает после использования."
		});
		return result;
	}

	o.getTime <- function()
	{
		if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			return this.World.State.getCombatStartTime();
		}
		else
		{
			return this.Time.getVirtualTimeF();
		}
	}

	o.onUse = function( _actor, _item = null )
	{
		if (_actor.getSkills().hasSkill("effects.spider_poison_coat"))
		{
			return false;
		}
		else
		{
			this.Sound.play("sounds/combat/poison_applied_0" + this.Math.rand(1, 2) + ".wav", this.Const.Sound.Volume.Inventory);
			_actor.getSkills().add(this.new("scripts/skills/effects/spider_poison_coat_effect"));
			return true;
		}
	}
	
	o.onPutIntoBag = function()
	{
	}

	o.onEquip = function()
	{
	}
});
})
