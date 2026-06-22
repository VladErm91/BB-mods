::mods_registerMod("mod_gladiator", 1.8, "True Balance Mod Gladiator");
::mods_queue("mod_gladiator", "mod_true_balance", function() {
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

		if (this.ClassName == "gladiator")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
			{
				local weapons = [
					"weapons/shamshir",
					"weapons/shamshir",
					"weapons/oriental/heavy_southern_mace",
					"weapons/oriental/heavy_southern_mace",
					"weapons/fighting_axe",
					"weapons/fighting_axe",
					"weapons/fighting_spear"
				];

				if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
				{
					weapons.extend([
						"weapons/oriental/two_handed_scimitar",
						"weapons/oriental/swordlance",
						"weapons/oriental/polemace",
						"weapons/two_handed_hammer",
						"weapons/greataxe"
					]);
				}

				if (this.Const.DLC.Wildmen && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
				{
					weapons.extend([
						"weapons/two_handed_flail",
						"weapons/two_handed_flanged_mace",
						"weapons/bardiche"
					]);
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
			{
				local weapons = [
					"weapons/throwing_axe",
					"weapons/javelin"
				];

				if (this.Const.DLC.Unhold)
				{
					weapons.push("weapons/throwing_spear");
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				local offhand = [
					"tools/throwing_net",
					"shields/oriental/metal_round_shield"
				];
				this.m.Items.equip(this.new("scripts/items/" + offhand[this.Math.rand(0, offhand.len() - 1)]));
			}

			r = this.Math.rand(1, 2);
			local a = this.new("scripts/items/armor/oriental/gladiator_harness");
			local u;
			r = this.Math.rand(1, 2);
	
			if (r == 1)
			{
				u = this.new("scripts/items/armor_upgrades/light_gladiator_upgrade");
			}
			else if (r == 2)
			{
				u = this.new("scripts/items/armor_upgrades/heavy_gladiator_upgrade");
			}
	
			a.setUpgrade(u);
			this.m.Items.equip(a);
			r = this.Math.rand(2, 3);

			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/oriental/gladiator_helmet"));
			}

			if (this.m.IsMiniboss)
			{
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));

					if (this.Math.rand(0, 1) == 0)
					{
						this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernMeleeWeapons[this.Math.rand(0, this.Const.Items.NamedSouthernMeleeWeapons.len() - 1)]));
					}
					else
					{
						this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedMeleeWeapons[this.Math.rand(0, this.Const.Items.NamedMeleeWeapons.len() - 1)]));
					}

					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						local offhand = [
							"tools/throwing_net",
							"shields/oriental/metal_round_shield"
						];
						this.m.Items.equip(this.new("scripts/items/" + offhand[this.Math.rand(0, offhand.len() - 1)]));
					}
				}
				else if (r == 2)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

					if (this.Math.rand(0, 1) == 0)
					{
						this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernShields[this.Math.rand(0, this.Const.Items.NamedSouthernShields.len() - 1)]));
					}
					else
					{
						this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedShields[this.Math.rand(0, this.Const.Items.NamedShields.len() - 1)]));
					}

					local weapons = [
						"weapons/shamshir",
						"weapons/shamshir",
						"weapons/oriental/heavy_southern_mace",
						"weapons/oriental/heavy_southern_mace",
						"weapons/fighting_axe",
						"weapons/fighting_axe",
						"weapons/fighting_spear"
					];

					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));		
				}
				else if (r == 3)
				{
					if (this.Math.rand(0, 1) == 0)
					{
						this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
						this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernArmors[this.Math.rand(0, this.Const.Items.NamedSouthernArmors.len() - 1)]));
					}
					else
					{
						this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
						this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedArmors[this.Math.rand(0, this.Const.Items.NamedArmors.len() - 1)]));
					}
				}
				else if (r == 4)
				{
					if (this.Math.rand(0, 1) == 0)
					{
						this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
						this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernHelmets[this.Math.rand(0, this.Const.Items.NamedSouthernHelmets.len() - 1)]));
					}
					else
					{
						this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
						this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedHelmets[this.Math.rand(0, this.Const.Items.NamedHelmets.len() - 1)]));
					}	
				}
			}
		}
	}		
});
::mods_hookExactClass("entity/tactical/humans/gladiator", function ( a )
{
    a.onOtherActorDeath <- function ( _killer, _victim, _skill )
	{
		if (!this.m.IsAlive || this.m.IsDying)
		{
			return;
		}

		if (_victim.getXPValue() <= 1)
		{
			return;
		}

		if (_victim.getType() == this.Const.EntityType.Slave && _victim.isAlliedWith(this))
		{
			return;
		}

		if (this.m.Type == this.Const.EntityType.Ghoul)
		{
			if (_victim.getType() == this.Const.EntityType.Zombie || _victim.getType() == this.Const.EntityType.ZombieBetrayer || _victim.getType() == this.Const.EntityType.ZombieBoss || _victim.getType() == this.Const.EntityType.ZombieKnight || _victim.getType() == this.Const.EntityType.ZombieYeoman || _victim.getType() == this.Const.EntityType.ZombieTreasureHunter && _victim.isAlliedWith(this))
			{
				return;
			}
		}
		if (this.m.Type == this.Const.EntityType.BanditLeader || this.m.Type == this.Const.EntityType.BanditMarksman || this.m.Type == this.Const.EntityType.BanditPoacher || this.m.Type == this.Const.EntityType.BanditRaider || this.m.Type == this.Const.EntityType.BanditThug || this.m.Type == this.Const.EntityType.BarbarianBeastmaster || this.m.Type == this.Const.EntityType.BarbarianChampion || this.m.Type == this.Const.EntityType.BarbarianChosen || this.m.Type == this.Const.EntityType.BarbarianDrummer || this.m.Type == this.Const.EntityType.BarbarianMarauder || this.m.Type == this.Const.EntityType.BarbarianThrall || this.m.Type == this.Const.EntityType.BountyHunter || this.m.Type == this.Const.EntityType.DesertDevil || this.m.Type == this.Const.EntityType.DesertDevil || this.m.Type == this.Const.EntityType.DesertStalker || this.m.Type == this.Const.EntityType.Executioner || this.m.Type == this.Const.EntityType.Gladiator || this.m.Type == this.Const.EntityType.HedgeKnight || this.m.Type == this.Const.EntityType.Knight || this.m.Type == this.Const.EntityType.MasterArcher || this.m.Type == this.Const.EntityType.Mercenary || this.m.Type == this.Const.EntityType.MercenaryRanged || this.m.Type == this.Const.EntityType.Arbalester || this.m.Type == this.Const.EntityType.Billman || this.m.Type == this.Const.EntityType.Footman || this.m.Type == this.Const.EntityType.Greatsword || this.m.Type == this.Const.EntityType.Sergeant || this.m.Type == this.Const.EntityType.NomadArcher || this.m.Type == this.Const.EntityType.NomadCutthroat || this.m.Type == this.Const.EntityType.NomadLeader || this.m.Type == this.Const.EntityType.NomadOutlaw || this.m.Type == this.Const.EntityType.NomadSlinger || this.m.Type == this.Const.EntityType.Swordmaster)
		{
			if (_victim.getType() == this.Const.EntityType.Warhound || _victim.getType() == this.Const.EntityType.Wardog && _victim.isAlliedWith(this))
			{
				return;
			}
		}

		if (_victim.getFaction() == this.getFaction() && _victim.getCurrentProperties().TargetAttractionMult >= 0.5 && this.getCurrentProperties().IsAffectedByDyingAllies)
		{
			local difficulty = this.Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * this.Const.Morale.AllyKilledXPMult + this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.AllyKilledDistancePow);
			if (this.m.Skills.getSkillByID("effects.witnessed_execution") != null)
			{
				difficulty += 5
				this.getSkills().removeByID("effects.witnessed_execution");
			}
			
			this.checkMorale(-1, difficulty, this.Const.MoraleCheckType.Default, "", true);
		}
		else if (this.getAlliedFactions().find(_victim.getFaction()) == null)
		{
			local difficulty = this.Const.Morale.EnemyKilledBaseDifficulty + _victim.getXPValue() * this.Const.Morale.EnemyKilledXPMult - this.Math.pow(_victim.getTile().getDistanceTo(this.getTile()), this.Const.Morale.EnemyKilledDistancePow);

			if (_killer != null && _killer.isAlive() && _killer.getID() == this.getID())
			{
				difficulty = difficulty + this.Const.Morale.EnemyKilledSelfBonus;
			}
			
			if (_killer != null && _killer.isAlive() && _killer.getID() == this.getID() && _killer.m.Skills.hasSkill("trait.bloodthirsty"))
			{
				difficulty = difficulty + 15;
			}

			this.checkMorale(1, difficulty);
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

		if (this.ClassName == "gladiator")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_blend_in"));
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

		if (this.ClassName == "gladiator")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bounty_hunter_melee_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})