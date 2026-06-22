::mods_registerMod("mod_standard_bearer", 1.8, "True Balance Mod Standard Bearer");
::mods_queue("mod_standard_bearer", "mod_true_balance", function() {
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

		if (this.ClassName == "standard_bearer")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;
			local banner = 4;

			if (("State" in this.Tactical) && this.Tactical.State != null && !this.Tactical.State.isScenarioMode())
			{
				banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
			}
			else
			{
				banner = this.getFaction();
			}

			this.m.Surcoat = banner;
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
			local weapon = this.new("scripts/items/tools/faction_banner");
			weapon.setVariant(banner);
			this.m.Items.equip(weapon);
			r = this.Math.rand(1, 4);

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

		if (this.ClassName == "standard_bearer")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rally"));;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
		}
	};
});
})