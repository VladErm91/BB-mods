::mods_registerMod("mod_skeleton_medium", 1.8, "True Balance Mod Skeleton Medium");
::mods_queue("mod_skeleton_medium", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/skeleton", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.ClassName == "skeleton_medium")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_skeleton_melee_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
::mods_hookBaseClass("entity/tactical/skeleton", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.ClassName == "skeleton_medium")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
					this.m.Items.addToBag(this.new("scripts/items/weapons/ancient/pilum"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
					this.m.Items.addToBag(this.new("scripts/items/weapons/ancient/pilum"));
				}	
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_sword"));
				this.m.Items.addToBag(this.new("scripts/items/weapons/ancient/pilum"));
			}

			if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				if (this.Math.rand(1, 100) <= 66)
				{
					this.m.Items.equip(this.new("scripts/items/shields/ancient/coffin_shield"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
				}
			}

			r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_scale_harness"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_breastplate"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_mail"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_double_layer_mail"));
			}

			this.m.Items.equip(this.new("scripts/items/helmets/ancient/ancient_legionary_helmet"));
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

		if (this.ClassName == "skeleton_medium")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
			
			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
			}
		}
	};
});
})