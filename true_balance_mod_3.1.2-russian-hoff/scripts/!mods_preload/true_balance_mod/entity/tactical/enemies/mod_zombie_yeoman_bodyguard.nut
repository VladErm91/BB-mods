::mods_registerMod("mod_zombie_yeoman_bodyguard", 1.8, "True Balance Mod Zombie Yeoman Bodygard");
::mods_queue("mod_zombie_yeoman_bodyguard", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/enemies/zombie_yeoman", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.m.Type == this.Const.EntityType.ZombieYeoman)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 20)
			{
				if (this.Math.rand(1, 100) <= 90)
				{
					r = this.Math.rand(1, 7);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
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
						this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
					}
					else if (r == 6)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
					}
					else if (r == 7)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
					}
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warfork"));
				}	
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >=  80)
			{
				r = this.Math.rand(1, 9);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
				}
				else if (r == 7)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/spetum"));
				}
				else if (r == 8)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
				}
				else if (r == 9)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >=  60)
			{
				r = this.Math.rand(1, 9);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
				}
				else if (r == 7)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warfork"));
				}
				else if (r == 8)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
				}
				else if (r == 9)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
			{
				r = this.Math.rand(1, 12);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
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
					this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
				}
				else if (r == 7)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warfork"));
				}
				else if (r == 8)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
				}
				else if (r == 9)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
				}
				else if (r == 10)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
				}
				else if (r == 11)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
				}
				else if (r == 12)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
			{
				r = this.Math.rand(1, 7);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
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
					this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
				}
				else if (r == 7)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
				}
			}
			
			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 120)
			{
				if (this.Math.rand(1, 100) <= 50 && this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
				{
					r = this.Math.rand(1, 2);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/shields/worn_heater_shield"));
					}
					else if (r == 2)
					{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
					}
				}
			}
        	else	
			{
				if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
				{
					r = this.Math.rand(1, 2);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/shields/worn_heater_shield"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
					}
				}
			}

			local armor;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
			{
				r = this.Math.rand(1, 7);

				if (r == 1)
				{
					armor = this.new("scripts/items/armor/padded_leather");
				}
				else if (r == 2)
				{
					armor = this.new("scripts/items/armor/worn_mail_shirt");
				}
				else if (r == 3)
				{
					armor = this.new("scripts/items/armor/patched_mail_shirt");
				}
				else if (r == 4)
				{
					armor = this.new("scripts/items/armor/ragged_surcoat");
				}
				else if (r == 5)
				{
					armor = this.new("scripts/items/armor/basic_mail_shirt");
				}
				else if (r == 6)
				{
					armor = this.new("scripts/items/armor/blotched_gambeson");
				}
				else if (r == 7)
				{
					armor = this.new("scripts/items/armor/leather_lamellar");
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				r = this.Math.rand(1, 7);
	
				if (r == 1)
				{
					armor = this.new("scripts/items/armor/padded_leather");
				}
				else if (r == 2)
				{
					armor = this.new("scripts/items/armor/worn_mail_shirt");
				}
				else if (r == 3)
				{
					armor = this.new("scripts/items/armor/patched_mail_shirt");
				}
				else if (r == 4)
				{
					armor = this.new("scripts/items/armor/ragged_surcoat");
				}
				else if (r == 5)
				{
					armor = this.new("scripts/items/armor/basic_mail_shirt");
				}
				else if (r == 6)
				{
					armor = this.new("scripts/items/armor/mail_shirt");
				}
				else if (r == 7)
				{
					armor = this.new("scripts/items/armor/leather_scale_armor");
				}
			}

			if (this.Math.rand(1, 100) <= 66)
			{
				armor.setArmor(armor.getArmorMax() / 2 - 1);
			}

			this.m.Items.equip(armor);

			local helmet;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
			{
				if (this.Math.rand(1, 100) <= 75)
				{
					r = this.Math.rand(1, 7);

					if (r == 1)
					{
						helmet = this.new("scripts/items/helmets/aketon_cap");
					}
					else if (r == 2)
					{
						helmet = this.new("scripts/items/helmets/full_aketon_cap");
					}
					else if (r == 3)
					{
						helmet = this.new("scripts/items/helmets/kettle_hat");
					}
					else if (r == 4)
					{
						helmet = this.new("scripts/items/helmets/mail_coif");
					}
					else if (r == 5)
					{
						helmet = this.new("scripts/items/helmets/dented_nasal_helmet");
					}
					else if (r == 6)
					{
						helmet = this.new("scripts/items/helmets/rusty_mail_coif");
					}
					else if (r == 7)
					{
						helmet = this.new("scripts/items/helmets/full_leather_cap");
					}

					if (this.Math.rand(1, 100) <= 66)
					{
						helmet.setArmor(helmet.getArmorMax() / 2 - 1);
					}

					this.m.Items.equip(helmet);
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >=  60)
			{
				r = this.Math.rand(1, 12);

				if (r == 1)
				{
					helmet = this.new("scripts/items/helmets/aketon_cap");
				}
				else if (r == 2)
				{
					helmet = this.new("scripts/items/helmets/full_aketon_cap");
				}
				else if (r == 3)
				{
					helmet = this.new("scripts/items/helmets/kettle_hat");
				}
				else if (r == 4)
				{
					helmet = this.new("scripts/items/helmets/padded_kettle_hat");
				}
				else if (r == 5)
				{
					helmet = this.new("scripts/items/helmets/dented_nasal_helmet");
				}
				else if (r == 6)
				{
					helmet = this.new("scripts/items/helmets/mail_coif");
				}
				else if (r == 7)
				{
					helmet = this.new("scripts/items/helmets/full_leather_cap");
				}
				else if (r == 8)
				{
					helmet = this.new("scripts/items/helmets/nasal_helmet");
				}
				else if (r == 9)
				{
					helmet = this.new("scripts/items/helmets/padded_nasal_helmet");
				}
				else if (r == 10)
				{
					helmet = this.new("scripts/items/helmets/flat_top_helmet");
				}
				else if (r == 11)
				{
					helmet = this.new("scripts/items/helmets/nordic_helmet");
				}
				else if (r == 12)
				{
					helmet = this.new("scripts/items/helmets/nasal_helmet_with_rusty_mail");
				}

				if (this.Math.rand(1, 100) <= 66)
				{
					helmet.setArmor(helmet.getArmorMax() / 2 - 1);
				}

				this.m.Items.equip(helmet);
			}	
		}		
	};
});
})