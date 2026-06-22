::mods_registerMod("mod_caravan_hand", 1.8, "True Balance Mod Caravan Hand");
::mods_queue("mod_caravan_hand", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/human", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.ClassName == "caravan_hand")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r = this.Math.rand(1, 8);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/knife"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
			}

			if (this.Math.rand(1, 100) <= 33)
			{
				this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
			}

			r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
			}
			else if (r == 4)
			{
				local item = this.new("scripts/items/armor/linen_tunic");
				item.setVariant(this.Math.rand(6, 7));
				this.m.Items.equip(item);
			}

			if (this.Math.rand(1, 100) <= 33)
			{
				local r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/hood"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
				}
			}
		}
	};
});
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("onAfterInit" in a))
	{
		a = a[a.SuperName];
	}

	local onAfterInit = a.onAfterInit;
	a.onAfterInit = function ()
	{
		onAfterInit();

		if (this.ClassName == "caravan_hand")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
		}
	};
});
::mods_hookBaseClass("entity/tactical/human", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.ClassName == "caravan_hand")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_caravan_melee_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})