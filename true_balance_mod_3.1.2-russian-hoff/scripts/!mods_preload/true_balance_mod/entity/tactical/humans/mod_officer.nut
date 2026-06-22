::mods_registerMod("mod_officer", 1.8, "True Balance Mod Officer");
::mods_queue("mod_officer", "mod_true_balance", function() {
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

		if (this.ClassName == "officer")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;
			local banner = 3;

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
			{
				local weapons = [
					"weapons/shamshir",
					"weapons/oriental/heavy_southern_mace"
				];
	
				if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
				{
					weapons.extend([
						"weapons/oriental/two_handed_scimitar"
					]);
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				this.m.Items.equip(this.new("scripts/items/shields/oriental/metal_round_shield"));
			}

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
			{
				r = this.Math.rand(1, 2);
	
				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/armor/oriental/padded_mail_and_lamellar_hauberk"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/armor/oriental/southern_long_mail_with_padding"));
				}
			}

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/oriental/turban_helmet"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/oriental/heavy_lamellar_helmet"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/helmets/oriental/southern_helmet_with_coif"));
				}
			}

			if (this.m.IsMiniboss)
			{
				local weapons = [
					"weapons/named/named_mace",
					"weapons/named/named_two_handed_scimitar",
					"weapons/named/named_spear",
					"weapons/named/named_shamshir",
					"weapons/named/named_swordlance",
					"weapons/named/named_polemace"
				];
				local shields = this.Const.Items.NamedSouthernShields;
				local armor = this.Const.Items.NamedSouthernArmors;
				local helmets = this.Const.Items.NamedSouthernHelmets;
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						this.m.Items.equip(this.new("scripts/items/shields/oriental/metal_round_shield"));
					}
				}
				else if (r == 2)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					local weapons = [
						"weapons/shamshir",
						"weapons/oriental/heavy_southern_mace"
					];
					this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
				}
				else if (r == 3)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
					this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
				}
				else
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
					this.m.Items.equip(this.new("scripts/items/" + helmets[this.Math.rand(0, helmets.len() - 1)]));
				}
			}
		}		
	};
});
::mods_hookExactClass("entity/tactical/humans/officer", function ( a )
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

		if (this.ClassName == "officer")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		}
	};
});
})