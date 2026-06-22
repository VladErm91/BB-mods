this.graverobbers_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.graverobbers";
		this.m.Name = "Расхитители гробниц";
		this.m.Description = "[p=c][img]gfx/ui/events/event_57.png[/img][/p][p]Долгое время вы выживали, разыскивая артефакты и золото среди могил. Не самая лучшая профессия, но приносит хорошие деньги. Однако, с каждым днем ваш промысел становится всё опаснее.\n\n[color=#bcad8c]Расхитители гробниц:[/color] Начните игру с партией из двух расхитителей гробниц, одного гробокопателя, историка, а также неплохим вооружением и небольшой добычей.\n[color=#bcad8c]Отвратительные:[/color] Большинство людей не хотят иметь с вами дело: начните с отрицательной известностью, набирая её лишь с 66% скоростью. Цены на покупку и продажу хуже на 10%.\n[color=#bcad8c]Торговцы смертью:[/color] Получайте дополнительные сокровища из локаций с нежитью.[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 300104;
		this.m.IsFixedLook = true;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 4; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		local talents;
		bros[0].setStartValuesEx([
			"historian_background"
		]);
		bros[0].m.PerkPoints = 0;
		bros[0].m.LevelUps = 0;
		bros[0].m.Level = 1;
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.RangedSkill] = 2;
		talents[this.Const.Attributes.Bravery] = 3;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.equip(this.new("scripts/items/armor/linen_tunic"));
		items.equip(this.new("scripts/items/helmets/mouth_piece"));
		items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
		bros[0].setPlaceInFormation(3);
		bros[1].setStartValuesEx([
			"gravedigger_background"
		]);
		bros[1].m.PerkPoints = 0;
		bros[1].m.LevelUps = 0;
		bros[1].m.Level = 1;
		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 2;
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Fatigue] = 3;
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.equip(this.new("scripts/items/armor/ancient/ancient_mail"));
		items.equip(this.new("scripts/items/helmets/cultist_hood"));
		items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		items.equip(this.new("scripts/items/shields/ancient/auxiliary_shield"));
		bros[1].setPlaceInFormation(4);
		bros[2].setStartValuesEx([
			"graverobber_background"
		]);
		bros[2].m.PerkPoints = 0;
		bros[2].m.LevelUps = 0;
		bros[2].m.Level = 1;
		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.Bravery] = 1;
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		items.equip(this.new("scripts/items/helmets/ancient/ancient_household_helmet"));
		items.equip(this.new("scripts/items/weapons/ancient/falx"));
		bros[2].setPlaceInFormation(5);
		bros[3].setStartValuesEx([
			"graverobber_background"
		]);
		bros[3].m.PerkPoints = 0;
		bros[3].m.LevelUps = 0;
		bros[3].m.Level = 1;
		bros[3].m.Talents = [];
		local talents = bros[3].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.Initiative] = 1;
		talents[this.Const.Attributes.Fatigue] = 1;
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.equip(this.new("scripts/items/armor/thick_dark_tunic"));
		items.equip(this.new("scripts/items/helmets/ancient/ancient_household_helmet"));
		items.equip(this.new("scripts/items/weapons/ancient/broken_bladed_pike"));
		bros[3].setPlaceInFormation(6);
		this.World.Assets.m.BusinessReputation = -100;
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/strange_meat_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/strange_meat_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/loot/ancient_gold_coins_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/armor_upgrades/protective_runes_upgrade"));
		this.World.Assets.getStash().add(this.new("scripts/items/accessory/lionheart_potion_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money / 2 - 100;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo;
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts;
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 2)
			{
				break;
			}

			i = ++i;
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 8), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 8));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 8), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 8));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 5)
				{
				}
				else if (!tile.HasRoad)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/civilians_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.graverobbers_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.World.Assets.m.BusinessReputationRate = 0.66;
		this.World.Assets.m.BuyPriceMult = 1.1;
		this.World.Assets.m.SellPriceMult = 0.9;
	}

});

