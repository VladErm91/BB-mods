::mods_registerMod("mod_noble_sergeant", 1.8, "True Balance Mod Noble Sergeant");
::mods_queue("mod_noble_sergeant", "mod_true_balance", function() {
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

		if (this.ClassName == "noble_sergeant")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local banner = 3;

			if (!this.Tactical.State.isScenarioMode())
			{
				banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
			}
			else
			{
				banner = this.getFaction();
			}
	
			this.m.Surcoat = banner;

			if (this.Math.rand(1, 100) <= 80)
			{
				this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
			}

			local r = this.Math.rand(1, 5);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/warhammer"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/fighting_axe"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/winged_mace"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_cleaver"));
			}

			r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/noble_mail_armor"));
				this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/mail_hauberk"));
				this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/noble_mail_armor"));
				this.m.Items.equip(this.new("scripts/items/helmets/feathered_hat"));
			}
			else if (r == 4)
			{
				local item = this.new("scripts/items/armor/mail_hauberk");
				this.m.Items.equip(this.new("scripts/items/helmets/feathered_hat"));
				item.setVariant(30);
				this.m.Items.equip(item);
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

		if (this.ClassName == "noble_sergeant")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_blend_in"));
		}
	};
});
})
