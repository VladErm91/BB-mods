this.hive_queens_fangs <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.m.ID = "misc.ghoul_teeth";
		this.m.Name = "Клыки королевы улья";
		this.m.Description = "Горсть зазубренных клыков, вырванных из пасти королевы улья. Хоть они и поражены гнилью, их прочности хватит, чтобы разгрызть любую кость. Для вас они, скорее всего, бесполезны, но алхимики могут отвалить за них немного крон.";
		this.m.Icon = "misc/inventory_ghoul_teeth_01.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 200;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

});

