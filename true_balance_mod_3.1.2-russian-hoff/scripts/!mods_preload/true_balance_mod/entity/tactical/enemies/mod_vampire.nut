::mods_registerMod("mod_vampire", 1.8, "True Balance Mod Vampire");
::mods_queue("mod_vampire", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.ClassName == "vampire" && !this.m.IsMiniboss)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 80)
		    {
				r = this.Math.rand(1, 4);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
				}
			}
			else
			{	
				r = this.Math.rand(1, 5);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
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

		if (this.m.Type == this.Const.EntityType.Vampire)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/zombie_bite"));
		}
	};
});	
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.m.Type == this.Const.EntityType.Vampire)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_vampire_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})