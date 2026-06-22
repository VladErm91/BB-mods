this.named_estoc <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		StunChance = 0
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
		this.m.ID = "weapon.named_estoc";
		this.m.NameList = this.Const.Strings.GreatswordNames;
		this.m.Description = "Этот эсток - настоящий шедевр, одновременно гибкий и необычайно прочный.";
		this.m.Categories = "Меч, двуручное";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 4500;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.ShieldDamage = 0;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 75;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 0.70;
		this.m.DirectDamageMult = 0.50;
		this.m.ChanceToHitHead = 5;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/estoc_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/estoc_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_estoc_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/penetrate"));
		this.addSkill(this.new("scripts/skills/actives/run_through"));
		local lunge = this.new("scripts/skills/actives/lunge_skill");
		lunge.m.Name = "Прокол";
		lunge.m.Description = "Сильный дальний удар, позволяющий застать врага врасплох. Чем быстрее персонаж, тем больше урона он нанесёт.";
		lunge.m.DirectDamageMult = 0.50;
		lunge.setFatigueCost(30);
		lunge.m.ActionPointCost = 6;
		lunge.m.Icon = "skills/lunge_estoc.png";
		lunge.m.IconDisabled = "skills/lunge_estoc_sw.png";
		lunge.m.Overlay = "lunge_estoc";
		this.addSkill(lunge);
	}

});

