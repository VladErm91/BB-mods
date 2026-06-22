::mods_registerMod("mod_bounty_hunter_ranged", 1.8, "True Balance Mod Bounty Hunter Ranged");
::mods_queue("mod_bounty_hunter_ranged", "mod_true_balance", function() {
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

		if (this.ClassName == "bounty_hunter_ranged")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r = this.Math.rand(1, 2);

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

			r = this.Math.rand(2, 4);

			if (r == 2)
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

			r = this.Math.rand(1, 5);

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
				this.m.Items.equip(this.new("scripts/items/armor/leather_lamellar"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/armor/ragged_surcoat"));
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

		if (this.ClassName == "bounty_hunter_ranged")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/effects/backstabber_effect"));
			this.m.Skills.add(this.new("scripts/skills/effects/marksman_vision_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
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

		if (this.ClassName == "bounty_hunter_ranged")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bounty_hunter_ranged_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})