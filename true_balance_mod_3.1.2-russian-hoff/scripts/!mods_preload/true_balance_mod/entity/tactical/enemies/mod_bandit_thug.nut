::mods_registerMod("mod_bandit_thug", 1.8, "True Balance Mod Bandit Thug");
::mods_queue("mod_bandit_thug", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.BanditThug)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r = this.Math.rand(1, 11);

			if (r == 1)
			{
				if (this.Const.DLC.Unhold)
				{
					r = this.Math.rand(1, 3);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/goedendag"));
					}
					else if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
					}
				}
				else
				{
					r = this.Math.rand(1, 2);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
					}
				}
			}
			else
			{
				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
				{
			        r = this.Math.rand(2, 9);

			       if (r == 2)
			       {
			              	this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
			       }
			       else if (r == 3)
			       {
			              	this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
			       }
			       else if (r == 4)
			       {
				       this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
			       }
			       else if (r == 5)
			       {
				       this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
			       }
			       else if (r == 6)
			       {
				       this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
			       }
			       else if (r == 7)
			       {
			              	this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
			       }
			       else if (r == 8)
			       {
				       this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
			       }
			       else if (r == 9)
			       {
				       this.m.Items.equip(this.new("scripts/items/weapons/wooden_flail"));
			       }
			       else if (r == 10)
			       {
				       this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
			       }
			       else if (r == 11)
			       {
				       this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
			       }
				}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
				{
			        r = this.Math.rand(2, 9);

					if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
					}
					else if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
					}
					else if (r == 4)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
					}
					else if (r == 5)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
					}
					else if (r == 6)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
					}
					else if (r == 7)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
					}
					else if (r == 8)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
					}
					else if (r == 9)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
					}
				}

				if (this.Math.rand(1, 100) <= 33)
				{
					local r = this.Math.rand(1, 2);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
					}
				}
			}

			r = this.Math.rand(0, 6);

			if (r <= 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/blotched_gambeson"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
			}

			if (this.Math.rand(1, 100) <= 90)
			{
				local r = this.Math.rand(1, 6);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/hood"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/mouth_piece"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
				}
				else if (r == 6)
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

		if (this.m.Type == this.Const.EntityType.BanditThug)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recoversa"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
			{
				this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			}
		}
	};
});
})