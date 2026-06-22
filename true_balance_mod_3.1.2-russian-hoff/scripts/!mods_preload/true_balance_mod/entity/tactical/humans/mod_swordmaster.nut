::mods_registerMod("mod_swordmaster", 1.8, "True Balance Mod Swordmaster");
::mods_queue("mod_swordmaster", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/human", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.ClassName == "swordmaster")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Ammo));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
			{
				local weapons = [
					"weapons/noble_sword",
					"weapons/fencing_sword"
				];

				if (this.Const.DLC.Wildmen || this.Const.DLC.Desert)
				{
					weapons.extend([
						"weapons/noble_sword",
						"weapons/fencing_sword",
						"weapons/shamshir"
					]);
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
			{
				local armor = [
					"armor/mail_shirt",
					"armor/basic_mail_shirt"
				];

				if (this.Const.DLC.Unhold)
				{
					armor.extend([
						"armor/leather_scale_armor"
					]);
				}

				this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
			}

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head) && this.Math.rand(1, 100) <= 100)
			{
				local helmet = [
					"helmets/greatsword_hat",
					"helmets/headscarf",
					"helmets/feathered_hat"
				];
				this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
			}	
			if (this.m.IsMiniboss)
			{
				local weapons = [
					"weapons/named/named_sword"
				];

				if (this.Const.DLC.Wildmen || this.Const.DLC.Desert)
				{
					weapons.extend([
						"weapons/named/named_fencing_sword",
						"weapons/named/named_shamshir"
					]);
				}
		
				local armor = [
					"armor/named/black_leather_armor",
					"armor/named/blue_studded_mail_armor"
				];

				if (this.Const.DLC.Wildmen)
				{
					armor.extend([
						"armor/named/named_noble_mail_armor"
					]);
				}

				if (this.Math.rand(1, 100) <= 70)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
				}
				else
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
					this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
				}
			}	
		}		
	};
});
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("onAfterInit" in a))
	{
		a = a[a.SuperName];
	}

	local onAfterInit = a.onAfterInit;
	a.onAfterInit = function ()
	{
		onAfterInit();

		if (this.ClassName == "swordmaster")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		}
	};
});
::mods_hookBaseClass("entity/tactical/human", function ( a )
{
	while (!("create" in a))
	{
		a = a[a.SuperName];
	}

	local create = a.create;
	a.create = function ()
	{
		create();

		if (this.ClassName == "swordmaster")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bounty_hunter_melee_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})