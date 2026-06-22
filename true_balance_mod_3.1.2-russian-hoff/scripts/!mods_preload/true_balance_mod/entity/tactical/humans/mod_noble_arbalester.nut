::mods_registerMod("mod_noble_arbalester", 1.8, "True Balance Mod Noble Arbalester");
::mods_queue("mod_noble_arbalester", "mod_true_balance", function() {
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

		if (this.ClassName == "noble_arbalester")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			this.m.Items.removeFromBag(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag));

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

			if (this.Math.rand(1, 100) <= 80)
			{
				this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
			}

			local r;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
			{
				r = this.Math.rand(1, 1);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				}
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/heavy_crossbow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
					this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
				}
			}

			r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/shortsword"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/shortsword"));
			}

			r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/gambeson"));
			}

			local r = this.Math.rand(1, 4);
			local helmet;

			if (r == 1)
			{
				helmet = this.new("scripts/items/helmets/aketon_cap");
			}
			else if (r == 2)
			{
				helmet = this.new("scripts/items/helmets/full_aketon_cap");
			}
			else if (r == 3)
			{
				helmet = this.new("scripts/items/helmets/mail_coif");
			}
			else if (r == 4)
			{
				helmet = this.new("scripts/items/helmets/headscarf");
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

		if (this.ClassName == "noble_arbalester")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/effects/backstabber_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_tm"));
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

		if (this.ClassName == "noble_arbalester")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_military_ranged_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})
