::mods_registerMod("mod_flying_skull", 1.8, "True Balance Mod Flying Skull");
::mods_queue("mod_flying_skull", "mod_true_balance", function() {
::mods_hookExactClass("entity/tactical/enemies/flying_skull", function ( a )
{
	a.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		local myTile = this.getTile();

		if (!this.m.IsExploded)
		{
			this.m.IsExploded = true;
			local effect = {
				Delay = 0,
				Quantity = 80,
				LifeTimeQuantity = 80,
				SpawnRate = 400,
				Brushes = [
					"blood_splatter_bones_01",
					"blood_splatter_bones_03",
					"blood_splatter_bones_04",
					"blood_splatter_bones_05",
					"blood_splatter_bones_06"
				],
				Stages = [
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffffff"),
						ColorMax = this.createColor("ffffffff"),
						ScaleMin = 1.0,
						ScaleMax = 1.5,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 200,
						VelocityMax = 300,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						SpawnOffsetMin = this.createVec(0, 0),
						SpawnOffsetMax = this.createVec(0, 0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.75,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff8f"),
						ColorMax = this.createColor("ffffff8f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 200,
						VelocityMax = 300,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, -100),
						ForceMax = this.createVec(0, -100)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.1,
						ScaleMax = 0.1,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 200,
						VelocityMax = 300,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, -100),
						ForceMax = this.createVec(0, -100)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, myTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 50));

			for( local i = 0; i < 6; i = ++i )
			{
				if (!myTile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = myTile.getNextTile(i);

					if (this.Math.abs(myTile.Level - nextTile.Level) <= 1 && nextTile.IsOccupiedByActor)
					{
						local target = nextTile.getEntity();

						if (!target.isAlive() || target.isDying())
						{
						}
						else
						{
							local f = this.isAlliedWith(target) ? 0.5 : 1.0;
							local hitInfo = clone this.Const.Tactical.HitInfo;
							hitInfo.DamageRegular = this.Math.rand(20, 30) * f;
							hitInfo.DamageArmor = hitInfo.DamageRegular * 0.75;
							hitInfo.DamageDirect = 0.3;
							hitInfo.BodyPart = this.Const.BodyPart.Body;
							hitInfo.FatalityChanceMult = 0.0;
							hitInfo.Injuries = this.Const.Injury.PiercingBody;
							target.onDamageReceived(this, null, hitInfo);
							local f = this.isAlliedWith(target) ? 0.5 : 1.0;
							local hitInfo = clone this.Const.Tactical.HitInfo;
							hitInfo.DamageRegular = this.Math.rand(10, 15) * f;
							hitInfo.DamageArmor = hitInfo.DamageRegular * 0.75;
							hitInfo.DamageDirect = 0.3;
							hitInfo.BodyPart = this.Const.BodyPart.Head;
							hitInfo.FatalityChanceMult = 0.0;
							hitInfo.Injuries = this.Const.Injury.PiercingBody;
							target.onDamageReceived(this, null, hitInfo);
						}
					}
				}
			}

			this.Sound.play(this.m.Sound[this.Const.Sound.ActorEvent.Other1][this.Math.rand(0, this.m.Sound[this.Const.Sound.ActorEvent.Other1].len() - 1)], this.Const.Sound.Volume.Actor, this.getPos());
			this.Sound.play(this.m.Sound[this.Const.Sound.ActorEvent.Other2][this.Math.rand(0, this.m.Sound[this.Const.Sound.ActorEvent.Other2].len() - 1)], this.Const.Sound.Volume.Actor, this.getPos());
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}
});
})