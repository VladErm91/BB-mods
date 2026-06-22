local gt = this.getroottable();
gt.Const.CharacterProperties.IsRooteds <- false;
gt.Const.CharacterProperties.IsProvoke <- false;
gt.Const.CharacterProperties.IsRipostings <- false;
gt.Const.CharacterProperties.IsSkillUseDobleCost <- false;
gt.Const.CharacterProperties.StunResist <- 0;
gt.Const.CharacterProperties.DisarmResist <- 0;
gt.Const.Injury.SaberBody <- [
	{
		ID = "injury.cut_leg_muscles",
		Threshold = 0.25,
		Script = "injury/cut_leg_muscles_injury"
	},
	{
		ID = "injury.cut_arm_sinew",
		Threshold = 0.25,
		Script = "injury/cut_arm_sinew_injury"
	},
	{
		ID = "injury.cut_arm",
		Threshold = 0.25,
		Script = "injury/cut_arm_injury"
	},
	{
		ID = "injury.split_shoulder",
		Threshold = 0.5,
		Script = "injury/split_shoulder_injury"
	},
	{
		ID = "injury.split_hand",
		Threshold = 0.5,
		Script = "injury/split_hand_injury"
	},
	{
		ID = "injury.deep_chest_cut",
		Threshold = 0.5,
		Script = "injury/deep_chest_cut_injury"
	}
];
gt.Const.Injury.SaberHead <- [
	{
		ID = "injury.deep_face_cut",
		Threshold = 0.5,
		Script = "injury/deep_face_cut_injury"
	},
	{
		ID = "injury.cut_throat",
		Threshold = 0.5,
		Script = "injury/cut_throat_injury"
	}
];

gt.Const.Injury.BurningHand <- [
	{
		ID = "injury.burnt_hands",
		Threshold = 0.5,
		Script = "injury/burnt_hands_injury"
	}
];

