::mods_registerMod("mod_bandit_marksman", 1.8, "True Balance Mod Bandit Marksman");
::mods_queue("mod_bandit_marksman", "mod_true_balance", function() {
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

		if (this.m.Type == this.Const.EntityType.BanditMarksman)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			this.m.Items.removeFromBag(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag));

			local r;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/light_crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{

				this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			}

			r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
			}
			else if (r == 3)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/hatchet"));
			}
			else if (r == 4)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/bludgeon"));
			}

			r = this.Math.rand(1, 3);
			local armor;

			if (r == 1)
			{
				armor = this.new("scripts/items/armor/thick_tunic");
			}
			else if (r == 2)
			{
				armor = this.new("scripts/items/armor/padded_surcoat");
			}
			else if (r == 3)
			{
				armor = this.new("scripts/items/armor/blotched_gambeson");
			}

			this.m.Items.equip(armor);

			r = this.Math.rand(1, 5);
			local helmet;

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/hood"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
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
				this.m.Items.equip(this.new("scripts/items/helmets/mouth_piece"));
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

		if (this.m.Type == this.Const.EntityType.BanditMarksman)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/effects/perk_backstabber_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));

			this.m.BaseProperties.IsSpecializedInBows = false;
			this.m.BaseProperties.IsSpecializedInCrossbows = false;
			this.m.BaseProperties.Vision = 7;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
				this.m.BaseProperties.RangedSkill += 5;
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
				this.m.BaseProperties.IsSpecializedInCrossbows = true;
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
			    this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			    this.m.BaseProperties.RangedSkill += 5;
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
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

		if (this.m.Type == this.Const.EntityType.BanditMarksman)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bandit_ranged_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})