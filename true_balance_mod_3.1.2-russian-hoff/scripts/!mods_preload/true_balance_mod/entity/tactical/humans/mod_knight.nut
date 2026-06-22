::mods_registerMod("mod_knight", 1.8, "True Balance Mod Knight");
::mods_queue("mod_knight", "mod_true_balance", function() {
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

		if (this.ClassName == "knight")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
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

			if (this.Math.rand(1, 100) <= 90)
			{
				this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
			}
	
			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/fighting_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/noble_sword"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
				}
			}

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				r = this.Math.rand(1, 2);
				local shield;

				if (r == 1)
				{
					shield = this.new("scripts/items/shields/faction_heater_shield");
				}
				else if (r == 2)
				{
					shield = this.new("scripts/items/shields/faction_heater_shield");
				}

				shield.setFaction(banner);
				this.m.Items.equip(shield);
			}

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/armor/coat_of_plates"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/armor/coat_of_scales"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/armor/heavy_lamellar_armor"));
				}
			}

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				r = this.Math.rand(1, 2);
	
				if (r == 1)
				{
					local helmet = this.new("scripts/items/helmets/full_helm");
					helmet.setPlainVariant();
					this.m.Items.equip(helmet);
				}
				else if (r == 2)
				{
					local helm = this.new("scripts/items/helmets/faction_helm");
					helm.setVariant(banner);
					this.m.Items.equip(helm);
				}
			}
			if (this.m.IsMiniboss)
			{
				local weapons = [
					"weapons/named/named_axe",
					"weapons/named/named_greatsword",
					"weapons/named/named_mace",
					"weapons/named/named_warbrand",
					"weapons/named/named_sword"
				];
				local shields = clone this.Const.Items.NamedShields;
				local armor = [
					"armor/named/brown_coat_of_plates_armor",
					"armor/named/golden_scale_armor",
					"armor/named/green_coat_of_plates_armor",
					"armor/named/heraldic_mail_armor"
				];
				local r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						local shield;

						r = this.Math.rand(1, 2);

						if (r == 1)
						{
							shield = this.new("scripts/items/shields/faction_heater_shield");
						}
						else if (r == 2)
						{
							shield = this.new("scripts/items/shields/faction_heater_shield");
						}
		
						shield.setFaction(banner);
						this.m.Items.equip(shield);
					}
				}
				else if (r == 2)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					r = this.Math.rand(1, 2);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/fighting_axe"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/noble_sword"));
					}

					this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
				}
				else
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
					this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
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

		if (this.ClassName == "knight")
		{
			local b = this.m.BaseProperties;
			b.IsSpecializedInSwords = false;
			b.IsSpecializedInAxes = false;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_full_force"));
		}
	};
});
})