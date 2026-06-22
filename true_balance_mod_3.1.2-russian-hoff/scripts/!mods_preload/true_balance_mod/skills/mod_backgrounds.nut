::mods_registerMod("mod_backgrounds", 1.8, "True Balance Mod Backgrounds");
::mods_queue("mod_backgrounds", "mod_true_balance", function() {
::mods_hookBaseClass("skills/backgrounds/character_background", function(o) 
{
	::mods_override (o[o.SuperName], "adjustHiringCostBasedOnEquipment", function()
	{
		local actor = this.getContainer().getActor();
		actor.m.HiringCost = this.Math.floor(this.m.HiringCost + 500 * this.Math.pow(this.m.Level - 1, 1.5));
		local items = actor.getItems().getAllItems();
		local cost = 0;

		foreach( i in items )
		{
			cost = cost + i.getValue();
		}

		cost = cost * 1.25;
		actor.m.HiringCost = actor.m.HiringCost + cost;
		actor.m.HiringCost *= 0.1;
		actor.m.HiringCost = this.Math.ceil(actor.m.HiringCost);
		actor.m.HiringCost *= 10;

		if (this.World.Assets.m.IsBrigand && (actor.getBackground().getID() == "background.poacher" || actor.getBackground().getID() == "background.nomad" || actor.getBackground().getID() == "background.thief" || actor.getBackground().getID() == "background.raider" || actor.getBackground().getID() == "background.deserter" || actor.getBackground().getID() == "background.manhunter" || actor.getBackground().getID() == "background.killer_on_the_run" || actor.getBackground().getID() == "background.assassin_southern" || actor.getBackground().getID() == "background.assassin"))
		{
			actor.m.HiringCost *= 0.8;
		}
		else
		{
			actor.m.HiringCost *= 1;			
		}
	})
});
::mods_hookNewObject("skills/backgrounds/swordmaster_background", function(o) 
{
	o.onChangeAttributes = function()
	{
		local c = {
			Hitpoints = [
				-7,
				-10
			],
			Bravery = [
				12,
				10
			],
			Stamina = [
				-15,
				-10
			],
			MeleeSkill = [
				25,
				20
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				10,
				15
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}
});
::mods_hookNewObject("skills/backgrounds/lumberjack_background", function(o) 
{
	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 2)
		{
			local item = this.new("scripts/items/armor/linen_tunic");
			item.setVariant(6);
			items.equip(item);
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
	}
});
::mods_hookNewObject("skills/backgrounds/slave_background", function(o) 
{
	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/monk_robe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/headscarf"));
		}
	}
});
::mods_hookNewObject("skills/backgrounds/peddler_southern_background", function(o) 
{
	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/oriental/cloth_sash"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
		}
	}
});
::mods_hookNewObject("skills/backgrounds/peddler_background", function(o) 
{
	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/feathered_hat"));
		}
	}
});
})