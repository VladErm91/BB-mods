::mods_registerMod("mod_locations", 1.8, "True Balance Mod Locations");
::mods_queue("mod_locations", "mod_true_balance", function() {
	::mods_hookBaseClass("entity/world/location", function(o) 
	{
		::mods_override (o[o.SuperName], "createDefenders", function()
		{
			local resources = this.m.Resources;

			if (this.m.IsScalingDefenders)
			{
				resources = resources * this.Math.minf(3.0, 1.0 + this.World.getTime().Days * 0.0075);
			}

			if (!this.isAlliedWithPlayer())
			{
				resources = resources * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
			}

			if (this.Time.getVirtualTimeF() - this.m.LastSpawnTime <= 60.0)
			{
				resources = resources * 1.0;
			}

			local best;
			local bestCost = -9000;

			foreach( party in this.m.DefenderSpawnList )
			{
				if (party.Cost > resources)
				{
					continue;
				}

				if (best == null || party.Cost > bestCost)
				{
					best = party;
					bestCost = party.Cost;
				}
			}

			local potential = [];

			foreach( party in this.m.DefenderSpawnList )
			{
				if (party.Cost > resources || party.Cost < bestCost * 0.75)
				{
					continue;
				}

				potential.push(party);
			}

			if (potential.len() != 0)
			{
				best = potential[this.Math.rand(0, potential.len() - 1)];
			}

			if (best == null)
			{
				bestCost = 9000;

				foreach( party in this.m.DefenderSpawnList )
				{
					if (this.Math.abs(party.Cost - resources) < bestCost)
					{
						best = party;
						bestCost = this.Math.abs(party.Cost - resources);
					}
				}
			}

			if (best != null)
			{
				this.m.Troops = [];

				if (this.Time.getVirtualTimeF() - this.m.LastSpawnTime <= 60.0)
				{
					this.m.DefenderSpawnDay = this.World.getTime().Days;
				}
				else
				{
					this.m.DefenderSpawnDay = this.World.getTime().Days;
				}

				foreach( t in best.Troops )
				{
					for( local i = 0; i != t.Num; i = ++i )
					{
						this.Const.World.Common.addTroop(this, t, false);
					}
				}

				this.updateStrength();
			}
		})

		::mods_override (o[o.SuperName], "onSpawned", function()
		{
			if (::TrueBalance.Mod.ModSettings.getSetting("Champions").getValue())
			{
				if(this.isLocationType(this.Const.World.LocationType.Unique)) return;
				local nearestSettlement = 9000;
				local myTile = this.getTile();
	
				foreach( s in this.World.EntityManager.getSettlements() )
				{
					local d = myTile.getDistanceTo(s.getTile());
	
					if (d < nearestSettlement)
					{
						nearestSettlement = d;
					}
				}
	
				local num = 0;
	
				for( local chance = (this.m.Resources + nearestSettlement * 4) / 5.0 - 37.0; num < 2;  )
				{
					local r = this.Math.rand(1, 100);
	
					if (r <= chance)
					{
						chance = chance - r;
						num = ++num;
						this.m.Loot.add(this.new("scripts/items/loot/jeweled_crown_item"));
						this.m.Loot.add(this.new("scripts/items/loot/gemstones_item"));
						this.m.Loot.add(this.new("scripts/items/loot/golden_chalice_item"));
						this.m.Loot.add(this.new("scripts/items/loot/ancient_gold_coins_item"));
						this.m.Loot.add(this.new("scripts/items/loot/white_pearls_item"));
					}
					else
					{
						return 
					}
				}
			}
			else
			{
				local nearestSettlement = 9000;
				local myTile = this.getTile();
		
				foreach( s in this.World.EntityManager.getSettlements() )
				{
					local d = myTile.getDistanceTo(s.getTile());
		
					if (d < nearestSettlement)
					{
						nearestSettlement = d;
					}
				}
		
				if (!this.isLocationType(this.Const.World.LocationType.Unique))
				{
					local num = 0;
		
					for( local chance = (this.m.Resources + nearestSettlement * 4) / 5.0 - 37.0; num < 2;  )
					{
						local r = this.Math.rand(1, 100);
		
						if (r <= chance)
						{
							chance = chance - r;
							num = ++num;
							local type = this.Math.rand(20, 100);
		
							if (type <= 40)
							{
								local weapons = clone this.Const.Items.NamedWeapons;
		
								if (this.m.NamedWeaponsList != null && this.m.NamedWeaponsList.len() != 0)
								{
									weapons.extend(this.m.NamedWeaponsList);
									weapons.extend(this.m.NamedWeaponsList);
								}
		
								this.m.Loot.add(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
							}
							else if (type <= 60)
							{
								local shields = clone this.Const.Items.NamedShields;
		
								if (this.m.NamedShieldsList != null && this.m.NamedShieldsList.len() != 0)
								{
									shields.extend(this.m.NamedShieldsList);
									shields.extend(this.m.NamedShieldsList);
								}
		
								this.m.Loot.add(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
							}
							else if (type <= 80)
							{
								local helmets = clone this.Const.Items.NamedHelmets;
		
								if (this.m.NamedHelmetsList != null && this.m.NamedHelmetsList.len() != 0)
								{
									helmets.extend(this.m.NamedHelmetsList);
									helmets.extend(this.m.NamedHelmetsList);
								}
		
								this.m.Loot.add(this.new("scripts/items/" + helmets[this.Math.rand(0, helmets.len() - 1)]));
							}
							else if (type <= 100)
							{
								local armor = clone this.Const.Items.NamedArmors;
		
								if (this.m.NamedArmorsList != null && this.m.NamedArmorsList.len() != 0)
								{
									armor.extend(this.m.NamedArmorsList);
									armor.extend(this.m.NamedArmorsList);
								}
		
								this.m.Loot.add(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
							}
						}
						else
						{
							break;
						}
					}
				}
			}
		})
	});
})
