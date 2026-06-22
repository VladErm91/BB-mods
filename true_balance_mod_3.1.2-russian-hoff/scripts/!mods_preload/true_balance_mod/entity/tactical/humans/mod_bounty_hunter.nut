::mods_registerMod("mod_bounty_hunter", 1.8, "True Balance Mod Bounty Hunter");
::mods_queue("mod_bounty_hunter", "mod_true_balance", function() {
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

		if (this.ClassName == "bounty_hunter")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag) != null)
			{
				this.m.Items.removeFromBag(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag));
			}

			local r;

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
			{
				local weapons = [
					"weapons/billhook",
					"weapons/pike",
					"weapons/warbrand",
					"weapons/hand_axe",
					"weapons/boar_spear",
					"weapons/morning_star",
					"weapons/falchion",
					"weapons/arming_sword",
					"weapons/flail",
					"weapons/rondel_dagger"
				];

				if (this.Const.DLC.Unhold)
				{
					weapons.extend([
						"weapons/spetum"
					]);
				}

				if (this.Const.DLC.Wildmen)
				{
					weapons.extend([
						"weapons/battle_whip"
					]);
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && !this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.rondel_dagger")
			{
				if (this.Math.rand(1, 100) <= 75)
				{
					r = this.Math.rand(0, 1);

					if (r == 0)
					{
						this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
					}
					else
					{
						this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
					}
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
				}
			}
			else
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
				}
			}

			if (this.Math.rand(1, 100) <= 50)
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

			r = this.Math.rand(2, 6);

			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/armor/leather_lamellar"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
			}
	
			if (this.Math.rand(1, 100) <= 100)
			{
				local helmets = [
					"scripts/items/helmets/nasal_helmet",
					"scripts/items/helmets/mail_coif",
					"scripts/items/helmets/reinforced_mail_coif",
					"scripts/items/helmets/hood",
					"scripts/items/helmets/closed_flat_top_helmet"
				];

				this.m.Items.equip(this.new(helmets[this.Math.rand(1, helmets.len() - 1)]));
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

		if (this.ClassName == "bounty_hunter")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/effects/perk_backstabber_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
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

		if (this.ClassName == "bounty_hunter")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bounty_hunter_melee_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})