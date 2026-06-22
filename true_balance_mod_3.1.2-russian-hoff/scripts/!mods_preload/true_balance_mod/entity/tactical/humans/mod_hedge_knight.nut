::mods_registerMod("mod_hedge_knight", 1.8, "True Balance Mod Hedge Knight");
::mods_queue("mod_hedge_knight", "mod_true_balance", function() {
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

		if (this.ClassName == "hedge_knight")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
			{
				local weapons = [
					"weapons/greatsword",
					"weapons/greataxe",
					"weapons/two_handed_hammer"
				];

				if (this.Const.DLC.Unhold && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
				{
					weapons.extend([
						"weapons/two_handed_flanged_mace",
						"weapons/two_handed_flail"
					]);
				}

				if (this.Const.DLC.Wildmen && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
				{
					weapons.extend([
						"weapons/bardiche"
					]);
				}

				this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			}

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
			{
				local armor = [
					"armor/coat_of_plates",
					"armor/coat_of_scales",
					"armor/sellsword_armor",
					"armor/heavy_lamellar_armor"
				];
				this.m.Items.equip(this.new("scripts/items/" + armor[this.Math.rand(0, armor.len() - 1)]));
			}

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
			{
				local helmet = [
					"helmets/full_helm",
					"helmets/closed_flat_top_with_mail"
				];
				this.m.Items.equip(this.new("scripts/items/" + helmet[this.Math.rand(0, helmet.len() - 1)]));
			}	

			if (this.m.IsMiniboss)
			{	
				local r = this.Math.rand(2, 3);

				if (r == 2)
				{
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					local weapons = [
						"weapons/named/named_greataxe",
						"weapons/named/named_greatsword",
						"weapons/named/named_two_handed_hammer"
					];

					if (this.Const.DLC.Unhold)
					{
						weapons.extend([
							"weapons/named/named_two_handed_mace",
							"weapons/named/named_two_handed_flail"
						]);
					}

					if (this.Const.DLC.Wildmen)
					{
						weapons.extend([
							"weapons/named/named_bardiche"
						]);
					}
					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
				}
				else if (r == 3)
				{
					local armor = [
						"armor/named/brown_coat_of_plates_armor",
						"armor/named/golden_scale_armor",
						"armor/named/green_coat_of_plates_armor"
					];
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

		if (this.ClassName == "hedge_knight")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_indomitable"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_full_force"));
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

		if (this.ClassName == "hedge_knight")
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/mod_bounty_hunter_melee_agent");
			this.m.AIAgent.setActor(this);
		}
	};
});
})