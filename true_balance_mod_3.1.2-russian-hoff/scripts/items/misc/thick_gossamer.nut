this.thick_gossamer <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.m.ID = "misc.thick_gossamer";
		this.m.Name = "Толстая паутина";
		this.m.Description = "Толстая паутина, собранная с остатков сетеплёта. Лёгкая и прочная, она значительно превосходит многие другие материалы по своим качествам. Если бы только она не была такой липкой...";
		this.m.Icon = "misc/inventory_webknecht_silk.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 350;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

