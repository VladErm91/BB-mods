::mods_registerMod("mod_nomad_outlaw", 1.8, "True Balance Mod Nomad Outlaw");
::mods_queue("mod_nomad_outlaw", "mod_true_balance", function() {
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

		if (this.ClassName == "nomad_outlaw")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local weapons;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 20)
			{
				weapons = [
					"weapons/oriental/saif",
					"weapons/oriental/saif",
					"weapons/oriental/nomad_mace",
					"weapons/boar_spear",
					"weapons/reinforced_wooden_flail",
					"weapons/oriental/light_southern_mace",
					"weapons/two_handed_wooden_hammer",
					"weapons/woodcutters_axe"
				];
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
			{
				weapons = [
				    "weapons/oriental/saif",
					"weapons/scimitar",
					"weapons/oriental/nomad_mace",
					"weapons/reinforced_wooden_flail",
					"weapons/boar_spear",
			        "weapons/oriental/polemace",
				    "weapons/oriental/two_handed_saif",
					"weapons/oriental/light_southern_mace",
					"weapons/two_handed_wooden_hammer",
					"weapons/woodcutters_axe",
					"weapons/battle_whip"
				];
			}

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				weapons = [
					"weapons/scimitar",
					"weapons/scimitar",
					"weapons/boar_spear",
					"weapons/boar_spear",
					"weapons/three_headed_flail",
			        "weapons/oriental/polemace",
				    "weapons/oriental/two_handed_saif",
				    "weapons/oriental/two_handed_saif",
					"weapons/oriental/light_southern_mace",
					"weapons/oriental/light_southern_mace",
					"weapons/two_handed_wooden_hammer",
					"weapons/woodcutters_axe",
					"weapons/battle_whip"
				];
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 66)
			{
				local shields;

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 20)
				{
					shields = [
						"shields/oriental/southern_light_shield"
					];
				}

				if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
				{
					shields = [
						"shields/oriental/southern_light_shield",
						"shields/oriental/metal_round_shield"
					];
				}

				this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
			}
	
			local armor = [
				"armor/oriental/stitched_nomad_armor",
				"armor/oriental/plated_nomad_mail",
				"armor/oriental/leather_nomad_robe"
			];
			this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
			local helmet = [
				"helmets/oriental/nomad_leather_cap",
				"helmets/oriental/nomad_light_helmet",
				"helmets/oriental/nomad_reinforced_helmet",
				"helmets/oriental/leather_head_wrap"
			];
			this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
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

		if (this.ClassName == "nomad_outlaw")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 120)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
			}
		}
	};
});
::mods_hookExactClass("entity/tactical/humans/nomad_outlaw", function ( a )
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
})