::mods_registerMod("mod_send_caravan_action", 1.8, "True Balance Mod Send Caravan Action");
::mods_queue("mod_send_caravan_action", "mod_true_balance", function() {	
::mods_hookNewObject("factions/actions/send_caravan_action", function(o) 
{
	o.onExecute = function( _faction )
	{
		local party;

		if (_faction.hasTrait(this.Const.FactionTrait.OrientalCityState))
		{
			party = _faction.spawnEntity(this.m.Start.getTile(), "Торговый караван", false, this.Const.World.Spawn.CaravanSouthern, this.m.Start.getResources() * 0.6);
		}
		else
		{
			party = _faction.spawnEntity(this.m.Start.getTile(), "Торговый караван", false, this.Const.World.Spawn.Caravan, this.m.Start.getResources() * 0.5);
		}

		party.getSprite("banner").Visible = false;
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("Торговый караван из " + this.m.Start.getName() + ", перевозящий различные товары между поселениями.");
		party.setFootprintType(this.Const.World.FootprintsType.Caravan);
		party.getFlags().set("IsCaravan", true);
		party.getFlags().set("IsRandomlySpawned", true);

		if (this.World.Assets.m.IsBrigand && this.m.Start.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 70)
		{
			party.setVisibleInFogOfWar(true);
			party.setImportant(true);
			party.setDiscovered(true);
		}

		if (this.m.Start.getProduce().len() != 0)
		{
			local e = 3;

			for( local j = 0; j != e; j = ++j )
			{
				party.addToInventory(this.m.Start.getProduce()[this.Math.rand(0, this.m.Start.getProduce().len() - 1)]);
			}
		}

		if (this.World.Assets.m.IsBrigand)
		{
			party.getLoot().Money = this.Math.rand(150, 300);
			party.getLoot().ArmorParts = this.Math.rand(0, 10);
			party.getLoot().Medicine = this.Math.rand(0, 10);
			party.getLoot().Ammo = this.Math.rand(0, 25);
		}
		else
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				party.getLoot().ArmorParts = this.Math.rand(0, 10);
			}

			if (this.Math.rand(1, 100) <= 50)
			{
				party.getLoot().Medicine = this.Math.rand(0, 10);
			}

			if (this.Math.rand(1, 100) <= 50)
			{
				party.getLoot().Ammo = this.Math.rand(0, 25);
			}

			party.getLoot().Money = this.Math.rand(0, 100);
		}

		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			party.addToInventory("supplies/bread_item");
		}
		else if (r == 2)
		{
			party.addToInventory("supplies/roots_and_berries_item");
		}
		else if (r == 3)
		{
			party.addToInventory("supplies/dried_fruits_item");
		}
		else if (r == 4)
		{
			party.addToInventory("supplies/ground_grains_item");
		}

		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Dest.getTile());
		move.setRoadsOnly(true);
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(move);
		c.addOrder(despawn);
	}
});
})
