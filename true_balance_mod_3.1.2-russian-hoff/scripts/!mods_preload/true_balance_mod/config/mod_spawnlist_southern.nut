local gt = this.getroottable();
gt.Const.EntityType.Manhunter <- gt.Const.EntityType.len() -3
gt.Const.Strings.EntityName.push("Погонщик рабов");
gt.Const.Strings.EntityNamePlural.push("Погонщики рабов");
gt.Const.EntityIcon.push("nomad_02_orientation");
gt.Const.World.Spawn.Troops.Manhunter <- {
	ID = gt.Const.EntityType.Manhunter,
	Variant = 0,
	Strength = 20,
	Cost = 15,
	Row = 1,
	Script = "scripts/entity/tactical/humans/manhunter"
};
gt.Const.Tactical.Actor.Manhunter <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 80,
	Stamina = 120,
	MeleeSkill = 65,
	RangedSkill = 65,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 18
};

gt.Const.EntityType.YuuGod <- gt.Const.EntityType.len() -3
gt.Const.Strings.EntityName.push("Йуши-Грод");
gt.Const.Strings.EntityNamePlural.push("Йуши-Грод");
gt.Const.EntityIcon.push("orc_01_orientation");
gt.Const.World.Spawn.Troops.YuuGod <- {
	ID = gt.Const.EntityType.YuuGod,
	Variant = 0,
	Strength = 45,
	Cost = 50,
	Row = 2,
	Script = "scripts/entity/tactical/enemies/yuu_god"
};
if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.Southern <- [
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 5
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 15
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 12
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 12
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 4
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 12
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 14
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 16
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 13
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 14
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 14
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 12
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 14
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 12
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 14
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 12
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 14
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 14
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 12
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 12
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		Body = "figure_southern_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 12
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.Gunner,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Mortar,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Engineer,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 5
			}
		]
	}
];
gt.Const.World.Spawn.CaravanSouthern <- [
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 9
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 10
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 3
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 3
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 3
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
				Num = 7
			},
			{
				Type = this.Const.World.Spawn.Troops.Officer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 3
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Mercenary,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.MercenaryRanged,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	}
];
gt.Const.World.Spawn.CaravanSouthernEscort <- [
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 3
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Conscript,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.SouthernDonkey,
				Num = 3
			}
		]
	}
];
gt.Const.World.Spawn.Slaves <- [
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 6
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 8
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 9
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 10
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 11
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 12
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 13
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 14
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 15
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 16
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 17
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 18
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 19
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 20
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 21
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 22
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 23
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 24
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 25
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 26
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 27
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 28
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Slave,
				Num = 29
			}
		]
	}
];
gt.Const.World.Spawn.Manhunters <- [
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 2
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 3
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 4
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 5
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 6
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 7
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 8
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 9
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Manhunter,
				Num = 10
			}
		]
	}
];
gt.Const.World.Spawn.NorthernSlaves <- [
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 6
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 8
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 9
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 10
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 11
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 12
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 13
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 14
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 15
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 16
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 17
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 18
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 19
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 20
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 21
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 22
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 23
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 24
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 25
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 26
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 27
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 28
			}
		]
	},
	{
		MovementSpeedMult = 0.66,
		Body = "figure_slave_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.NorthernSlave,
				Num = 29
			}
		]
	}
];
gt.Const.World.Spawn.Assassins <- [
	{
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 3
			}
		]
	},
	{
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 4
			}
		]
	},
	{
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 5
			}
		]
	},
	{
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 6
			}
		]
	},
	{
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 7
			}
		]
	},
	{
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 8
			}
		]
	},
	{
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 9
			}
		]
	},
	{
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 10
			}
		]
	},
	{
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 11
			}
		]
	},
	{
		Body = "figure_southern_01",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Assassin,
				Num = 12
			}
		]
	}
];
function onCostCompare( _t1, _t2 )
{
	if (_t1.Cost < _t2.Cost)
	{
		return -1;
	}
	else if (_t1.Cost > _t2.Cost)
	{
		return 1;
	}

	return 0;
}

function calculateCosts( _p )
{
	foreach( p in _p )
	{
		p.Cost <- 0;

		foreach( t in p.Troops )
		{
			p.Cost += t.Type.Cost * t.Num;
		}

		if (!("MovementSpeedMult" in p))
		{
			p.MovementSpeedMult <- 1.0;
		}

		if (!("VisibilityMult" in p))
		{
			p.VisibilityMult <- 1.0;
		}

		if (!("VisionMult" in p))
		{
			p.VisionMult <- 1.0;
		}
	}

	_p.sort(this.onCostCompare);
}

this.calculateCosts(this.Const.World.Spawn.Southern);
this.calculateCosts(this.Const.World.Spawn.CaravanSouthern);
this.calculateCosts(this.Const.World.Spawn.CaravanSouthernEscort);
this.calculateCosts(this.Const.World.Spawn.Slaves);
this.calculateCosts(this.Const.World.Spawn.NorthernSlaves);
this.calculateCosts(this.Const.World.Spawn.Assassins);

