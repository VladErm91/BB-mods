::mods_registerMod("mod_mercenary_low", 1.8, "True Balance Mod Mercenary Low");
::mods_queue("mod_mercenary_low", "mod_true_balance", function() {
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

		if (this.ClassName == "mercenary_low")
		{
			this.m.Skills.removeByID("perk.anticipation");
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
			{
				this.m.Skills.removeByID("perk.battle_forged");
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
				this.m.BaseProperties.Hitpoints += 15;
				this.m.BaseProperties.MeleeSkill += 15;
				this.m.BaseProperties.Initiative += 10;
				this.m.BaseProperties.Bravery += 15;
				this.m.BaseProperties.RangedSkill += 10;
				this.m.BaseProperties.MeleeDefense += 15;
				this.m.BaseProperties.RangedDefense += 15;
				this.m.BaseProperties.FatigueRecoveryRate = 18;
				this.m.Skills.update();
			}
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

		if (this.ClassName == "mercenary_low")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bounty_hunter_melee_agent");
			this.m.AIAgent.setActor(this);

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
			{
				this.m.XP = this.Const.Tactical.Actor.Mercenary.XP;
			}
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

		if (this.ClassName == "mercenary_low")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag) != null)
			{
				this.m.Items.removeFromBag(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag));
			}	

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 120)
			{
				local r = this.Math.rand(0, 6);

				if (r <= 1)
				{
					r = this.Math.rand(1, 3);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/warfork"));
					}
					else if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
					}
				}
				else
				{
					r = this.Math.rand(2, 6);

					if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
					}
					else if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
					}
					else if (r == 4)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
					}
					else if (r == 5)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
					}
					else if (r == 6)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/flail"));
					}

					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						if (this.Math.rand(1, 100) <= 75)
						{
							r = this.Math.rand(0, 2);

							if (r == 0)
							{
								this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
							}
							else if (r == 1)
							{
								this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
							}
							else if (r == 2)
							{
								this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
							}
						}
						else
						{
							this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
						}
					}	
				}

				if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
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

				r = this.Math.rand(1, 6);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
				}
				else if (r == 3)
				{		
					this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
				}

				local r = this.Math.rand(2, 5);

				if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/mail_coif"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/closed_mail_coif"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
			{
				local r = this.Math.rand(0, 6);

				if (r >= 0)
				{
					r = this.Math.rand(1, 8);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/fencing_sword"));
					}
					else if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
					}
					else if (r == 4)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
					}
					else if (r == 5)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
					}
					else if (r == 6)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/estoc"));
					}
					else if (r == 7)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/flail"));
					}
					else if (r == 8)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/scimitar"));
					}
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
			{
				local r = this.Math.rand(0, 6);

				if (r >= 0)
				{
					r = this.Math.rand(1, 7);

					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						if (this.Math.rand(1, 100) <= 25)
						{
							r = this.Math.rand(0, 2);

							if (r == 0)
							{
								this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
							}
						}
						else
						{
							this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
						}
					}	
				}

				if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
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

				r = this.Math.rand(1, 4);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/armor/leather_lamellar"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/armor/oriental/southern_mail_shirt"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
				}

				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/reinforced_mail_coif"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/mail_coif"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/closed_mail_coif"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/greatsword_hat"));
				}
			}	
		}		
	};
});
})