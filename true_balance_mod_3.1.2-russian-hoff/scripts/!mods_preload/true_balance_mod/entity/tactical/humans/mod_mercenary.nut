::mods_registerMod("mod_mercenary", 1.8, "True Balance Mod Mercenary");
::mods_queue("mod_mercenary", "mod_true_balance", function() {
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

		if (this.ClassName == "mercenary")
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

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
			{
				local weapons;

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
		        {
					weapons = [
						"weapons/hooked_blade",
						"weapons/warfork",
						"weapons/warbrand",
						"weapons/longsword",
						"weapons/hand_axe",
						"weapons/boar_spear",
						"weapons/morning_star",
						"weapons/falchion",
						"weapons/reinforced_wooden_flail",
						"weapons/military_pick"
					];
				}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		        {
					weapons = [
						"weapons/hooked_blade",
						"weapons/warfork",
						"weapons/pike",
						"weapons/warbrand",
						"weapons/longsword",
						"weapons/hand_axe",
						"weapons/boar_spear",
						"weapons/morning_star",
						"weapons/falchion",
						"weapons/reinforced_wooden_flail",
						"weapons/military_pick"
					];
				}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		        {
					weapons = [
						"weapons/hooked_blade",
						"weapons/spetum",
						"weapons/pike",
						"weapons/longaxe",
						"weapons/warbrand",
						"weapons/longsword",
						"weapons/hand_axe",
						"weapons/boar_spear",
						"weapons/morning_star",
						"weapons/falchion",
						"weapons/flail",
						"weapons/military_pick"
					];
				}

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		        {
					weapons = [
						"weapons/billhook",
						"weapons/pike",
						"weapons/spetum",
						"weapons/warbrand",
						"weapons/longsword",
						"weapons/longaxe",
						"weapons/fighting_axe",
						"weapons/fighting_spear",
						"weapons/winged_mace",
						"weapons/greatsword",
						"weapons/arming_sword",
						"weapons/flail",
						"weapons/military_pick"
					];

					if (this.Const.DLC.Unhold)
					{
						weapons.extend([
							"weapons/polehammer",
							"weapons/three_headed_flail"
						]);
					}

					if (this.Const.DLC.Wildmen)
					{
						weapons.extend([
							"weapons/bardiche",
							"weapons/oriental/polemace",
							"weapons/oriental/two_handed_scimitar",
							"weapons/scimitar"
						]);
					}
				}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
		        {
					weapons = [
						"weapons/billhook",
						"weapons/pike",
						"weapons/spetum",
						"weapons/warbrand",
						"weapons/longaxe",
						"weapons/fighting_axe",
						"weapons/fighting_spear",
						"weapons/winged_mace",
						"weapons/greatsword",
						"weapons/arming_sword",
						"weapons/flail",
						"weapons/military_pick"
					];

					if (this.Const.DLC.Unhold)
					{
						weapons.extend([
							"weapons/polehammer",
							"weapons/three_headed_flail"
						]);
					}

					if (this.Const.DLC.Wildmen)
					{
						weapons.extend([
							"weapons/bardiche",
							"weapons/oriental/polemace",
							"weapons/oriental/two_handed_scimitar",
							"weapons/scimitar"
						]);
					}
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 120)
				{
					r = this.Math.rand(0, 3);

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
					r = this.Math.rand(1, 2);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
					}
				}
			}

			if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 60)
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

			if (this.Const.DLC.Unhold)
			{
				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 80)
				{
					r = this.Math.rand(8, 12);

					if (r == 8)
					{
						this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
					}
					else if (r == 9)
					{
						this.m.Items.equip(this.new("scripts/items/armor/footman_armor"));
					}
					else if (r == 10)
					{
						this.m.Items.equip(this.new("scripts/items/armor/light_scale_armor"));
					}
					else if (r == 11)
					{
						this.m.Items.equip(this.new("scripts/items/armor/leather_scale_armor"));
					}
					else if (r == 12)
					{
						this.m.Items.equip(this.new("scripts/items/armor/oriental/mail_and_lamellar_plating"));
					}
				}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
				{
					r = this.Math.rand(9, 11);

					if (r == 9)
					{
						this.m.Items.equip(this.new("scripts/items/armor/footman_armor"));
					}
					else if (r == 10)
					{
						this.m.Items.equip(this.new("scripts/items/armor/light_scale_armor"));
					}
					else if (r == 11)
					{
						this.m.Items.equip(this.new("scripts/items/armor/oriental/mail_and_lamellar_plating"));
					}
				}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
				{
					r = this.Math.rand(8, 11);

					if (r == 8)
					{
						this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
					}
					else if (r == 9)
					{
						this.m.Items.equip(this.new("scripts/items/armor/footman_armor"));
					}
					else if (r == 10)
					{
						this.m.Items.equip(this.new("scripts/items/armor/light_scale_armor"));
					}
					else if (r == 11)
					{
						this.m.Items.equip(this.new("scripts/items/armor/oriental/mail_and_lamellar_plating"));
					}
				}
			}
			else
			{
				r = this.Math.rand(2, 8);

				if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
				}
				else if (r == 7)
				{
					this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
				}
				else if (r == 8)
				{
					this.m.Items.equip(this.new("scripts/items/armor/lamellar_harness"));
				}
			}

			local helmets;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 80)
			{
				helmets = [
					"helmets/nasal_helmet",
					"helmets/kettle_hat",
					"helmets/flat_top_helmet",
					"helmets/closed_flat_top_helmet"
				];

				if (this.Const.DLC.Wildmen)
				{
					helmets.extend([
						"helmets/nordic_helmet"
					]);
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
			{
				helmets = [
					"helmets/closed_flat_top_helmet",
					"helmets/padded_nasal_helmet",
					"helmets/padded_kettle_hat",
					"helmets/padded_flat_top_helmet",
					"helmets/closed_flat_top_with_neckguard"
				];

				if (this.Const.DLC.Wildmen)
				{
					helmets.extend([
						"helmets/nordic_helmet"
					]);
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
			{
				helmets = [
					"helmets/closed_flat_top_helmet",
					"helmets/greatsword_faction_helm",
					"helmets/barbute_helmet",
					"helmets/padded_flat_top_helmet",
					"helmets/closed_flat_top_with_neckguard"
				];
			}
			this.m.Items.equip(this.new("scripts/items/" + helmets[this.Math.rand(0, helmets.len() - 1)]));
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

		if (this.ClassName == "mercenary")
		{
			this.m.Skills.removeByID("perk.anticipation");
			this.m.Skills.removeByID("perk.overwhelm");
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_blend_in"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
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

		if (this.ClassName == "mercenary")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bounty_hunter_melee_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})