this.balls <- this.inherit("scripts/items/ammo/ammo", {
	m = {},
	function create()
	{
		this.m.ID = "ammo.balls";
		this.m.Name = "Сумка с пулями";
		this.m.Description = "Сумка со свинцовыми пулями, предназначенными для метания из пращи.";
		this.m.Icon = "ammo/mags.png";
		this.m.IconEmpty = "ammo/mags_empty.png";
		this.m.SlotType = this.Const.ItemSlot.Ammo;
		this.m.ItemType = this.Const.Items.ItemType.Ammo;
		this.m.AmmoType = this.Const.Items.AmmoType.Balls;
		this.m.Value = 200;
		this.m.Ammo = 10;
		this.m.AmmoMax = 10;
		this.m.AmmoCost = 2;
		this.m.IsDroppedAsLoot = true;
	}

	function getTooltip()
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
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.m.Ammo != 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Содержит [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Ammo + "[/color] пуль"
			});
		}
		else
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Боеприпасов нет[/color]"
			});
		}

		return result;
	}

});

