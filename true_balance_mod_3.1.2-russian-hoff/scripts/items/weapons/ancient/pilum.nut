this.pilum <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function isAmountShown()
	{
		return true;
	}

	function getAmountString()
	{
		return this.m.Ammo + "/" + this.m.AmmoMax;
	}

	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.pilum";
		this.m.Name = "Пилум";
		this.m.Description = "Легче обычного копья, но тяжелее дротиков, это оружие предназначено для бросков на короткие дистанции. Навершие гнётся после попадании, приводя щиты в негодность. Попадание в цель без щита нанесёт ей ужасающий урон.";
		this.m.Categories = "Метательное оружие, одноручное";
		this.m.IconLarge = "weapons/ranged/throwing_spear_01.png";
		this.m.Icon = "weapons/ranged/throwing_spear_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Tool;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_rust_spear";
		this.m.Value = 80;
		this.m.Ammo = 1;
		this.m.AmmoMax = 1;
		this.m.AmmoCost = 6;
		this.m.RangeMin = 2;
		this.m.RangeMax = 4;
		this.m.RangeIdeal = 4;
		this.m.StaminaModifier = -6;
		this.m.ShieldDamage = 12;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.45;
		this.m.IsDroppedAsLoot = false;
	}

	function setAmmo( _a )
	{
		this.weapon.setAmmo(_a);

		if (this.m.Ammo > 0)
		{
			this.m.Name = "Пилум";
			this.m.IconLarge = "weapons/ranged/throwing_spear_01.png";
			this.m.Icon = "weapons/ranged/throwing_spear_01_70x70.png";
			this.m.ShowArmamentIcon = true;
		}
		else
		{
			this.m.Name = "Пилум (использован)";
			this.m.IconLarge = "weapons/ranged/javelins_01_bag.png";
			this.m.Icon = "weapons/ranged/javelins_01_bag_70x70.png";
			this.m.ShowArmamentIcon = false;
		}

		this.updateAppearance();
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local throw_sper_skill = this.new("scripts/skills/actives/throw_sper_skill");
		throw_sper_skill.m.ActionPointCost = 3;
		this.addSkill(throw_sper_skill);
		local throw_spear_skill = this.new("scripts/skills/actives/throw_spear_skill");
		throw_spear_skill.m.ActionPointCost = 3;
		this.addSkill(throw_spear_skill);
	}

});