gt.Const.Tactical.Actor.Wardog <- {
	XP = 75,
	ActionPoints = 12,
	Hitpoints = 50,
	Bravery = 40,
	Stamina = 130,
	MeleeSkill = 50,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 25,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Warhound <- {
	XP = 100,
	ActionPoints = 11,
	Hitpoints = 70,
	Bravery = 50,
	Stamina = 140,
	MeleeSkill = 55,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.WarWolf <- {
	XP = 150,
	ActionPoints = 12,
	Hitpoints = 90,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 25,
	RangedDefense = 25,
	Initiative = 135,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.BanditThug <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 40,
	Stamina = 95,
	MeleeSkill = 55,
	RangedSkill = 45,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.BanditPoacher <- {
	XP = 175,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 40,
	Stamina = 95,
	MeleeSkill = 50,
	RangedSkill = 50,
	MeleeDefense = 0,
	RangedDefense = 5,
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.BanditMarksman <- {
	XP = 225,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 50,
	Stamina = 120,
	MeleeSkill = 50,
	RangedSkill = 60,
	MeleeDefense = 5,
	RangedDefense = 10,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 18
};
gt.Const.Tactical.Actor.BanditRaider <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 55,
	Stamina = 130,
	MeleeSkill = 65,
	RangedSkill = 55,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 18
};
gt.Const.Tactical.Actor.BanditLeader <- {
	XP = 375,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 70,
	Stamina = 135,
	MeleeSkill = 75,
	RangedSkill = 65,
	MeleeDefense = 15,
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

gt.Const.Tactical.Actor.Ghoul <- {
	XP = 125,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 50,
	Stamina = 130,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 15,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.Direwolf <- {
	XP = 200,
	ActionPoints = 12,
	Hitpoints = 130,
	Bravery = 50,
	Stamina = 180,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		30,
		30
	]
};
gt.Const.Tactical.Actor.FrenziedDirewolf <- {
	XP = 250,
	ActionPoints = 12,
	Hitpoints = 150,
	Bravery = 70,
	Stamina = 180,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		30,
		30
	]
};
gt.Const.Tactical.Actor.Hyena <- {
	XP = 200,
	ActionPoints = 14,
	Hitpoints = 120,
	Bravery = 50,
	Stamina = 180,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
	]
};
gt.Const.Tactical.Actor.FrenziedHyena <- {
	XP = 250,
	ActionPoints = 14,
	Hitpoints = 140,
	Bravery = 70,
	Stamina = 180,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
	]
};
gt.Const.Tactical.Actor.Spider <- {
	XP = 100,
	ActionPoints = 11,
	Hitpoints = 60,
	Bravery = 45,
	Stamina = 130,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
	]
};
gt.Const.Tactical.Actor.SpiderEggs <- {
	XP = 0,
	ActionPoints = 0,
	Hitpoints = 20,
	Bravery = 0,
	Stamina = 0,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = -50,
	RangedDefense = 0,
	Initiative = 0,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.Lindwurm <- {
	XP = 800,
	ActionPoints = 7,
	Hitpoints = 1100,
	Bravery = 180,
	Stamina = 400,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = -10,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		400,
		200
	]
};
gt.Const.Tactical.Actor.Unhold <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 500,
	Bravery = 130,
	Stamina = 400,
	MeleeSkill = 70,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 75,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.UnholdFrost <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 600,
	Bravery = 150,
	Stamina = 400,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 85,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		90,
		90
	]
};
gt.Const.Tactical.Actor.UnholdBog <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 500,
	Bravery = 130,
	Stamina = 400,
	MeleeSkill = 70,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 75,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.Alp <- {
	XP = 300,
	ActionPoints = 10,
	Hitpoints = 100,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 60,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Vision = 7,
	Armor = [
		0,
		0
	],
	TeleportTargets = [],
	TeleportFrame = 0
};
gt.Const.Tactical.Actor.Hexe <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 160,
	Stamina = 80,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Vision = 8,
	Armor = [
		25,
		0
	]
};
gt.Const.Tactical.Actor.Schrat <- {
	XP = 600,
	ActionPoints = 7,
	Hitpoints = 600,
	Bravery = 200,
	Stamina = 400,
	MeleeSkill = 70,
	RangedSkill = 0,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 60,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.SchratSmall <- {
	XP = 50,
	ActionPoints = 7,
	Hitpoints = 75,
	Bravery = 150,
	Stamina = 400,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.TricksterGod <- {
	XP = 1500,
	ActionPoints = 9,
	Hitpoints = 2500,
	Bravery = 999,
	Stamina = 400,
	MeleeSkill = 100,
	RangedSkill = 0,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		130,
		130
	]
};
gt.Const.Tactical.Actor.Kraken <- {
	XP = 2500,
	ActionPoints = 9,
	Hitpoints = 4400,
	Bravery = 500,
	Stamina = 999,
	MeleeSkill = 999,
	RangedSkill = 0,
	MeleeDefense = -15,
	RangedDefense = -15,
	Initiative = -300,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		1600,
		1600
	]
};
gt.Const.Tactical.Actor.KrakenTentacle <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 300,
	Bravery = 60,
	Stamina = 999,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 25,
	RangedDefense = 25,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.Serpent <- {
	XP = 175,
	ActionPoints = 9,
	Hitpoints = 130,
	Bravery = 100,
	Stamina = 110,
	MeleeSkill = 65,
	RangedSkill = 90,
	MeleeDefense = 10,
	RangedDefense = 25,
	Initiative = 50,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Armor = [
		40,
		40
	]
};
gt.Const.Tactical.Actor.SandGolem <- {
	XP = 150,
	ActionPoints = 8,
	Hitpoints = 110,
	Bravery = 999,
	Stamina = 400,
	MeleeSkill = 65,
	RangedSkill = 60,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 60,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		110,
		110
	]
};

