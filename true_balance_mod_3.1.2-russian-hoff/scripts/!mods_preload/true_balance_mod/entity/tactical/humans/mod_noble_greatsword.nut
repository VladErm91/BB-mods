::mods_registerMod("mod_noble_greatsword", 1.8, "True Balance Mod Noble Greatsword");
::mods_queue("mod_noble_greatsword", "mod_true_balance", function() {
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

		if (this.ClassName == "noble_greatsword" && !this.m.IsMiniboss)
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;
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

			if (this.Math.rand(1, 100) <= 50)
			{
				this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
			}

			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/estoc"));
			}
	
			if (this.Const.DLC.Unhold)
			{
				r = this.Math.rand(3, 5);

				if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/armor/scale_armor"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/armor/footman_armor"));
				}
			}
			else
			{
				r = this.Math.rand(1, 4);

				if (r <= 2)
				{
					local armor = this.new("scripts/items/armor/mail_hauberk");
					armor.setVariant(28);
					this.m.Items.equip(armor);
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/armor/scale_armor"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
				}
			}

			r = this.Math.rand(1, 1);

			if (r == 1)
			{
				local helm = this.new("scripts/items/helmets/greatsword_faction_helm");
				helm.setVariant(banner);
				this.m.Items.equip(helm);
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

		if (this.ClassName == "noble_greatsword")
		{
			this.m.Skills.removeByID("perk.anticipation");
			this.m.Skills.removeByID("perk.battle_forged");
			this.m.Skills.add(this.new("scripts/skills/perks/perk_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recovera"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		}
	};
});
})
