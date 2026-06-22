::mods_registerMod("mod_misc", 1.8, "True Balance Mod Misc");
::mods_queue("mod_misc", "mod_true_balance", function() {
::mods_hookNewObject("items/misc/snake_oil_item", function(o) 
{
	o.getBuyPrice = function()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()]));
		}
		else
		{
			return this.Math.ceil(this.getValue() * this.getPriceMult());
		}
	}

	o.getSellPrice = function()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.floor(this.getValue() * this.Const.World.Assets.SellPriceNotProducedHere * this.World.State.getCurrentTown().getSellPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()]);
		}
		else
		{
			return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseSellPrice);
		}
	}
});
::mods_hookNewObject("items/misc/happy_powder_item", function(o) 
{
	o.m.Value = 600;
});
::mods_hookNewObject("items/misc/goblin_grunt_potion_item", function(o) 
{
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
			id = 11,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "Затраты ОД на умения 'Рокировка' и 'Изворотливость' снижена до [color=" + this.Const.UI.Color.PositiveValue + "]2[/color]"
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Затраты выносливости на умение 'Рокировка' уменьшены на [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]"
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Затраты выносливости на умение 'Изворотливость' уменьшены до [color=" + this.Const.UI.Color.PositiveValue + "]15[/color]"
		});
		result.push({
			id = 65,
			type = "text",
			text = "Нажмите ПКМ или перетащите на выбранного персонажа, чтобы выпить зелье. Исчезает после использования."
		});
		result.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Вызывает мутацию тела, что приводит к болезности"
		});
		return result;
	}
});
})
