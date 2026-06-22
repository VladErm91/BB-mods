::mods_registerMod("mod_noble_footman", 1.8, "True Balance Mod Noble Footman");
::mods_queue("mod_noble_footman", "mod_true_balance", function() {
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

		if (this.ClassName == "noble_footman")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;
			local banner = 3;

			if (!this.Tactical.State.isScenarioMode())
			{
				banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
			}
			else
			{
				banner = this.getFaction();
			}
	
			this.m.Surcoat = banner;

			if (this.Math.rand(1, 100) <= 90)
			{
				this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
			}

			r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
			}

			r = this.Math.rand(1, 2);
			local shield;

			if (r == 1)
			{
				shield = this.new("scripts/items/shields/faction_kite_shield");
			}
			else if (r == 2)
			{
				shield = this.new("scripts/items/shields/faction_heater_shield");
			}

			shield.setFaction(banner);
			this.m.Items.equip(shield);
			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				local armor = this.new("scripts/items/armor/mail_hauberk");
				armor.setVariant(28);
				this.m.Items.equip(armor);
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
			}

			local helmet;
	
			if (banner <= 4)
			{
				r = this.Math.rand(1, 4);

				if (r == 1)
				{
					helmet = this.new("scripts/items/helmets/kettle_hat");
				}
				else if (r == 2)
				{
					helmet = this.new("scripts/items/helmets/padded_kettle_hat");
				}
				else if (r == 3)
				{
					helmet = this.new("scripts/items/helmets/kettle_hat_with_mail");
				}
				else
				{
					helmet = this.new("scripts/items/helmets/mail_coif");
				}
			}
			else if (banner <= 7)
			{
				r = this.Math.rand(1, 4);
	
				if (r == 1)
				{
					helmet = this.new("scripts/items/helmets/flat_top_helmet");
				}
				else if (r == 2)
				{
					helmet = this.new("scripts/items/helmets/padded_flat_top_helmet");
				}
				else if (r == 3)
				{
					helmet = this.new("scripts/items/helmets/flat_top_with_mail");
				}
				else
				{
					helmet = this.new("scripts/items/helmets/mail_coif");
				}
			}
			else
			{
				r = this.Math.rand(1, 4);

				if (r == 1)
				{
					helmet = this.new("scripts/items/helmets/nasal_helmet");
				}
				else if (r == 2)
				{
					helmet = this.new("scripts/items/helmets/padded_nasal_helmet");
				}
				else if (r == 3)
				{
					helmet = this.new("scripts/items/helmets/nasal_helmet_with_mail");
				}
				else
				{
					helmet = this.new("scripts/items/helmets/mail_coif");
				}
			}
	
			if (helmet != null)
			{
				helmet.setPlainVariant();
				this.m.Items.equip(helmet);
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

		if (this.ClassName == "noble_footman")
		{
			this.m.Skills.removeByID("perk.battle_forged");
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_sword"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
		}
	};
});
})
