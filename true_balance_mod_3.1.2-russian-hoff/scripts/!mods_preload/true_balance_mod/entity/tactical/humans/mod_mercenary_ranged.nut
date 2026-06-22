::mods_registerMod("mod_mercenary_ranged", 1.8, "True Balance Mod Mercenary Ranged");
::mods_queue("mod_mercenary_ranged", "mod_true_balance", function() {
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

		if (this.ClassName == "mercenary_ranged")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;

	        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
	        {
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				}
	        }

	        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 150)
	        {
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				}
	        }

	        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
	        {
				r = this.Math.rand(1, 4);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				}
	        }

	        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
	        {
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				}
	        }

			r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/scramasax"));
			}
			else if (r == 3)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/hatchet"));
			}
			else if (r == 4)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/bludgeon"));
			}

			r = this.Math.rand(1, 6);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/armor/padded_leather"));
			}

			if (this.Math.rand(1, 100) <= 75)
			{
				local r = this.Math.rand(1, 7);

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
					this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/kettle_hat"));
				}
				else if (r == 7)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/mail_coif"));
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

		if (this.ClassName == "mercenary_ranged")
		{
			this.m.Skills.add(this.new("scripts/skills/effects/perk_backstabber_effect"));
			this.m.Skills.add(this.new("scripts/skills/effects/marksman_vision_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
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

		if (this.ClassName == "mercenary_ranged")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bounty_hunter_ranged_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})