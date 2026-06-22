::mods_registerMod("mod_goblin_fighter", 1.8, "True Balance Mod Goblin Fighter");
::mods_queue("mod_goblin_fighter", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/goblin", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.m.Type == this.Const.EntityType.GoblinFighter && !this.m.IsMiniboss)
		{
			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag) != null)
			{
				this.m.Items.removeFromBag(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Bag));
			}
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
			{
				local weapons = [
					"weapons/greenskins/goblin_falchion",
					"weapons/greenskins/goblin_spear",
					"weapons/greenskins/goblin_notched_blade"
				];

				if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
				{
					weapons.extend([
						"weapons/greenskins/goblin_pike"
					]);
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() != "weapon.goblin_spear" && this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() != "weapon.named_goblin_spear")
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.goblin_notched_blade")
				{
					this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
				}
				else
				{
					if (this.Math.rand(1, 100) <= 50)
					{
						this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
					}
					else
					{
						local shields = [
							"shields/greenskins/goblin_light_shield",
							"shields/greenskins/goblin_heavy_shield"
						];
						this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
					}
				}
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
			{
				local armor = [
					"armor/greenskins/goblin_light_armor",
					"armor/greenskins/goblin_medium_armor",
					"armor/greenskins/goblin_heavy_armor"
				];
				this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
			{
				if (this.Math.rand(1, 100) <= 75)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/greenskins/goblin_light_helmet"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/helmets/greenskins/goblin_heavy_helmet"));
				}
			}		
		}
	}
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

		if (this.m.Type == this.Const.EntityType.GoblinFighter)
		{
			if (this.ClassName == "goblin_fighter_low")
			{
				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 50)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_dagger"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
					local b = this.m.BaseProperties;
					this.m.BaseProperties.MeleeSkill += 5;
					this.m.BaseProperties.RangedSkill += 5;
					this.m.BaseProperties.RangedDefense += 5;
					this.m.BaseProperties.MeleeDefense += 5;
					b.DamageDirectMult = 1.25;
					b.IsSpecializedInSpears = true;
					b.IsSpecializedInSwords = true;

					if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 50)
					{
						b.MeleeDefense += 5;
						b.RangedDefense += 5;
						this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
	
						if (this.World.getTime().Days >= 90)
						{
							b.RangedSkill += 5;
						}
					}

					this.m.Skills.update();
				}	
			}
			else
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_dagger"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
			}

			if (this.World.getTime().Days >= 80)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			}
		}	
	};
});
::mods_hookBaseClass("entity/tactical/goblin", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.m.Type == this.Const.EntityType.GoblinFighter)
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_goblin_melee_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})