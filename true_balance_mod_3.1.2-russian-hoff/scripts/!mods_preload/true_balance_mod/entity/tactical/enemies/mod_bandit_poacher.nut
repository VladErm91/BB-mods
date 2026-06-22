::mods_registerMod("mod_bandit_poacher", 1.8, "True Balance Mod Bandit Poacher");
::mods_queue("mod_bandit_poacher", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.BanditPoacher)
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

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
			{
				local weapons;

		   		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
		    	{
					weapons = [
						"weapons/short_bow",
						"weapons/staff_sling"
					];
				}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		    	{
		    		weapons = [
						"weapons/hunting_bow",
						"weapons/staff_sling"
					];
		    	}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
				
				if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.short_bow" || this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.hunting_bow")
				{
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
				}
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				local shields;

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
		    	{
					if (this.Math.rand(1, 100) <= 50)
					{
						shields = [
							"shields/buckler_shield",
							"shields/wooden_shield"
						];

						this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
					}
		    	}

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		    	{
					shields = [
						"shields/buckler_shield"
					];
					this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		    	}
			}	

			if (this.Math.rand(1, 100) <= 50)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
			}
			else
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/wooden_stick"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 20)
		    {
				this.m.Items.equip(this.new("scripts/items/armor/leather_wraps"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		    {
				local armor = [
					"armor/thick_tunic",
					"armor/leather_tunic"
				];
				this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
			{
				local armor = [
					"armor/thick_tunic",
					"armor/leather_wraps",
					"armor/leather_tunic"
				];
				this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
			}

            if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 20)
		    {
				if (this.Math.rand(1, 100) <= 50)
				{
					local r = this.Math.rand(1, 2);
	
					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/helmets/mouth_piece"));
					}
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		    {
				local r = this.Math.rand(1, 6);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/mouth_piece"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/hunters_hat"));
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/hunters_hat"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
		    {
				local r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/mouth_piece"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/hunters_hat"));
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

		if (this.m.Type == this.Const.EntityType.BanditPoacher)
		{

			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/effects/backstabber_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recoversa"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_bow"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
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

		if (this.m.Type == this.Const.EntityType.BanditPoacher)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bandit_ranged_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})