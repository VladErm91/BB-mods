::mods_registerMod("mod_bandit_raider", 1.8, "True Balance Mod Bandit Raider");
::mods_queue("mod_bandit_raider", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.BanditRaider)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag) != null)
			{
				this.m.Items.removeFromBag(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag));
			}

			local r;

			if (this.Math.rand(1, 100) <= 20)
			{
				if (this.Const.DLC.Unhold)
				{
			        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
			        {
						r = this.Math.rand(1, 7);

						if (r == 1)
						{
							this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
						}
						else if (r == 2)
						{
							this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
						}
						else if (r == 3)
						{
							this.m.Items.equip(this.new("scripts/items/weapons/warfork"));
						}
						else if (r == 4)
						{
							this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
						}
						else if (r == 5)
						{
						this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
						}
						else if (r == 6)
						{
							this.m.Items.equip(this.new("scripts/items/weapons/two_handed_mace"));
						}
						else if (r == 7)
						{
							this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
						}
			        }

			        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			        {
				        r = this.Math.rand(1, 8);

				       if (r == 1)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
				       }
				       else if (r == 2)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
				       }
				       else if (r == 3)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/spetum"));
				       }
				       else if (r == 4)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
				       }
				       else if (r == 5)
				       {
				           this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
				       }
				       else if (r == 6)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/two_handed_mace"));
				       }
				       else if (r == 7)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
				       }
				       else if (r == 8)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/pike"));
				       }
			        }

			        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
			        {
				        r = this.Math.rand(0, 8);

				       if (r == 0)
				       {
				              	this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
				       }
				       else if (r == 1)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
				       }
				       else if (r == 2)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
				       }
				       else if (r == 3)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/warfork"));
				       }
				       else if (r == 4)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
				       }
				       else if (r == 5)
				       {
				             	this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
				       }
				       else if (r == 6)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/two_handed_mace"));
				       }
				       else if (r == 7)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
				       }
				       else if (r == 8)
				       {
					       this.m.Items.equip(this.new("scripts/items/weapons/pike"));
				       }
                    }
			 	}
				else
				{
					r = this.Math.rand(0, 4);

					if (r == 0)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
					}
					else if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/pike"));
					}
					else if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
					}
					else if (r == 4)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
					}
				}
			}
			else
			{
				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
				{
					r = this.Math.rand(2, 10);

					if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
					}
					else if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
					}
					else if (r == 4)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
					}
					else if (r == 5)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
					}
					else if (r == 6)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
					}
					else if (r == 7)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
					}
					else if (r == 8)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
					}
					else if (r == 9)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
					}
					else if (r == 10)
					{
						this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));		
						this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
					}
				}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
				{
					r = this.Math.rand(3, 11);

					if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
					}
					else if (r == 4)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
					}
					else if (r == 5)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
					}
					else if (r == 6)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
					}
					else if (r == 7)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
					}
					else if (r == 8)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/flail"));
					}
					else if (r == 9)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
					}
					else if (r == 10)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
					}
					else if (r == 11)
					{
						this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));		
						this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
					}
				}

				if (this.Math.rand(1, 100) <= 75 && this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
				{
					if (this.Math.rand(1, 100) <= 75)
					{
						this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
					}
					else
					{
						this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
					}
				}
			}

			if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 35)
			{
				if (this.Const.DLC.Unhold)
				{
					r = this.Math.rand(1, 3);

					if (r == 1)
					{
						this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
					}
					else if (r == 2)
					{
						this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
					}
					else if (r == 3)
					{
						this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
					}
				}
				else
				{
					r = this.Math.rand(1, 2);
	
					if (r == 1)
					{
						this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
					}
					else if (r == 2)
					{
						this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
					}
				}
			}

			local armor;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
			{
				r = this.Math.rand(2, 8)
	
				if (r == 2)
				{
					armor = this.new("scripts/items/armor/blotched_gambeson");
				}
				else if (r == 3)
				{
					armor = this.new("scripts/items/armor/padded_leather");
				}
				else if (r == 4)
				{
					armor = this.new("scripts/items/armor/worn_mail_shirt");
				}
				else if (r == 5)
				{
					armor = this.new("scripts/items/armor/patched_mail_shirt");
				}
				else if (r == 6)
				{
					armor = this.new("scripts/items/armor/worn_mail_shirt");
				}
				else if (r == 7)
				{
					armor = this.new("scripts/items/armor/patched_mail_shirt");
				}
				else if (r == 8)
				{
					armor = this.new("scripts/items/armor/leather_lamellar");
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				r = this.Math.rand(2, 8);

				if (r == 2)
				{
					armor = this.new("scripts/items/armor/leather_lamellar");
				}
				else if (r == 3)
				{
					armor = this.new("scripts/items/armor/worn_mail_shirt");
				}
				else if (r == 4)
				{
					armor = this.new("scripts/items/armor/patched_mail_shirt");
				}
				else if (r == 5)
				{
					armor = this.new("scripts/items/armor/worn_mail_shirt");
				}
				else if (r == 6)
				{
					armor = this.new("scripts/items/armor/patched_mail_shirt");
				}
				else if (r == 7)
				{
					armor = this.new("scripts/items/armor/leather_scale_armor");
				}
				else if (r == 8)
				{
					armor = this.new("scripts/items/armor/leather_lamellar");
				}
 			}

			this.m.Items.equip(armor);

			local r;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 20)
			{
				r = this.Math.rand(1, 5);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/dented_nasal_helmet"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				r = this.Math.rand(1, 5);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/dented_nasal_helmet"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet_with_rusty_mail"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/nordic_helmet"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
			{
				r = this.Math.rand(1, 5);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/dented_nasal_helmet"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet_with_rusty_mail"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
			{
				r = this.Math.rand(1, 6);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/dented_nasal_helmet"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet_with_rusty_mail"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
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

		if (this.m.Type == this.Const.EntityType.BanditRaider)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.removeByID("perk.bullseye");

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
				this.m.Skills.add(this.new("scripts/skills/effects/perk_backstabber_effect"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
			{
				this.m.Skills.removeByID("perk.battle_forged");
				this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
			}
		}

		if (this.ClassName == "bandit_raider" || this.ClassName == "bandit_raider_wolf")
		{
			if (!this.Tactical.State.isScenarioMode())
			{
				local b = this.m.BaseProperties;
				b.IsSpecializedInDaggers = true;
				this.m.Skills.update();
			}
		}
	};
});
})
