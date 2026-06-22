::mods_registerMod("mod_nomad_leader", 1.8, "True Balance Mod Nomad Leader");
::mods_queue("mod_nomad_leader", "mod_true_balance", function() {
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

		if (this.ClassName == "nomad_leader")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
			{
				local weapons;

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 60)
				{
					weapons = [
						"weapons/scimitar",
						"weapons/oriental/light_southern_mace",
						"weapons/boar_spear"
					];

					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						weapons.extend([
							"weapons/oriental/two_handed_saif"
						]);
					}
				}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
				{
					weapons = [
						"weapons/shamshir",
						"weapons/oriental/heavy_southern_mace",
						"weapons/fighting_spear"
					];

					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						weapons.extend([
							"weapons/oriental/two_handed_scimitar"
						]);
					}
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 35)
			{
				local weapons = [
					"weapons/javelin"
				];

				if (this.Const.DLC.Unhold)
				{
					weapons.extend([
						"weapons/throwing_spear"
					]);
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
			{
				local armor;

				armor = [
						"armor/oriental/plated_nomad_mail",
						"armor/oriental/southern_mail_shirt"
					];
					
				local a = this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]);
				local u = this.new("scripts/items/armor_upgrades/hyena_fur_upgrade");
				a.setUpgrade(u);
				this.m.Items.equip(a);
			}

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
			{
				local helmet = [
					"helmets/oriental/wrapped_southern_helmet",
					"helmets/oriental/nomad_reinforced_helmet"
				];
				this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
			}

			if (this.m.IsMiniboss)
			{
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernMeleeWeapons[this.Math.rand(0, this.Const.Items.NamedSouthernMeleeWeapons.len() - 1)]));
					if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
					{
						local shields = [
							"shields/oriental/metal_round_shield"
						];
						this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
					}
				}
				else if (r == 2)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					local weapons = [
						"weapons/shamshir",
						"weapons/oriental/heavy_southern_mace",
						"weapons/fighting_spear"
					];
					this.m.Items.equip(this.new("scripts/items/" + this.Const.Items.NamedSouthernShields[this.Math.rand(0, this.Const.Items.NamedSouthernShields.len() - 1)]));
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
				}
				else if (r == 3)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
					local armor = [
						"armor/named/blue_studded_mail_armor",
						"armor/named/black_leather_armor",
						"armor/named/black_and_gold_armor"
					];
					this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
				}
				else
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
					local helmets = [
						"helmets/named/named_steppe_helmet_with_mail"
					];
					this.m.Items.equip(this.new("scripts/items/" + helmets[this.Math.rand(0, helmets.len() - 1)]));
				}
			}
		}			
	};
});
::mods_hookExactClass("entity/tactical/humans/nomad_leader", function ( a )
{
    a.onOtherActorDeath <- function ( _killer, _victim, _skill )
	{
		if (!this.m.IsAlive || this.m.IsDying)
		{
			return;
		}

		if (_victim.getType() == this.Const.EntityType.Slave && _victim.isAlliedWith(this))
		{
			return;
		}

		if (_victim.getXPValue() <= 1)
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

		if (this.ClassName == "nomad_leader")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/effects/backstabber_effect"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_blend_in"));
			}
		}
	};
});
})