gt.Const.Tactical.Actor.Peasant <- {
	XP = 50,
	ActionPoints = 9,
	Hitpoints = 50,
	Bravery = 35,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 30,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Militia <- {
	XP = 125,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 35,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.MilitiaRanged <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 55,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.MilitiaVeteran <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 110,
	MeleeSkill = 60,
	RangedSkill = 40,
	MeleeDefense = 5,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.MilitiaCaptain <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 80,
	Stamina = 120,
	MeleeSkill = 65,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.CaravanHand <- {
	XP = 125,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 40,
	Stamina = 120,
	MeleeSkill = 50,
	RangedSkill = 30,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.CaravanGuard <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 130,
	MeleeSkill = 70,
	RangedSkill = 40,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Donkey <- {
	XP = 50,
	ActionPoints = 1,
	Hitpoints = 180,
	Bravery = 100,
	Stamina = 200,
	MeleeSkill = 1,
	RangedSkill = 1,
	MeleeDefense = -30,
	RangedDefense = -10,
	Initiative = 50,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 30
};
gt.Const.Tactical.Actor.BountyHunter <- {
	XP = 300,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 65,
	Stamina = 125,
	MeleeSkill = 75,
	RangedSkill = 60,
	MeleeDefense = 15,
	RangedDefense = 8,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.BountyHunterRanged <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 65,
	Stamina = 115,
	MeleeSkill = 50,
	RangedSkill = 70,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Mercenary <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 70,
	Stamina = 135,
	MeleeSkill = 75,
	RangedSkill = 65,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.MercenaryRanged <- {
	XP = 300,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 70,
	Stamina = 135,
	MeleeSkill = 65,
	RangedSkill = 75,
	MeleeDefense = 10,
	RangedDefense = 15,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Swordmaster <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 90,
	Stamina = 115,
	MeleeSkill = 100,
	RangedSkill = 50,
	MeleeDefense = 80,
	RangedDefense = 15,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.HedgeKnight <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 150,
	Bravery = 90,
	Stamina = 160,
	MeleeSkill = 85,
	RangedSkill = 50,
	MeleeDefense = 25,
	RangedDefense = 15,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25
};
gt.Const.Tactical.Actor.MasterArcher <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 70,
	Stamina = 135,
	MeleeSkill = 65,
	RangedSkill = 85,
	MeleeDefense = 15,
	RangedDefense = 25,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Councilman <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 40,
	Stamina = 120,
	MeleeSkill = 50,
	RangedSkill = 30,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Envoy <- {
	XP = 0,
	ActionPoints = 9,
	Hitpoints = 50,
	Bravery = 40,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 30,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Cultist <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 80,
	Stamina = 110,
	MeleeSkill = 60,
	RangedSkill = 40,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

gt.Const.Tactical.Actor.OrcYoung <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 125,
	Bravery = 65,
	Stamina = 150,
	MeleeSkill = 60,
	RangedSkill = 50,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.15
};
gt.Const.Tactical.Actor.OrcBerserker <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 250,
	Bravery = 90,
	Stamina = 200,
	MeleeSkill = 70,
	RangedSkill = 30,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 35,
	DamageTotalMult = 1.2
};
gt.Const.Tactical.Actor.OrcWarrior <- {
	XP = 400,
	ActionPoints = 8,
	Hitpoints = 200,
	Bravery = 85,
	Stamina = 200,
	MeleeSkill = 70,
	RangedSkill = 40,
	MeleeDefense = -10,
	RangedDefense = -10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 30,
	DamageTotalMult = 1.25
};
gt.Const.Tactical.Actor.OrcWarlord <- {
	XP = 500,
	ActionPoints = 8,
	Hitpoints = 300,
	Bravery = 90,
	Stamina = 250,
	MeleeSkill = 80,
	RangedSkill = 40,
	MeleeDefense = -10,
	RangedDefense = -10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 30,
	DamageTotalMult = 1.35
};
gt.Const.Tactical.Actor.GoblinAmbusher <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 30,
	Bravery = 45,
	Stamina = 100,
	MeleeSkill = 60,
	RangedSkill = 75,
	MeleeDefense = 10,
	RangedDefense = 25,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.GoblinFighter <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 40,
	Bravery = 55,
	Stamina = 100,
	MeleeSkill = 75,
	RangedSkill = 65,
	MeleeDefense = 20,
	RangedDefense = 10,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.GoblinWolfrider <- {
	XP = 150,
	ActionPoints = 13,
	Hitpoints = 60,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 75,
	RangedSkill = 50,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Wolf <- {
	XP = 100,
	ActionPoints = 12,
	Hitpoints = 40,
	Bravery = 40,
	Stamina = 150,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 15,
	RangedDefense = 10,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.GoblinLeader <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 80,
	Stamina = 130,
	MeleeSkill = 75,
	RangedSkill = 80,
	MeleeDefense = 15,
	RangedDefense = 20,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.GoblinShaman <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 70,
	Stamina = 90,
	MeleeSkill = 60,
	RangedSkill = 60,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.GreenskinCatapult <- {
	XP = 100,
	ActionPoints = 1,
	Hitpoints = 250,
	Bravery = 100,
	Stamina = 200,
	MeleeSkill = 1,
	RangedSkill = 1,
	MeleeDefense = -30,
	RangedDefense = -20,
	Initiative = 50,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 30
};

gt.Const.Tactical.Actor.Footman <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 70,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Billman <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 70,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Greatsword <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 70,
	Stamina = 130,
	MeleeSkill = 75,
	RangedSkill = 50,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Sergeant <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 80,
	Stamina = 130,
	MeleeSkill = 80,
	RangedSkill = 60,
	MeleeDefense = 25,
	RangedDefense = 25,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Arbalester <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 60,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 60,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.StandardBearer <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 80,
	Stamina = 130,
	MeleeSkill = 65,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Knight <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 135,
	Bravery = 90,
	Stamina = 145,
	MeleeSkill = 90,
	RangedSkill = 60,
	MeleeDefense = 20,
	RangedDefense = 10,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 18
};
gt.Const.Tactical.Actor.Noble <- {
	XP = 300,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 75,
	Stamina = 130,
	MeleeSkill = 75,
	RangedSkill = 60,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 18
};

gt.Const.Tactical.Actor.Conscript <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 70,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Gunner <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 65,
	RangedSkill = 75,
	MeleeDefense = 5,
	RangedDefense = 10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Officer <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 110,
	Bravery = 80,
	Stamina = 135,
	MeleeSkill = 85,
	RangedSkill = 60,
	MeleeDefense = 25,
	RangedDefense = 15,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 18
};
gt.Const.Tactical.Actor.Engineer <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 50,
	MeleeDefense = 0,
	RangedDefense = 5,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Assassin <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 85,
	Stamina = 125,
	MeleeSkill = 80,
	RangedSkill = 70,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Slave <- {
	XP = 50,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 40,
	Stamina = 100,
	MeleeSkill = 45,
	RangedSkill = 35,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Gladiator <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 110,
	Bravery = 90,
	Stamina = 140,
	MeleeSkill = 75,
	RangedSkill = 65,
	MeleeDefense = 20,
	RangedDefense = 10,
	Initiative = 135,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 18
};
gt.Const.Tactical.Actor.Mortar <- {
	XP = 0,
	ActionPoints = 6,
	Hitpoints = 9999,
	Bravery = 999,
	Stamina = 999,
	MeleeSkill = 1,
	RangedSkill = 1,
	MeleeDefense = -50,
	RangedDefense = -50,
	Initiative = 50,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		9999,
		9999
	],
	FatigueRecoveryRate = 0
};
gt.Const.Tactical.Actor.NomadCutthroat <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 45,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 45,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.NomadSlinger <- {
	XP = 175,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 45,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 60,
	MeleeDefense = 0,
	RangedDefense = 10,
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.NomadArcher <- {
	XP = 225,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 55,
	Stamina = 115,
	MeleeSkill = 50,
	RangedSkill = 65,
	MeleeDefense = 5,
	RangedDefense = 15,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.NomadOutlaw <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 60,
	Stamina = 130,
	MeleeSkill = 65,
	RangedSkill = 55,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 18
};
gt.Const.Tactical.Actor.NomadLeader <- {
	XP = 375,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 75,
	Stamina = 135,
	MeleeSkill = 75,
	RangedSkill = 65,
	MeleeDefense = 20,
	RangedDefense = 15,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 18
};
gt.Const.Tactical.Actor.DesertDevil <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 90,
	Stamina = 130,
	MeleeSkill = 90,
	RangedSkill = 50,
	MeleeDefense = 50,
	RangedDefense = 30,
	Initiative = 135,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Executioner <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 170,
	Bravery = 90,
	Stamina = 160,
	MeleeSkill = 85,
	RangedSkill = 50,
	MeleeDefense = 30,
	RangedDefense = 20,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25
};
gt.Const.Tactical.Actor.DesertStalker <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 70,
	Stamina = 135,
	MeleeSkill = 65,
	RangedSkill = 85,
	MeleeDefense = 15,
	RangedDefense = 25,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};

gt.Const.Tactical.Actor.SkeletonLight <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 45,
	Bravery = 60,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 0,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 65,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.SkeletonMedium <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 80,
	Stamina = 100,
	MeleeSkill = 65,
	RangedSkill = 60,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 65,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.SkeletonHeavy <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 70,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.SkeletonPriest <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 0,
	MeleeDefense = 0,
	RangedDefense = 5,
	Initiative = 5,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.SkeletonLich <- {
	XP = 750,
	ActionPoints = 12,
	Hitpoints = 240,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 50,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.SkeletonLichMirrorImage <- {
	XP = 1,
	ActionPoints = 5,
	Hitpoints = 1,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 70,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.FlyingSkull <- {
	XP = 1,
	ActionPoints = 6,
	Hitpoints = 25,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 80,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.SkeletonPhylactery <- {
	XP = 0,
	ActionPoints = 0,
	Hitpoints = 25,
	Bravery = 0,
	Stamina = 0,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = -50,
	RangedDefense = 0,
	Initiative = 0,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.SkeletonBoss <- {
	XP = 600,
	ActionPoints = 9,
	Hitpoints = 350,
	Bravery = 120,
	Stamina = 100,
	MeleeSkill = 90,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 10,
	Initiative = 70,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	],
	DamageTotalMult = 1.35
};
gt.Const.Tactical.Actor.Zombie <- {
	XP = 100,
	ActionPoints = 6,
	Hitpoints = 100,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 45,
	RangedSkill = 5,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 45,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.ZombieYeoman <- {
	XP = 150,
	ActionPoints = 6,
	Hitpoints = 130,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 0,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 45,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.ZombieKnight <- {
	XP = 300,
	ActionPoints = 7,
	Hitpoints = 180,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 0,
	Initiative = 60,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.ZombieBetrayer <- {
	XP = 350,
	ActionPoints = 8,
	Hitpoints = 200,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 0,
	Initiative = 70,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.ZombieTreasureHunter <- {
	XP = 250,
	ActionPoints = 8,
	Hitpoints = 180,
	Bravery = 80,
	Stamina = 100,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 0,
	Initiative = 70,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.ZombiePlayer <- {
	XP = 150,
	ActionPoints = 6,
	Hitpoints = 130,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 50,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.Vampire <- {
	XP = 400,
	ActionPoints = 8,
	Hitpoints = 225,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 85,
	RangedSkill = 0,
	MeleeDefense = 25,
	RangedDefense = 25,
	Initiative = 130,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		20,
		0
	]
};
gt.Const.Tactical.Actor.Ghost <- {
	XP = 275,
	ActionPoints = 9,
	Hitpoints = 1,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 30,
	RangedDefense = 999,
	Initiative = 95,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.ZombieBoss <- {
	XP = 500,
	ActionPoints = 9,
	Hitpoints = 500,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 95,
	RangedSkill = 0,
	MeleeDefense = 25,
	RangedDefense = 0,
	Initiative = 75,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		400,
		350
	]
};
gt.Const.Tactical.Actor.GhostKnight <- {
	XP = 500,
	ActionPoints = 9,
	Hitpoints = 275,
	Bravery = 130,
	Stamina = 100,
	MeleeSkill = 90,
	RangedSkill = 0,
	MeleeDefense = 50,
	RangedDefense = 999,
	Initiative = 105,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.Necromancer <- {
	XP = 400,
	ActionPoints = 7,
	Hitpoints = 50,
	Bravery = 90,
	Stamina = 90,
	MeleeSkill = 50,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 10,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		20,
		0
	]
};
gt.Const.Factions <- {
	GlobalMinDelay = 3.0,
	BuildCampTries = 1,
	RelationDecayPerDay = 0.33,
	CyclesOnNewCampaign = 2000,
	NeutralColor = this.createColor("#ffffff"),
	HostileColor = this.createColor("#e57878"),
	PermanentHostileColor = this.createColor("#c72727"),
	GreaterEvilStartStrength = 150.0,
	GreaterEvilDailyStrength = -1.0,
	GreaterEvilStrengthOnPartyDestroyed = -2.0,
	GreaterEvilStrengthOnLocationDestroyed = -4.0,
	GreaterEvilStrengthOnCriticalContract = -12.0,
	GreaterEvilStrengthOnCommonContract = -6.0,
	GreaterEvilStrengthOnFailedContract = 6.0,
	GreaterEvilStrengthOnTownDestroyed = 20.0
};
gt.Const.Items.AmmoType <- {
	None = 0,
	Arrows = 1,
	Bolts = 2,
	Spears = 4,
	Powder = 8,
	Balls = 16
};
gt.Const.Items.NamedArmors <- [
	"armor/named/black_leather_armor",
	"armor/named/blue_studded_mail_armor",
	"armor/named/brown_coat_of_plates_armor",
	"armor/named/golden_scale_armor",
	"armor/named/green_coat_of_plates_armor",
	"armor/named/heraldic_mail_armor"
];
gt.Const.Items.NamedHelmets <- [
	"helmets/named/golden_feathers_helmet",
	"helmets/named/heraldic_mail_helmet",
	"helmets/named/nasal_feather_helmet",
	"helmets/named/sallet_green_helmet",
	"helmets/named/wolf_helmet",
	"helmets/named/lindwurm_helmet"
];
gt.Const.Items.NamedShields <- [
	"shields/named/named_dragon_shield",
	"shields/named/named_full_metal_heater_shield",
	"shields/named/named_golden_round_shield",
	"shields/named/named_red_white_shield",
	"shields/named/named_rider_on_horse_shield",
	"shields/named/named_wing_shield"
];
gt.Const.Items.NamedBanditShields <- [
	"shields/named/named_bandit_kite_shield",
	"shields/named/named_bandit_heater_shield"
];
gt.Const.Items.NamedUndeadShields <- [
	"shields/named/named_undead_heater_shield",
	"shields/named/named_undead_kite_shield"
];
gt.Const.Items.NamedOrcShields <- [
	"shields/named/named_orc_heavy_shield"
];
gt.Const.Items.NamedSouthernShields <- [];
gt.Const.Items.NamedOrcWeapons <- [
	"weapons/named/named_orc_axe",
	"weapons/named/named_orc_cleaver"
];
gt.Const.Items.NamedGoblinWeapons <- [
	"weapons/named/named_goblin_falchion",
	"weapons/named/named_goblin_heavy_bow",
	"weapons/named/named_goblin_pike",
	"weapons/named/named_goblin_spear"
];
gt.Const.Items.NamedMeleeWeapons <- [
	"weapons/named/named_axe",
	"weapons/named/named_billhook",
	"weapons/named/named_cleaver",
	"weapons/named/named_dagger",
	"weapons/named/named_flail",
	"weapons/named/named_greataxe",
	"weapons/named/named_greatsword",
	"weapons/named/named_longaxe",
	"weapons/named/named_mace",
	"weapons/named/named_spear",
	"weapons/named/named_sword",
	"weapons/named/named_two_handed_hammer",
	"weapons/named/named_warbrand",
	"weapons/named/named_warhammer",
	"weapons/named/named_pike"
];
gt.Const.Items.NamedModMeleeWeapons <- [
	"weapons/named/named_axe",
	"weapons/named/named_billhook",
	"weapons/named/named_cleaver",
	"weapons/named/named_dagger",
	"weapons/named/named_flail",
	"weapons/named/named_greataxe",
	"weapons/named/named_greatsword",
	"weapons/named/named_longaxe",
	"weapons/named/named_mace",
	"weapons/named/named_spear",
	"weapons/named/named_sword",
	"weapons/named/named_two_handed_hammer",
	"weapons/named/named_warbrand",
	"weapons/named/named_warhammer",
	"weapons/named/named_estoc",
	"weapons/named/named_pike"
];
gt.Const.Items.NamedRangedWeapons <- [
	"weapons/named/named_crossbow",
	"weapons/named/named_javelin",
	"weapons/named/named_throwing_axe",
	"weapons/named/named_warbow"
];
gt.Const.Items.NamedWeapons <- clone gt.Const.Items.NamedMeleeWeapons;
gt.Const.Items.NamedWeapons.extend(gt.Const.Items.NamedRangedWeapons);
gt.Const.Items.NamedBarbarianWeapons <- [];
gt.Const.Items.NamedBarbarianHelmets <- [];
gt.Const.Items.NamedBarbarianArmors <- [];
gt.Const.Items.NamedSouthernWeapons <- [];
gt.Const.Items.NamedSouthernMeleeWeapons <- [];
gt.Const.Items.NamedSouthernHelmets <- [];
gt.Const.Items.NamedSouthernArmors <- [];
gt.Const.Items.NamedUndeadWeapons <- [
	"weapons/named/named_bladed_pike",
	"weapons/named/named_crypt_cleaver",
	"weapons/named/named_warscythe",
	"weapons/named/named_khopesh"
];
gt.Const.Items.NamedVampireWeapons <- [
	"weapons/named/named_crypt_cleaver",
	"weapons/named/named_khopesh"
];
gt.Const.Items.NamedNobleWeapons <- [
	"weapons/named/named_greatsword",
	"weapons/named/named_estoc"
];
gt.Const.Items.NamedWeapons.push("weapons/named/named_bardiche");
gt.Const.Items.NamedWeapons.push("weapons/named/named_shamshir");
gt.Const.Items.NamedWeapons.push("weapons/named/named_battle_whip");
gt.Const.Items.NamedMeleeWeapons.push("weapons/named/named_bardiche");
gt.Const.Items.NamedMeleeWeapons.push("weapons/named/named_shamshir");
gt.Const.Items.NamedMeleeWeapons.push("weapons/named/named_battle_whip");
gt.Const.Items.NamedHelmets.push("helmets/named/norse_helmet");
gt.Const.Items.NamedHelmets.push("helmets/named/named_conic_helmet_with_faceguard");
gt.Const.Items.NamedHelmets.push("helmets/named/named_nordic_helmet_with_closed_mail");
gt.Const.Items.NamedHelmets.push("helmets/named/named_steppe_helmet_with_mail");
gt.Const.Items.NamedSouthernHelmets.push("helmets/named/named_steppe_helmet_with_mail");
gt.Const.Items.NamedArmors.push("armor/named/named_golden_lamellar_armor");
gt.Const.Items.NamedArmors.push("armor/named/named_noble_mail_armor");
gt.Const.Items.NamedArmors.push("armor/named/named_sellswords_armor");
gt.Const.Items.NamedSouthernArmors.push("armor/named/named_golden_lamellar_armor");
gt.Const.Items.NamedBarbarianHelmets.push("helmets/named/named_metal_bull_helmet");
gt.Const.Items.NamedBarbarianHelmets.push("helmets/named/named_metal_nose_horn_helmet");
gt.Const.Items.NamedBarbarianHelmets.push("helmets/named/named_metal_skull_helmet");
gt.Const.Items.NamedBarbarianArmors.push("armor/named/named_bronze_armor");
gt.Const.Items.NamedBarbarianArmors.push("armor/named/named_plated_fur_armor");
gt.Const.Items.NamedBarbarianArmors.push("armor/named/named_skull_and_chain_armor");
gt.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_rusty_warblade");
gt.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_skullhammer");
gt.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_heavy_rusty_axe");
gt.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_two_handed_spiked_mace");
gt.Const.Items.NamedWeapons.push("weapons/named/named_qatal_dagger");
gt.Const.Items.NamedWeapons.push("weapons/named/named_swordlance");
gt.Const.Items.NamedWeapons.push("weapons/named/named_polemace");
gt.Const.Items.NamedWeapons.push("weapons/named/named_two_handed_scimitar");
gt.Const.Items.NamedWeapons.push("weapons/named/named_handgonne");
gt.Const.Items.NamedMeleeWeapons.push("weapons/named/named_qatal_dagger");
gt.Const.Items.NamedMeleeWeapons.push("weapons/named/named_swordlance");
gt.Const.Items.NamedMeleeWeapons.push("weapons/named/named_polemace");
gt.Const.Items.NamedMeleeWeapons.push("weapons/named/named_two_handed_scimitar");
gt.Const.Items.NamedSouthernWeapons.push("weapons/named/named_shamshir");
gt.Const.Items.NamedSouthernWeapons.push("weapons/named/named_qatal_dagger");
gt.Const.Items.NamedSouthernWeapons.push("weapons/named/named_swordlance");
gt.Const.Items.NamedSouthernWeapons.push("weapons/named/named_polemace");
gt.Const.Items.NamedSouthernWeapons.push("weapons/named/named_two_handed_scimitar");
gt.Const.Items.NamedSouthernWeapons.push("weapons/named/named_spear");
gt.Const.Items.NamedSouthernWeapons.push("weapons/named/named_handgonne");
gt.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_shamshir");
gt.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_qatal_dagger");
gt.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_swordlance");
gt.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_polemace");
gt.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_two_handed_scimitar");
gt.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_spear");
gt.Const.Items.NamedShields.push("shields/named/named_sipar_shield");
gt.Const.Items.NamedSouthernShields.push("shields/named/named_sipar_shield");
gt.Const.Items.NamedSouthernArmors.push("armor/named/black_and_gold_armor");
gt.Const.Items.NamedSouthernArmors.push("armor/named/leopard_armor");
gt.Const.Items.NamedArmors.push("armor/named/black_and_gold_armor");
gt.Const.Items.NamedArmors.push("armor/named/leopard_armor");
gt.Const.Items.NamedSouthernHelmets.push("helmets/named/red_and_gold_band_helmet");
gt.Const.Items.NamedSouthernHelmets.push("helmets/named/gold_and_black_turban");
gt.Const.Items.NamedHelmets.push("helmets/named/red_and_gold_band_helmet");
gt.Const.Items.NamedHelmets.push("helmets/named/gold_and_black_turban");

	function onApplyFire( _tile, _entity )
	{
		if (_entity.getCurrentProperties().IsImmuneToFire)
		{
			return;
		}

		this.Tactical.spawnIconEffect("status_effect_116", _tile, gt.Const.Tactical.Settings.SkillIconOffsetX, gt.Const.Tactical.Settings.SkillIconOffsetY, gt.Const.Tactical.Settings.SkillIconScale, gt.Const.Tactical.Settings.SkillIconFadeInDuration, gt.Const.Tactical.Settings.SkillIconStayDuration, gt.Const.Tactical.Settings.SkillIconFadeOutDuration, gt.Const.Tactical.Settings.SkillIconMovement);
		local sounds = [
			"sounds/combat/dlc6/status_on_fire_01.wav",
			"sounds/combat/dlc6/status_on_fire_02.wav",
			"sounds/combat/dlc6/status_on_fire_03.wav"
		];
		this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], gt.Const.Sound.Volume.Actor, _entity.getPos());
		local damageMult = 1.0;

		if (_entity.getType() == gt.Const.EntityType.Schrat)
		{
			damageMult = 3.0;
		}

		if (_entity.getSkills().hasSkill("racial.skeleton"))
		{
			damageMult = 0.33;
		}

		if (_entity.getSkills().hasSkill("items.firearms_resistance") || _entity.getSkills().hasSkill("racial.serpent"))
		{
			damageMult = 0.66;
		}

		local damage = this.Math.rand(15, 30);
		local hitInfo = clone gt.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = damage * damageMult;
		hitInfo.DamageArmor = damage;
		hitInfo.DamageMinimum = damage * 0.2;
		hitInfo.BodyPart = gt.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		hitInfo.Injuries = gt.Const.Injury.Burning;
		hitInfo.IsPlayingArmorSound = false;
		_entity.onDamageReceived(_entity, null, hitInfo);

		if ((!_entity.isAlive() || _entity.isDying()) && !_entity.isPlayerControlled() && (_tile.Properties.Effect == null || _tile.Properties.Effect.IsByPlayer))
		{
			this.updateAchievement("BurnThemAll", 1, 1);
		}
	}

local gt = this.getroottable();
gt.Const.AI.VerboseMode = true;

local function addAIBehaviour(_id, _name, _order, _score = null)
{
	::Const.AI.Behavior.ID[_id] <- ::Const.AI.Behavior.ID.COUNT
	::Const.AI.Behavior.ID.COUNT++
	::Const.AI.Behavior.Name.push(_name)
	::Const.AI.Behavior.Order[_id] <- _order;
	if(_score != null)
	{
		::Const.AI.Behavior.Score[_id] <- _score;
	}
	
}
addAIBehaviour("Lunge", "Lunge", 21, 100)
addAIBehaviour("LongswordSlash", "LongswordSlash", 20, 130)
addAIBehaviour("LongImpale", "LongImpale", 21, 200)
addAIBehaviour("DistantPound", "DistantPound", 19, 100)


