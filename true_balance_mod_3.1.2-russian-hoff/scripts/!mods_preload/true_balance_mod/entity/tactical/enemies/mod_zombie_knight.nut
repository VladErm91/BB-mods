::mods_registerMod("mod_zombie_knight", 1.8, "True Balance Mod Zombie Knight");
::mods_queue("mod_zombie_knight", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/enemies/zombie", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.m.Type == this.Const.EntityType.ZombieKnight)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
			{
				local weapons;

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
		    	{
					weapons = [
						"weapons/hand_axe",
						"weapons/morning_star",
						"weapons/arming_sword",
						"weapons/flail",
						"weapons/longsword",
						"weapons/military_cleaver"
					];
		        }

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		        {
					weapons = [
						"weapons/winged_mace",
						"weapons/hand_axe",
						"weapons/fighting_axe",
						"weapons/morning_star",
						"weapons/arming_sword",
						"weapons/flail",
						"weapons/longsword",
						"weapons/military_cleaver"
					];
		        }

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		        {
					weapons = [
						"weapons/winged_mace",
						"weapons/fighting_axe",
						"weapons/arming_sword",
						"weapons/flail",
						"weapons/longsword",
						"weapons/greataxe",
						"weapons/military_cleaver"
					];    
		        }

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		        {
					weapons = [
						"weapons/winged_mace",
						"weapons/fighting_axe",
						"weapons/arming_sword",
						"weapons/flail",
						"weapons/longsword",
						"weapons/greatsword",
						"weapons/greataxe",
						"weapons/military_cleaver"
					];    
		        }

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
		        {
					weapons = [
						"weapons/winged_mace",
						"weapons/fighting_axe",
						"weapons/arming_sword",
						"weapons/flail",
						"weapons/greatsword",
						"weapons/greataxe",
						"weapons/military_cleaver"
					];    
		        }

				if (this.Const.DLC.Unhold && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
				{
		       		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		        	{
						weapons.extend([
							"weapons/two_handed_flail"
						]);
		        	}
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				local shields = [
					"shields/worn_heater_shield",
					"shields/worn_kite_shield"
				];
				this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
			{
				local armor;

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
		        {
					armor = [
						"armor/decayed_reinforced_mail_hauberk"
					];

					local a = this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]);

					if (this.Math.rand(1, 100) <= 33)
					{
						a.setArmor(a.getArmorMax() / 2 - 1);
					}
					this.m.Items.equip(a);
				}

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		        {
					armor = [
						"armor/decayed_coat_of_scales",
						"armor/decayed_reinforced_mail_hauberk"
					];

					local a = this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]);

					if (this.Math.rand(1, 100) <= 33)
					{
						a.setArmor(a.getArmorMax() / 2 - 1);
					}
					this.m.Items.equip(a);
				}

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		        {
					armor = [
						"armor/decayed_coat_of_scales"
					];

					this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));

				}

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		        {
					armor = [
						"armor/decayed_coat_of_plates",
						"armor/decayed_coat_of_scales"
					];

					this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
				}
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
			{
				local helmet;

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
		        {
					helmet = [
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_full_helm",
						"helmets/decayed_full_helm",
						"helmets/decayed_full_helm",
						"helmets/decayed_closed_flat_top_with_mail"
					];
					local h = this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]);

					if (this.Math.rand(1, 100) <= 33)
					{
						h.setArmor(h.getArmorMax() / 2 - 1);
					}
					this.m.Items.equip(h);
				}
	
		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		        {
					helmet = [
						"helmets/decayed_closed_flat_top_with_sack",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_full_helm",
						"helmets/decayed_full_helm",
						"helmets/decayed_full_helm",
						"helmets/decayed_closed_flat_top_with_mail"
					];
					local h = this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]);

					if (this.Math.rand(1, 100) <= 33)
					{
						h.setArmor(h.getArmorMax() / 2 - 1);
					}
					this.m.Items.equip(h);
				}

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		        {
					helmet = [
						"helmets/decayed_closed_flat_top_with_sack",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_full_helm",
						"helmets/decayed_full_helm",
						"helmets/decayed_full_helm"
					];
					this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
				}

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 80)
		        {
					helmet = [
						"helmets/decayed_closed_flat_top_with_sack",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_full_helm",
						"helmets/decayed_full_helm",
						"helmets/decayed_full_helm",
						"helmets/decayed_great_helm",
						"helmets/decayed_great_helm",
						"helmets/decayed_great_helm"
					];
					this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
				}
			}

			if (this.m.IsMiniboss)
		    {	
		   		local weapons = [
		   			"weapons/named/named_axe",
					"weapons/named/named_cleaver",
					"weapons/named/named_flail",
					"weapons/named/named_greataxe",
					"weapons/named/named_greatsword",
					"weapons/named/named_mace",
					"weapons/named/named_two_handed_hammer"
				];

				if (this.Const.DLC.Unhold)
				{
					weapons.extend([
						"weapons/named/named_two_handed_mace",
						"weapons/named/named_two_handed_flail"
					]);
				}

				local shields = this.Const.Items.NamedUndeadShields;

				if (this.Math.rand(1, 100) <= 50)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						local shields = [
							"shields/worn_heater_shield",
							"shields/worn_kite_shield"
						];
						this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
					}
				}
				else
				{
					local weapons = [
							"weapons/winged_mace",
							"weapons/fighting_axe",
							"weapons/arming_sword",
							"weapons/flail",
							"weapons/military_cleaver"
						]; 
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
				}
			}
		}
	};
});
::mods_hookBaseClass("entity/tactical/enemies/zombie_knight", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.m.Type == this.Const.EntityType.ZombieBetrayer)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
			{
				local weapons;

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 1)
		        {
					weapons = [
						"weapons/winged_mace",
						"weapons/fighting_axe",
						"weapons/noble_sword",
						"weapons/flail",
						"weapons/military_cleaver"
					];    
		        }

				if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
				{
		        	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 1)
		        	{
						weapons.extend([
							"weapons/greatsword",
							"weapons/greataxe"
						]);
		        	}
				}

				if (this.Const.DLC.Unhold && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
				{
		       		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 1)
		        	{
						weapons.extend([
							"weapons/two_handed_flail"
						]);
		        	}
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				local shields = [
					"shields/worn_heater_shield",
					"shields/worn_kite_shield"
				];
				this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
			{
				local armor;

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 1)
		        {
					armor = [
						"armor/decayed_coat_of_plates",
						"armor/decayed_coat_of_scales"
					];

					this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
				}
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
			{
				local helmet;

		        if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 1)
		        {
					helmet = [
						"helmets/decayed_closed_flat_top_with_sack",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_closed_flat_top_with_mail",
						"helmets/decayed_full_helm",
						"helmets/decayed_full_helm",
						"helmets/decayed_full_helm",
						"helmets/decayed_great_helm",
						"helmets/decayed_great_helm",
						"helmets/decayed_great_helm"
					];
					this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
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

		if (this.m.Type == this.Const.EntityType.ZombieKnight || this.m.Type == this.Const.EntityType.ZombieBoss || this.m.Type == this.Const.EntityType.ZombieBetrayer)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_full_force"));
			}
		}

		if (this.m.Type == this.Const.EntityType.ZombieBoss)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
			local b = this.m.BaseProperties;
			b.AdditionalActionPointCost = 1;
		}
	};
});
})