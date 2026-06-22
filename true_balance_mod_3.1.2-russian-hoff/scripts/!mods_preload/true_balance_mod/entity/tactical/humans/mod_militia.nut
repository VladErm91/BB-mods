::mods_registerMod("mod_militia", 1.8, "True Balance Mod Militia");
::mods_queue("mod_militia", "mod_true_balance", function() {
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

		if (this.ClassName == "militia")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
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

		if (this.ClassName == "militia" || this.ClassName == "militia_guest")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag) != null)
			{
				this.m.Items.removeFromBag(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag));
			}
			
			local r = this.Math.rand(0, 10);

			if (r <= 1)
			{
				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
				{
					local r = this.Math.rand(3, 7);

					if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
					}
					else if (r == 4)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
					}
					else if (r == 5)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
					}
					else if (r == 6)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/goedendag"));
					}
					else if (r == 7)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
					}
				}
				else
				{
					local r = this.Math.rand(3, 6);

					if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
					}
					else if (r == 4)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/warfork"));
					}
					else if (r == 5)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
					}
					else if (r == 6)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/goedendag"));
					}
					else if (r == 7)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
					}
				}
			}
			else
			{
				if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
				}
				else if (r == 7)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
				}
				else if (r == 8)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
				}
				else if (r == 9)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
				}
				else if (r == 10)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
				}

				local r = this.Math.rand(1, 100);

				if (r <= 75)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
				}	
			}

			r = this.Math.rand(1, 6);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/armor/apron"));
			}

			if (this.Math.rand(1, 100) <= 100)
			{
				local r = this.Math.rand(1, 5);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/hood"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
				}	
			}
		}
	}
});
})