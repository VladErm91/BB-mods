::mods_registerMod("mod_zombie", 1.8, "True Balance Mod Zombie");
::mods_queue("mod_zombie", "mod_true_balance", function() {
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

		if (this.ClassName == "zombie")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_zombie_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
::mods_hookBaseClass("entity/tactical/enemies/zombie", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.ClassName == "zombie_yeoman" || this.ClassName == "zombie_knight" || this.ClassName == "zombie_nomad" || this.ClassName == "zombie_betrayer" || this.ClassName == "zombie_boss" || this.ClassName == "zombie_player" || this.ClassName == "zombie_treasure_hunter")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_zombie_agent");
			this.m.AIAgent.setActor(this);
		}

		if (this.ClassName == "zombie_bodygard")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_zombie_bodyguard_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
::mods_hookBaseClass("entity/tactical/enemies/zombie_yeoman", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.ClassName == "zombie_yeoman_bodyguard")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_zombie_bodyguard_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
::mods_hookBaseClass("entity/tactical/enemies/zombie_nomad", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.ClassName == "zombie_nomad_bodyguard")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_zombie_bodyguard_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
::mods_hookBaseClass("entity/tactical/enemies/zombie_knight", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.ClassName == "zombie_knight_bodyguard")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_zombie_bodyguard_agent");
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

		if (this.ClassName == "zombie" || this.ClassName == "zombie_yeoman" || this.ClassName == "zombie_knight" || this.ClassName == "zombie_nomad" || this.ClassName == "zombie_betrayer" || this.ClassName == "zombie_bodygard" || this.ClassName == "zombie_player" || this.ClassName == "zombie_treasure_hunter" || this.ClassName == "zombie_nomad_bodyguard" || this.ClassName == "zombie_yeoman_bodyguard" || this.ClassName == "zombie_knight_bodyguard")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_riposte"));
			this.m.Skills.add(this.new("scripts/skills/effects/ripostes_effect"));
			this.m.Skills.add(this.new("scripts/skills/effects/buckler_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
		}

		if (this.ClassName == "zombie"|| this.ClassName == "zombie_yeoman" || this.ClassName == "zombie_nomad"
		|| this.ClassName == "zombie_betrayer"|| this.ClassName == "zombie_bodygard"|| this.ClassName == "zombie_boss"|| this.ClassName == "zombie_player"|| this.ClassName == "zombie_treasure_hunter" || this.ClassName == "zombie_nomad_bodyguard" || this.ClassName == "zombie_yeoman_bodyguard")
		{
			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 80)
			{
				this.m.Skills.removeByID("perk.battle_forged");
			}
		}
	};
});
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

		if (this.ClassName == "zombie" && !this.m.IsMiniboss)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 40)
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					r = this.Math.rand(1, 7);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/knife"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
					}
					else if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
					}
					else if (r == 4)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
					}
					else if (r == 5)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
					}
					else if (r == 6)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
					}
					else if (r == 7)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
					}
				}
			}
			else
			{	
				if (this.Math.rand(1, 100) <= 80)
				{
					r = this.Math.rand(1, 8);

					if (r == 1)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/knife"));
					}
					else if (r == 2)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
					}
					else if (r == 3)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
					}
					else if (r == 4)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
					}
					else if (r == 5)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
					}
					else if (r == 6)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
					}
					else if (r == 7)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
					}
					else if (r == 8)
					{
						this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
					}
				}
			}		

			r = this.Math.rand(1, 10);
			local armor;

			if (r == 1)
			{
				armor = this.new("scripts/items/armor/leather_tunic");
			}
			else if (r == 2)
			{
				armor = this.new("scripts/items/armor/linen_tunic");
			}
			else if (r == 3)
			{
				armor = this.new("scripts/items/armor/linen_tunic");
			}
			else if (r == 4)
			{
				armor = this.new("scripts/items/armor/sackcloth");
			}
			else if (r == 5)
			{
				armor = this.new("scripts/items/armor/tattered_sackcloth");
			}
			else if (r == 6)
			{
				armor = this.new("scripts/items/armor/leather_wraps");
			}
			else if (r == 7)
			{
				armor = this.new("scripts/items/armor/apron");
			}
			else if (r == 8)
			{
				armor = this.new("scripts/items/armor/butcher_apron");
			}
			else if (r == 9)
			{
				armor = this.new("scripts/items/armor/monk_robe");
			}
			else if (r == 10)
			{
				armor = this.new("scripts/items/armor/thick_tunic");
			}

			if (this.Math.rand(1, 100) <= 50)
			{
				armor.setArmor(armor.getArmorMax() / 2 - 1);
			}

			this.m.Items.equip(armor);

			if (this.Math.rand(1, 100) <= 33)
			{
				r = this.Math.rand(1, 5);
				local helmet;

				if (r == 1)
				{
					helmet = this.new("scripts/items/helmets/hood");
				}
				else if (r == 2)
				{
					helmet = this.new("scripts/items/helmets/aketon_cap");
				}
				else if (r == 3)
				{
					helmet = this.new("scripts/items/helmets/full_aketon_cap");
				}
				else if (r == 4)
				{
					helmet = this.new("scripts/items/helmets/open_leather_cap");
				}
				else if (r == 5)
				{
					helmet = this.new("scripts/items/helmets/full_leather_cap");
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					helmet.setArmor(helmet.getArmorMax() / 2 - 1);
				}

				this.m.Items.equip(helmet);
			}
		}	
	};
});
})