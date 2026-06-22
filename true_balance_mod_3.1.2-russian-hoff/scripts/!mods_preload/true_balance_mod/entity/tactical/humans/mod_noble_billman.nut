::mods_registerMod("mod_noble_billman", 1.8, "True Balance Mod Noble Billman");
::mods_queue("mod_noble_billman", "mod_true_balance", function() {
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

		if (this.ClassName == "noble_billman")
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

			if (this.Const.DLC.Unhold && this.Math.rand(1, 100) <= 50)
			{
				r = this.Math.rand(0, 3);

				if (r <= 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/pike"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/polehammer"));
				}
			}	
			else
			{
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/pike"));
				}
			}

			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
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

		if (this.ClassName == "noble_billman")
		{
			this.m.Skills.removeByID("perk.battle_forged");
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
		}
	};
});
})
