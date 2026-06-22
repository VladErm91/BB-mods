::mods_registerMod("mod_bandit_leader", 1.8, "True Balance Mod Bandit Leader");
::mods_queue("mod_bandit_leader", "mod_true_balance", function() {
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
		
		if (this.m.Type == this.Const.EntityType.BanditLeader)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag) != null)
			{
				this.m.Items.removeFromBag(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
			{
				local weapons;

		   		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
		    	{
					weapons = [
						"weapons/flail",
						"weapons/hand_axe",
						"weapons/military_pick",
						"weapons/boar_spear",
						"weapons/morning_star",
						"weapons/arming_sword",
						"weapons/scramasax"
					];
		    	}

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		    	{
					weapons = [
						"weapons/three_headed_flail",
						"weapons/fighting_axe",
						"weapons/warhammer",
						"weapons/fighting_spear",
						"weapons/winged_mace",
						"weapons/noble_sword",
						"weapons/military_cleaver"
					];    
		    	}

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
		    	{
					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						weapons.extend([
							"weapons/longsword",
							"weapons/warbrand"
						]);
					}
				}

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		    	{
					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						weapons.extend([
							"weapons/greatsword",
							"weapons/warbrand",
							"weapons/greataxe",
							"weapons/two_handed_flanged_mace",
							"weapons/two_handed_flail"
						]);
					}
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				local shields;

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
		    	{
					shields = [
						"shields/wooden_shield",
						"shields/heater_shield",
						"shields/kite_shield"
					];
		    	}

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		    	{
					shields = [
						"shields/heater_shield",
						"shields/kite_shield"
					];
		    	}

				this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
			}

			if (this.Math.rand(1, 100) <= 35)
			{
				local weapons = [
					"weapons/throwing_spear"
				];
				this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
			{
				local armor;

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
				{
					armor = [
						"armor/mail_shirt",
						"armor/basic_mail_shirt",
                        "armor/mail_hauberk",
						"armor/leather_scale_armor",
						"armor/light_scale_armor"
					];
				}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
				{
					armor = [
						"armor/reinforced_mail_hauberk",
						"armor/footman_armor",
						"armor/mail_hauberk",
						"armor/mail_shirt",
						"armor/leather_scale_armor",
						"armor/light_scale_armor"
					];
				}

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		    	{
					armor = [
						"armor/reinforced_mail_hauberk",
						"armor/mail_hauberk",
						"armor/lamellar_harness",
						"armor/footman_armor",
						"armor/light_scale_armor"
					];
		    	}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
				{
					armor = [
						"armor/reinforced_mail_hauberk",
						"armor/lamellar_harness",
					];
				}

		    	this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
			{
		    	local helmet;

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
		    	{
			    	helmet = [
				    	"helmets/closed_mail_coif",
				    	"helmets/padded_kettle_hat",
				    	"helmets/padded_flat_top_helmet",
				    	"helmets/nasal_helmet_with_mail",
				    	"helmets/padded_nasal_helmet",
				    	"helmets/closed_flat_top_with_neckguard",
				    	"helmets/closed_flat_top_helmet"
					];
		    	}

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		    	{
					helmet = [
						"helmets/kettle_hat_with_mail",
						"helmets/padded_flat_top_helmet",
				    	"helmets/padded_kettle_hat",
						"helmets/nasal_helmet_with_mail",
						"helmets/bascinet_with_mail",
				    	"helmets/closed_flat_top_with_neckguard",
				    	"helmets/closed_flat_top_helmet"
					];
		    	}

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		    	{
					helmet = [
						"helmets/kettle_hat_with_mail",
						"helmets/padded_flat_top_helmet",
						"helmets/nasal_helmet_with_mail",
						"helmets/flat_top_with_mail",
						"helmets/bascinet_with_mail",
					    "helmets/closed_flat_top_with_neckguard",
					    "helmets/closed_flat_top_helmet"
					];
		    	}

		    	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
		    	{
					helmet = [
						"helmets/kettle_hat_with_closed_mail",
						"helmets/kettle_hat_with_mail",
						"helmets/flat_top_with_mail",
						"helmets/bascinet_with_mail"
						"helmets/nasal_helmet_with_mail",
					];
		    	}

				this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
			}

			if (this.m.IsMiniboss)
			{	
				local gt = this.getroottable();
				local shields = clone gt.Const.Items.NamedShields;
				shields.extend([
					"shields/named/named_bandit_kite_shield",
					"shields/named/named_bandit_heater_shield"
				]);
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.equip(this.new("scripts/items/" + gt.Const.Items.NamedMeleeWeapons[this.Math.rand(0, 	gt.Const.Items.NamedMeleeWeapons.len() - 1)]));
					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						local shields = [
							"shields/heater_shield",
							"shields/kite_shield"
						];
						this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
					}
				}
				else if (r == 2)
				{
					local weapons = [
							"weapons/three_headed_flail",
							"weapons/fighting_axe",
							"weapons/warhammer",
							"weapons/fighting_spear",
							"weapons/winged_mace",
							"weapons/noble_sword",
							"weapons/military_cleaver"
						];  
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
				}
				else if (r == 3)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
					local armor = [
						"armor/named/heraldic_mail_armor",
						"armor/named/golden_scale_armor",
						"armor/named/named_sellswords_armor",
						"armor/named/named_golden_lamellar_armor",
						"armor/named/leopard_armor",
						"armor/named/green_coat_of_plates_armor",
						"armor/named/brown_coat_of_plates_armor"
					];
					this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
				}
				else
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
					this.m.Items.equip(this.new("scripts/items/" + gt.Const.Items.NamedHelmets[this.Math.rand(0, gt.Const.Items.NamedHelmets.len() - 1)]));
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

		if (this.m.Type == this.Const.EntityType.BanditLeader)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
			}
		}
	};
});
})