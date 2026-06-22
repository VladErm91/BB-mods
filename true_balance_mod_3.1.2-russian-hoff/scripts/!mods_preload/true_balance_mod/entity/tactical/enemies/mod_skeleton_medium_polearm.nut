::mods_registerMod("mod_skeleton_medium_polearm", 1.8, "True Balance Mod Skeleton Medium Polearm ");
::mods_queue("mod_skeleton_medium_polearm", "mod_true_balance", function() {
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

		if (this.ClassName == "skeleton_medium_polearm")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_skeleton_polearm_agent");
			this.m.AIAgent.setActor(this);
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
			
		if (this.ClassName == "skeleton_medium_polearm")
		{
			local b = this.m.BaseProperties;
			b.IsSpecializedInPolearms = true;
			this.m.Skills.add(this.new("scripts/skills/actives/long_impale_skeleton"));
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

		if (this.ClassName == "skeleton_medium_polearm")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			if (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.Math.max(5, 80 - this.World.getTime().Days))
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/broken_bladed_pike"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/bladed_pike"));
			}

			local r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_scale_harness"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_mail"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/ancient/ancient_double_layer_mail"));
			}

			this.m.Items.equip(this.new("scripts/items/helmets/ancient/ancient_legionary_helmet"));
		}		
	};
});
})