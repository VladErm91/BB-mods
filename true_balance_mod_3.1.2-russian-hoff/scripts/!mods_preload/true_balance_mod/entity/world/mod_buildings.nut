::mods_registerMod("mod_buildings", 1.8, "True Balance Mod Buildings");
::mods_queue("mod_buildings", "mod_true_balance", function() {
::mods_hookBaseClass("entity/world/settlements/buildings/building", function(o) 
{
	o.fillStash <- function( _list, _stash, _priceMult, _allowDamagedEquipment = false )
	{
		_stash.clear();
		local rarityMult = this.getSettlement().getModifiers().RarityMult;
		local foodRarityMult = this.getSettlement().getModifiers().FoodRarityMult;
		local medicineRarityMult = this.getSettlement().getModifiers().MedicalPriceMult;
		local mineralRarityMult = this.getSettlement().getModifiers().MineralRarityMult;
		local buildingRarityMult = this.getSettlement().getModifiers().BuildingRarityMult;
		local isTrader = this.World.Retinue.hasFollower("follower.trader");

		foreach( i in _list )
		{
			local r = i.R;

			for( local num = 0; true;  )
			{
				local p = this.Math.rand(0, 100) * rarityMult;
				local item;

				if (p >= r)
				{
					item = this.new("scripts/items/" + i.S);
					local isFood = item.isItemType(this.Const.Items.ItemType.Food);
					local isMedicine = item.getID() == "supplies.medicine";
					local isMineral = item.getID() == "misc.uncut_gems" || item.getID() == "misc.copper_ingots";
					local isBuilding = item.getID() == "misc.quality_wood" || item.getID() == "misc.copper_ingots";

					if (!isFood || p * foodRarityMult >= r)
					{
						if (!isMedicine || p * medicineRarityMult >= r)
						{
							if (!isMineral || p * mineralRarityMult >= r)
							{
								if (!isBuilding || p * buildingRarityMult >= r)
								{
									_stash.add(item);
								}
							}
						}
					}

					if (r != 0 || rarityMult < 1.0 || isFood && foodRarityMult < 1.0 || isMedicine && medicineRarityMult < 1.0 || isMineral && mineralRarityMult < 1.0 || isBuilding && buildingRarityMult < 1.0)
					{
						r = r + p;
					}

					if (_allowDamagedEquipment && item.getConditionMax() > 1)
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							item.setCondition(this.Math.rand(item.getConditionMax() * 0.5, item.getConditionMax()) * 1.0);
						}
					}

					item.setPriceMult(i.P * _priceMult);
				}
				else
				{
					break;
				}

				num = ++num;

				if (num >= 3 || !isTrader && num >= 2 && item.isItemType(this.Const.Items.ItemType.TradeGood))
				{
					break;
				}
			}
		}

		_stash.sort();
	}
});
::mods_hookNewObject("entity/world/settlements/buildings/alchemist_building", function(o) 
{
	o.onUpdateShopList = function()
	{
		local list = [
			{
				R = 10,
				P = 1.0,
				S = "tools/daze_bomb_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "tools/daze_bomb_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "tools/fire_bomb_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "tools/fire_bomb_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "tools/smoke_bomb_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "tools/smoke_bomb_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "tools/acid_flask_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "misc/happy_powder_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "misc/happy_powder_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "accessory/antidote_item"
			},
			{
				R = 30,
				P = 1.0,
				S = "accessory/antidote_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/oriental/firelance"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/oriental/firelance"
			},
			{
				R = 30,
				P = 1.0,
				S = "ammo/balls"
			},
			{
				R = 35,
				P = 1.0,
				S = "weapons/oriental/handgonne"
			},
			{
				R = 0,
				P = 1.0,
				S = "ammo/powder_bag"
			},
			{
				R = 99,
				P = 2.0,
				S = "weapons/named/named_handgonne"
			}
		];

		if (this.Const.DLC.Unhold)
		{
			list.extend([
				{
					R = 40,
					P = 1.0,
					S = "accessory/cat_potion_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "accessory/iron_will_potion_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "accessory/lionheart_potion_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "accessory/night_vision_elixir_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "accessory/recovery_potion_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "accessory/spider_poison_item"
				},
				{
					R = 40,
					P = 1.0,
					S = "misc/potion_of_knowledge_item"
				}
			]);
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, false);
	}
});
::mods_hookNewObject("entity/world/settlements/buildings/armorsmith_building", function(o) 
{
	o.onUpdateShopList = function()
	{
		local list = [
			{
				R = 20,
				P = 1.0,
				S = "armor/padded_leather"
			},
			{
				R = 20,
				P = 1.0,
				S = "armor/basic_mail_shirt"
			},
			{
				R = 30,
				P = 1.0,
				S = "armor/mail_shirt"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/mail_coif"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/closed_mail_coif"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet"
			},
			{
				R = 65,
				P = 1.0,
				S = "helmets/kettle_hat"
			},
			{
				R = 15,
				P = 1.0,
				S = "shields/buckler_shield"
			},
			{
				R = 10,
				P = 1.0,
				S = "shields/greenskins/goblin_light_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 50,
				P = 1.0,
				S = "shields/heater_shield"
			},
			{
				R = 45,
				P = 1.0,
				S = "shields/kite_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "armor/leather_lamellar"
			},
			{
				R = 40,
				P = 1.0,
				S = "armor/mail_hauberk"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/reinforced_mail_hauberk"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/lamellar_harness"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			},
			{
				R = 55,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/leather_lamellar"
			},
			{
				R = 40,
				P = 1.0,
				S = "armor/mail_hauberk"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/reinforced_mail_hauberk"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/lamellar_harness"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			},
			{
				R = 55,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/greatsword_faction_helm"
			},
			{
				R = 70,
				P = 1.0,
				S = "armor/scale_armor"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/heavy_lamellar_armor"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet_with_mail"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/bascinet_with_mail"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/kettle_hat_with_mail"
			},
			{
				R = 75,
				P = 1.0,
				S = "helmets/kettle_hat_with_closed_mail"
			},
			{
				R = 75,
				P = 1.0,
				S = "helmets/nasal_helmet_with_closed_mail"
			},
			{
				R = 45,
				P = 1.0,
				S = "helmets/reinforced_mail_coif"
			}
		];

		foreach( i in this.Const.Items.NamedArmors )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		foreach( i in this.Const.Items.NamedHelmets )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		if (this.Const.DLC.Unhold)
		{
			list.push({
				R = 45,
				P = 1.0,
				S = "armor/leather_scale_armor"
			});
			list.push({
				R = 55,
				P = 1.0,
				S = "armor/light_scale_armor"
			});
			list.push({
				R = 90,
				P = 1.0,
				S = "armor/noble_mail_armor"
			});
			list.push({
				R = 60,
				P = 1.0,
				S = "armor/sellsword_armor"
			});
			list.push({
				R = 50,
				P = 1.0,
				S = "armor/footman_armor"
			});
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/sallet_helmet"
			});
			list.push({
				R = 80,
				P = 1.0,
				S = "helmets/barbute_helmet"
			});
			list.push({
				R = 60,
				P = 1.0,
				S = "misc/paint_set_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_remover_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_black_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_orange_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_blue_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_green_yellow_item"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/metal_plating_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/metal_pauldrons_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/mail_patch_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/leather_shoulderguards_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/leather_neckguard_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/joint_cover_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/heraldic_plates_upgrade"
			});
			list.push({
				R = 85,
				P = 1.25,
				S = "armor_upgrades/double_mail_upgrade"
			});
		}

		if (this.Const.DLC.Wildmen && this.m.Settlement.getTile().SquareCoords.Y > this.World.getMapSize().Y * 0.7)
		{
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/nordic_helmet"
			});
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/steppe_helmet_with_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/conic_helmet_with_closed_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/nordic_helmet_with_closed_mail"
			});
			list.push({
				R = 80,
				P = 1.0,
				S = "helmets/conic_helmet_with_faceguard"
			});
		}
		else
		{
			list.push({
				R = 70,
				P = 1.0,
				S = "helmets/flat_top_helmet"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/flat_top_with_mail"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "helmets/flat_top_with_closed_mail"
			});
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.25, false);
	}
});
::mods_hookNewObject("entity/world/settlements/buildings/marketplace_building", function(o) 
{
	o.onUpdateShopList = function()
	{
		local list = [
			{
				R = 10,
				P = 1.0,
				S = "weapons/bludgeon"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/militia_spear"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/pitchfork"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/knife"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/hatchet"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/short_bow"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/javelin"
			},
			{
				R = 30,
				P = 1.0,
				S = "ammo/quiver_of_arrows"
			},
			{
				R = 10,
				P = 1.0,
				S = "armor/sackcloth"
			},
			{
				R = 20,
				P = 1.0,
				S = "armor/linen_tunic"
			},
			{
				R = 25,
				P = 1.0,
				S = "armor/thick_tunic"
			},
			{
				R = 10,
				P = 1.0,
				S = "helmets/straw_hat"
			},
			{
				R = 20,
				P = 1.0,
				S = "helmets/hood"
			},
			{
				R = 15,
				P = 1.0,
				S = "shields/buckler_shield"
			},
			{
				R = 10,
				P = 1.0,
				S = "shields/greenskins/goblin_light_shield"
			},
			{
				R = 20,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/ground_grains_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/medicine_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "accessory/bandage_item"
			}
		];

		local isQuartermaster = this.World.Retinue.hasFollower("follower.quartermaster");

		if (isQuartermaster)
		{
			list.push({
				R = 0,
				P = 1.0,
				S = "supplies/medicine_item"
			});
			list.push({
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
			list.push({
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3)
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/medicine_item"
			});
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
		}

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.fishing_huts"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dried_fish_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.beekeeper"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/mead_item"
			});
		}

		if (this.m.Settlement.getSize() >= 1 && !this.m.Settlement.hasAttachedLocation("attached_location.pig_farm"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/smoked_ham_item"
			});
		}

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.hunters_cabin"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/cured_venison_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.goat_herd"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/goat_cheese_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.orchard"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dried_fruits_item"
			});
		}

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.mushroom_grove"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/pickled_mushrooms_item"
			});
		}

		if (!this.m.Settlement.hasAttachedLocation("attached_location.wheat_farm"))
		{
			list.push({
				R = 30,
				P = 1.0,
				S = "supplies/bread_item"
			});
		}

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.gatherers_hut"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/roots_and_berries_item"
			});
		}

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.brewery"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/beer_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.winery"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/wine_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3)
		{
			list.push({
				R = 60,
				P = 1.0,
				S = "supplies/cured_rations_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 || this.m.Settlement.isMilitary())
		{
			list.push({
				R = 90,
				P = 1.0,
				S = "accessory/falcon_item"
			});
		}

		if (this.Const.DLC.Unhold && (this.m.Settlement.isMilitary() && this.m.Settlement.getSize() >= 3 || this.m.Settlement.getSize() >= 2))
		{
			list.push({
				R = 65,
				P = 1.0,
				S = "misc/paint_set_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_remover_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_black_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_orange_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_blue_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_green_yellow_item"
			});
		}

		if (this.Const.DLC.Unhold)
		{
			list.extend([
				{
					R = 90,
					P = 1.0,
					S = "weapons/two_handed_wooden_hammer"
				}
			]);

			if (this.m.Settlement.isMilitary())
			{
				list.extend([
					{
						R = 80,
						P = 1.0,
						S = "weapons/throwing_spear"
					}
				]);
			}
		}

		if (this.Const.DLC.Wildmen)
		{
			list.extend([
				{
					R = 50,
					P = 1.0,
					S = "weapons/warfork"
				},
				{
					R = 30,
					P = 1.0,
					S = "weapons/staff_sling"
				}
			]);
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, true);
	}
});
::mods_hookNewObject("entity/world/settlements/buildings/marketplace_oriental_building", function(o) 
{
	o.onUpdateShopList = function()
	{
		local list = [
			{
				R = 30,
				P = 1.0,
				S = "weapons/oriental/nomad_sling"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/militia_spear"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/pitchfork"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/knife"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/short_bow"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/oriental/composite_bow"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/javelin"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/oriental/saif"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/scimitar"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/oriental/light_southern_mace"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/oriental/firelance"
			},
			{
				R = 30,
				P = 1.0,
				S = "ammo/quiver_of_arrows"
			},
			{
				R = 10,
				P = 1.0,
				S = "armor/oriental/cloth_sash"
			},
			{
				R = 40,
				P = 1.0,
				S = "armor/oriental/nomad_robe"
			},
			{
				R = 20,
				P = 1.0,
				S = "armor/oriental/padded_vest"
			},
			{
				R = 30,
				P = 1.0,
				S = "armor/oriental/linothorax"
			},
			{
				R = 0,
				P = 1.0,
				S = "helmets/oriental/southern_head_wrap"
			},
			{
				R = 10,
				P = 1.0,
				S = "helmets/oriental/southern_head_wrap"
			},
			{
				R = 30,
				P = 1.0,
				S = "helmets/oriental/wrapped_southern_helmet"
			},
			{
				R = 40,
				P = 1.0,
				S = "helmets/oriental/spiked_skull_cap_with_mail"
			},
			{
				R = 15,
				P = 1.0,
				S = "shields/oriental/southern_light_shield"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/rice_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/rice_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/medicine_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/medicine_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/medicine_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/ammo_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "accessory/bandage_item"
			},
			{
				R = 20,
				P = 1.0,
				S = "tools/throwing_net"
			}
		];

		local isQuartermaster = this.World.Retinue.hasFollower("follower.quartermaster");

		if (isQuartermaster)
		{
			list.push({
				R = 0,
				P = 1.0,
				S = "supplies/medicine_item"
			});
			list.push({
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
			list.push({
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			});
		}

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.fishing_huts"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dried_fish_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.goat_herd"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/goat_cheese_item"
			});
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dried_lamb_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.plantation"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dates_item"
			});
		}

		if (!this.m.Settlement.hasAttachedLocation("attached_location.wheat_farm"))
		{
			list.push({
				R = 30,
				P = 1.0,
				S = "supplies/bread_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3)
		{
			list.push({
				R = 60,
				P = 1.0,
				S = "supplies/cured_rations_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 || this.m.Settlement.isMilitary())
		{
			list.push({
				R = 90,
				P = 1.0,
				S = "accessory/falcon_item"
			});
		}

		if (this.Const.DLC.Unhold && (this.m.Settlement.isMilitary() && this.m.Settlement.getSize() >= 3 || this.m.Settlement.getSize() >= 2))
		{
			list.push({
				R = 65,
				P = 1.0,
				S = "misc/paint_set_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_remover_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_black_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_orange_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_blue_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_green_yellow_item"
			});
		}

		if (this.Const.DLC.Unhold)
		{
			list.extend([
				{
					R = 90,
					P = 1.0,
					S = "weapons/two_handed_wooden_hammer"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/throwing_spear"
				}
			]);
		}

		if (this.Const.DLC.Wildmen)
		{
			list.extend([
				{
					R = 50,
					P = 1.0,
					S = "weapons/warfork"
				}
			]);
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, true);
	}
});
::mods_hookNewObject("entity/world/settlements/buildings/tavern_building", function(o) 
{
	o.getRumorPrice = function()
	{
		return this.Math.round(20 * this.m.Settlement.getBuyPriceMult());
	}

	o.getRumor = function( _isPaidFor = false )
	{
		if (_isPaidFor)
		{
			if (this.World.Assets.getMoney() < this.Math.round(20 * this.m.Settlement.getBuyPriceMult()))
			{
				return null;
			}

			this.World.Assets.addMoney(this.Math.round(-15 * this.m.Settlement.getBuyPriceMult()));
			++this.m.RumorsGiven;
			this.Sound.play(this.Const.Sound.TavernRumor[this.Math.rand(0, this.Const.Sound.TavernRumor.len() - 1)]);
		}

		if (this.m.RumorsGiven > 3)
		{
			if (_isPaidFor)
			{
				return "Завсегдатаи поднимают тост за вас, но сегодня вам у них уже нечего узнать.";
			}
			else
			{
				return "Завсегдатаи беседуют о том, о сём.";
			}
		}
		else
		{
			this.m.LastRumorTime = this.Time.getVirtualTimeF();
			local rumor = "";

			if (_isPaidFor)
			{
				if (!this.m.Settlement.isMilitary())
				{
					this.World.FactionManager.getFaction(this.m.Settlement.getFactions()[0]).addPlayerRelation(0.1);
				}

				rumor = rumor + this.Const.Strings.PayTavernRumorsIntro[this.Math.rand(0, this.Const.Strings.PayTavernRumorsIntro.len() - 1)];
			}
			else if (this.m.LastRumor != "")
			{
				return this.m.LastRumor;
			}
			else
			{
				rumor = rumor + "Завсегдатаи беседуют о том, о сём.";
			}

			local candidates = [];
			local r = this.World.Assets.m.IsNonFlavorRumorsOnly ? this.Math.rand(4, 6) : this.Math.rand(1, 6);

			if (r <= 2)
			{
				if (this.World.FactionManager.isGreaterEvil())
				{
					candidates.extend(this.Const.Strings.RumorsGreaterEvil[this.World.FactionManager.getGreaterEvilType()]);
					candidates.extend(this.Const.Strings.RumorsGreaterEvil[this.World.FactionManager.getGreaterEvilType()]);
				}
				else
				{
					candidates.extend(this.Const.Strings.RumorsGeneral);
				}

				if (this.m.Settlement.isMilitary())
				{
					candidates.extend(this.Const.Strings.RumorsMilitary);
				}
				else
				{
					candidates.extend(this.Const.Strings.RumorsCivilian);
				}

				candidates.extend(this.m.Settlement.getRumors());
			}
			else if (r == 3)
			{
				local best;
				local bestDist = 9000;

				foreach( s in this.World.EntityManager.getSettlements() )
				{
					if (s.isMilitary() || s.getID() == this.m.Settlement.getID())
					{
						continue;
					}

					if (this.World.FactionManager.getFaction(s.getFactions()[0]).getContracts().len() != 0)
					{
						local d = s.getTile().getDistanceTo(this.m.Settlement.getTile());

						if (d < bestDist)
						{
							bestDist = d;
							best = s;
						}
					}

					if (best != null)
					{
						candidates.extend(this.Const.Strings.RumorsContract);
						this.m.ContractSettlement = this.WeakTableRef(best);
					}
					else
					{
						candidates.extend(this.Const.Strings.RumorsGeneral);

						if (this.m.Settlement.isMilitary())
						{
							candidates.extend(this.Const.Strings.RumorsMilitary);
						}
						else
						{
							candidates.extend(this.Const.Strings.RumorsCivilian);
						}

						candidates.extend(this.m.Settlement.getRumors());
					}
				}
			}
			else if (r == 4)
			{
				local best;
				local bestDist = 9000;

				foreach( s in this.World.EntityManager.getLocations() )
				{
					if (s.isLocationType(this.Const.World.LocationType.AttachedLocation) || s.isLocationType(this.Const.World.LocationType.Unique) || s.isAlliedWithPlayer())
					{
						continue;
					}

					local d = s.getTile().getDistanceTo(this.m.Settlement.getTile()) - this.Math.rand(1, 10);

					if (d < bestDist)
					{
						bestDist = d;
						best = s;
					}
				}

				if (best != null)
				{
					candidates.extend(this.Const.Strings.RumorsLocation);
					this.m.Location = this.WeakTableRef(best);
				}
				else
				{
					candidates.extend(this.Const.Strings.RumorsGeneral);

					if (this.m.Settlement.isMilitary())
					{
						candidates.extend(this.Const.Strings.RumorsMilitary);
					}
					else
					{
						candidates.extend(this.Const.Strings.RumorsCivilian);
					}

					candidates.extend(this.m.Settlement.getRumors());
				}
			}
			else if (r == 5)
			{
				local best;
				local bestDist = 9000;

				foreach( s in this.World.EntityManager.getLocations() )
				{
					if (s.isAlliedWithPlayer())
					{
						continue;
					}

					if (s.getLoot().isEmpty())
					{
						continue;
					}

					local d = s.getTile().getDistanceTo(this.m.Settlement.getTile()) - this.Math.rand(1, 10);

					if (d > 20)
					{
						continue;
					}

					if (d < bestDist)
					{
						bestDist = d;
						best = s;
					}
				}

				if (best != null)
				{
					local f = this.World.FactionManager.getFaction(best.getFaction());
					local category = 0;

					if (best.getLoot().getItems()[0].isItemType(this.Const.Items.ItemType.Shield))
					{
						category = 1;
					}
					else if (best.getLoot().getItems()[0].isItemType(this.Const.Items.ItemType.Armor) || best.getLoot().getItems()[0].isItemType(this.Const.Items.ItemType.Helmet))
					{
						category = 2;
					}

					if (::TrueBalance.Mod.ModSettings.getSetting("Champions").getValue())
					{
						if (f.getType() == this.Const.FactionType.Orcs)
						{
							candidates.extend(this.Const.Strings.RumorsTreasureOrcs[category]);
						}
						else if (f.getType() == this.Const.FactionType.Goblins)
						{
							candidates.extend(this.Const.Strings.RumorsTreasureGoblins[category]);
						}
						else if (f.getType() == this.Const.FactionType.Undead || f.getType() == this.Const.FactionType.Zombies)
						{
							candidates.extend(this.Const.Strings.RumorsTreasureUndead[category]);
						}
						else if (f.getType() == this.Const.FactionType.Barbarians)
						{
							candidates.extend(this.Const.Strings.RumorsTreasureBarbarians[category]);
						}
						else if (f.getType() == this.Const.FactionType.OrientalBandits)
						{
							candidates.extend(this.Const.Strings.RumorsTreasureNomads[category]);
						}
						else
						{
							candidates.extend(this.Const.Strings.RumorsTreasureBandits[category]);
						}
					}
					else
					{
						if (f.getType() == this.Const.FactionType.Orcs)
						{
							candidates.extend(this.Const.Strings.RumorsItemsOrcs[category]);
						}
						else if (f.getType() == this.Const.FactionType.Goblins)
						{
							candidates.extend(this.Const.Strings.RumorsItemsGoblins[category]);
						}
						else if (f.getType() == this.Const.FactionType.Undead || f.getType() == this.Const.FactionType.Zombies)
						{
							candidates.extend(this.Const.Strings.RumorsItemsUndead[category]);
						}
						else if (f.getType() == this.Const.FactionType.Barbarians)
						{
							candidates.extend(this.Const.Strings.RumorsItemsBarbarians[category]);
						}
						else if (f.getType() == this.Const.FactionType.OrientalBandits)
						{
							candidates.extend(this.Const.Strings.RumorsItemsNomads[category]);
						}
						else
						{
							candidates.extend(this.Const.Strings.RumorsItemsBandits[category]);
						}
					}

					this.m.Location = this.WeakTableRef(best);
				}
				else
				{
					candidates.extend(this.Const.Strings.RumorsGeneral);

					if (this.m.Settlement.isMilitary())
					{
						candidates.extend(this.Const.Strings.RumorsMilitary);
					}
					else
					{
						candidates.extend(this.Const.Strings.RumorsCivilian);
					}

					candidates.extend(this.m.Settlement.getRumors());
				}
			}
			else if (r == 6)
			{
				local best;
				local bestDist = 9000;

				foreach( s in this.World.EntityManager.getSettlements() )
				{
					if (s.getID() == this.m.Settlement.getID())
					{
						continue;
					}

					s.updateSituations();

					if (s.getSituations().len() > 0)
					{
						local d = s.getTile().getDistanceTo(this.m.Settlement.getTile());

						if (d < bestDist)
						{
							bestDist = d;
							best = s;
						}
					}
				}

				if (best != null)
				{
					local situation = best.getSituations()[this.Math.rand(0, best.getSituations().len() - 1)];
					candidates.extend(situation.getRumors());
					this.m.ContractSettlement = this.WeakTableRef(best);
				}
				else
				{
					candidates.extend(this.Const.Strings.RumorsGeneral);

					if (this.m.Settlement.isMilitary())
					{
						candidates.extend(this.Const.Strings.RumorsMilitary);
					}
					else
					{
						candidates.extend(this.Const.Strings.RumorsCivilian);
					}

					candidates.extend(this.m.Settlement.getRumors());
				}
			}

			rumor = rumor + "\n\n[color=#bcad8c]\"";
			rumor = rumor + candidates[this.Math.rand(0, candidates.len() - 1)];
			rumor = rumor + "\"[/color]\n\n";
			rumor = this.buildText(rumor);
			this.m.LastRumor = rumor;
			return rumor;
		}
	}
});
::mods_hookNewObject("entity/world/settlements/buildings/weaponsmith_oriental_building", function(o) 
{
	o.onUpdateShopList = function()
	{
		local list = [
			{
				R = 40,
				P = 1.0,
				S = "weapons/oriental/qatal_dagger"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/oriental/composite_bow"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/oriental/nomad_sling"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/oriental/nomad_sling"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/oriental/light_southern_mace"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/oriental/heavy_southern_mace"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/oriental/polemace"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/oriental/swordlance"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/oriental/two_handed_saif"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/oriental/two_handed_scimitar"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/falchion"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/oriental/saif"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/oriental/saif"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/scimitar"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/scimitar"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/shamshir"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/militia_spear"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/boar_spear"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/fighting_spear"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/javelin"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/javelin"
			},
			{
				R = 45,
				P = 1.0,
				S = "weapons/pike"
			},
			{
				R = 75,
				P = 1.0,
				S = "weapons/military_pick"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/warhammer"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/flail"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/greatsword"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/warbrand"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/greataxe"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/two_handed_hammer"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/battle_whip"
			}
		];

		if (this.Const.DLC.Unhold)
		{
			list.extend([
				{
					R = 60,
					P = 1.0,
					S = "weapons/two_handed_wooden_hammer"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/longsword"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/three_headed_flail"
				},
				{
					R = 95,
					P = 1.0,
					S = "weapons/two_handed_flail"
				},
				{
					R = 90,
					P = 1.0,
					S = "weapons/two_handed_wooden_flail"
				},
				{
					R = 30,
					P = 1.0,
					S = "weapons/spetum"
				},
				{
					R = 60,
					P = 1.0,
					S = "weapons/polehammer"
				},
				{
					R = 70,
					P = 1.0,
					S = "weapons/two_handed_mace"
				},
				{
					R = 70,
					P = 1.0,
					S = "weapons/two_handed_flanged_mace"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/fencing_sword"
				},
				{
					R = 10,
					P = 1.0,
					S = "weapons/throwing_spear"
				}
			]);
		}

		if (this.Math.rand(1, 100) <= 30)
		{
			list.push({
				R = 99,
				P = 2.0,
				S = "weapons/named/named_sling"
			});
		}

		if (this.Const.DLC.Wildmen)
		{
			list.extend([
				{
					R = 20,
					P = 1.0,
					S = "weapons/warfork"
				}
			]);
		}

		foreach( i in this.Const.Items.NamedMeleeWeapons )
		{
			if (this.Math.rand(1, 100) <= 30)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.25, false);
	}
});
::mods_hookNewObject("entity/world/settlements/buildings/weaponsmith_building", function(o) 
{
	o.onUpdateShopList = function()
	{
		local list = [
			{
				R = 20,
				P = 1.0,
				S = "weapons/dagger"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/dagger"
			},
			{
				R = 55,
				P = 1.0,
				S = "weapons/rondel_dagger"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/boar_spear"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/boar_spear"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/fighting_spear"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/hand_axe"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/shortsword"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/shortsword"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/javelin"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/javelin"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/throwing_axe"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/throwing_axe"
			},
			{
				R = 45,
				P = 1.0,
				S = "weapons/pike"
			},
			{
				R = 45,
				P = 1.0,
				S = "weapons/pike"
			},
			{
				R = 45,
				P = 1.0,
				S = "weapons/billhook"
			},
			{
				R = 45,
				P = 1.0,
				S = "weapons/longaxe"
			},
			{
				R = 35,
				P = 1.0,
				S = "weapons/falchion"
			},
			{
				R = 35,
				P = 1.0,
				S = "weapons/falchion"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/morning_star"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/morning_star"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/arming_sword"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/arming_sword"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/military_cleaver"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/winged_mace"
			},
			{
				R = 55,
				P = 1.0,
				S = "weapons/fighting_axe"
			},
			{
				R = 65,
				P = 1.0,
				S = "weapons/noble_sword"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/military_pick"
			},
			{
				R = 65,
				P = 1.0,
				S = "weapons/warhammer"
			},
			{
				R = 55,
				P = 1.0,
				S = "weapons/flail"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/greatsword"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/estoc"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/warbrand"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/greataxe"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/two_handed_hammer"
			}
		];

		if (this.Const.DLC.Unhold)
		{
			list.extend([
				{
					R = 60,
					P = 1.0,
					S = "weapons/two_handed_wooden_hammer"
				},
				{
					R = 50,
					P = 1.0,
					S = "weapons/longsword"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/three_headed_flail"
				},
				{
					R = 65,
					P = 1.0,
					S = "weapons/two_handed_flail"
				},
				{
					R = 60,
					P = 1.0,
					S = "weapons/two_handed_wooden_flail"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/spetum"
				},
				{
					R = 60,
					P = 1.0,
					S = "weapons/polehammer"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/goedendag"
				},
				{
					R = 55,
					P = 1.0,
					S = "weapons/two_handed_mace"
				},
				{
					R = 65,
					P = 1.0,
					S = "weapons/two_handed_flanged_mace"
				},
				{
					R = 80,
					P = 1.0,
					S = "weapons/fencing_sword"
				},
				{
					R = 10,
					P = 1.0,
					S = "weapons/throwing_spear"
				}
			]);
		}

		if (this.Const.DLC.Wildmen)
		{
			if (this.m.Settlement.getTile().SquareCoords.Y > this.World.getMapSize().Y * 0.7)
			{
				list.push({
					R = 70,
					P = 1.0,
					S = "weapons/bardiche"
				});
			}
			else if (this.m.Settlement.getTile().SquareCoords.Y < this.World.getMapSize().Y * 0.4)
			{
				list.push({
					R = 75,
					P = 1.0,
					S = "weapons/scimitar"
				});
				list.push({
					R = 85,
					P = 1.0,
					S = "weapons/shamshir"
				});
			}

			list.push({
				R = 80,
				P = 1.0,
				S = "weapons/battle_whip"
			});
		}

		foreach( i in this.Const.Items.NamedModMeleeWeapons )
		{
			if (this.Math.rand(1, 100) <= 30)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.25, false);
	}
});
})
