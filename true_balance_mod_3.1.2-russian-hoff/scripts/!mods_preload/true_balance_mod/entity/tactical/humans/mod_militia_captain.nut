::mods_registerMod("mod_militia_captain", 1.8, "True Balance Mod Militia Captain");
::mods_queue("mod_militia_captain", "mod_true_balance", function() {
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

		if (this.ClassName == "militia_captain")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		}	
	};
});
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

		if (this.ClassName == "militia_captain")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag) != null)
			{
				this.m.Items.removeFromBag(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag));
			}
			
			local r = this.Math.rand(1, 6);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
			}
			else
			{
				if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
				}

				if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
				{
					r = this.Math.rand(1, 2);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
					}
				}
			}

			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
			}

			local r = this.Math.rand(1, 5);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/mail_coif"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/kettle_hat"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/padded_kettle_hat"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/padded_flat_top_helmet"));
			}
		}
	}
});
})