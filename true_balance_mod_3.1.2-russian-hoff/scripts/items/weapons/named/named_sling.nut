this.named_sling <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = this.Math.rand(1, 3);
		this.updateVariant();
		this.m.ID = "weapon.named_sling";
		this.m.NameList = this.Const.Strings.ThrowingAxeNames;
		this.m.Description = "Кожаная праща на окованном железом посохе, используемая для метания камней во врага. Камни можно найти повсюду, поэтому у неё никогда не закончатся боеприпасы.";
		this.m.Categories = "Метательное оружие, двуручное";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 2000;
		this.m.StaminaModifier = -6;
		this.m.RangeMin = 2;
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/ranged/sling_01" + this.m.Variant + ".png";
		this.m.Icon = "weapons/ranged/sling_01" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = this.m.Variant + "icon_sling";
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/sling_stone_skill"));
		this.addSkill(this.new("scripts/skills/actives/sling_balls_skill"));
	}

});

