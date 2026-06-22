::mods_registerMod("mod_champions", 1.8, "True Balance Mod Champions");
::mods_queue("mod_champions", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/actor", function (o)
{
	::mods_override (o[o.SuperName], "makeMiniboss", function()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return false;
		}

		this.m.XP *= 1.5;
		this.m.Skills.add(this.new("scripts/skills/racial/champion_racial"));
		this.m.IsMiniboss = true;
		this.m.IsGeneratingKillName = false;

		if (this.ClassName == "noble_greatsword")
		{		
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			this.getSprite("miniboss").setBrush("bust_miniboss");
			local weapons = this.Const.Items.NamedNobleWeapons;
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			this.m.Items.equip(this.new("scripts/items/armor/reinforced_mail_hauberk"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		}

		if (this.ClassName == "assassin")
		{		
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head));
			this.getSprite("miniboss").setBrush("bust_miniboss");
			local weapons = [
					"weapons/named/named_shamshir",
					"weapons/named/named_qatal_dagger",
					"weapons/named/named_qatal_dagger"
				];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			this.m.Items.equip(this.new("scripts/items/helmets/oriental/assassin_face_mask"));
		}

		if (this.ClassName == "nomad_leader")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		}	
		if (this.ClassName == "barbarian_champion")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		}	
		if (this.ClassName == "vampire")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			this.getSprite("miniboss").setBrush("bust_miniboss");
			local weapons = this.Const.Items.NamedVampireWeapons;
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		}	
		if (this.ClassName == "goblin_fighter")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
		}	
		if (this.ClassName == "goblin_ambusher")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		}
		if (this.ClassName == "bandit_leader")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
		}
		if (this.ClassName == "zombie_knight")
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"))
			this.m.Skills.add(this.new("scripts/skills/effects/follen_movement_effect"));
			this.m.ActionPoints = 9;
			this.m.BaseProperties.ActionPoints = 9;
			this.m.Skills.update();
		}

				local r = this.Math.rand(1, 100);

		if (this.ClassName == "spider" && r <= 50)
		{		
			this.m.Name = "Матриарх пауков";
			this.m.XP = 1000;
			this.m.BaseProperties.Hitpoints = 81;
			this.m.BaseProperties.MeleeSkill = 69;
			this.m.BaseProperties.Initiative = 130;
			this.m.BaseProperties.Bravery = 68;
			this.m.BaseProperties.Stamina = 195;
			this.m.BaseProperties.MeleeDefense = 23;
			this.m.BaseProperties.RangedDefense = 38;
			this.m.BaseProperties.ActionPoints = 11;
			this.m.Skills.update();
			this.setSize(100 * 0.01);
			this.m.Skills.removeByID("racial.champion");
			this.addSprite("socket").setBrush("bust_base_beasts");
			local body = this.addSprite("body");
			body.setBrush("bust_spider_06_body");

			if (this.Math.rand(0, 100) < 90)
			{
				body.varySaturation(0.2);
			}

			if (this.Math.rand(0, 100) < 90)
			{
				body.varyColor(0.05, 0.05, 0.05);
			}
			local legs_back = this.addSprite("legs_back");
			legs_back.setBrush("bust_spider_06_legs_back");
			local legs_front = this.addSprite("legs_front");
			legs_front.setBrush("bust_spider_06_legs_front");
			legs_front.Color = body.Color;
			legs_front.Saturation = body.Saturation;
			legs_back.Color = body.Color;
			legs_back.Saturation = body.Saturation;
			local head = this.addSprite("head");
			head.setBrush("bust_spider_06_head");
			head.Color = body.Color;
			head.Saturation = body.Saturation;
			local injury = this.addSprite("injury");
			injury.Visible = false;
			injury.setBrush("bust_spider_06_injured");
			this.m.Skills.add(this.new("scripts/skills/effects/champion_type_1_effect"));
			this.m.Skills.add(this.new("scripts/skills/racial/matriarh_racial"));
			this.m.Skills.removeByID("actives.web_skill");
			this.m.Skills.add(this.new("scripts/skills/actives/web_all_skill"));
		}	

		if (this.ClassName == "spider" && r > 50)
		{		
			this.m.Name = "Королева улья";
			this.m.XP = 1000;
			this.m.BaseProperties.Hitpoints = 150;
			this.m.BaseProperties.MeleeSkill = 69;
			this.m.BaseProperties.Initiative = 173;
			this.m.BaseProperties.Bravery = 68;
			this.m.BaseProperties.Stamina = 195;
			this.m.BaseProperties.MeleeDefense = 23;
			this.m.BaseProperties.RangedDefense = 38;
			this.m.BaseProperties.ActionPoints = 11;
			this.m.Skills.update();
			this.m.BloodType = this.Const.BloodType.Red;
			this.setSize(100 * 0.01);
			this.m.Skills.removeByID("racial.champion");
			this.addSprite("socket").setBrush("bust_base_beasts");
			local body = this.addSprite("body");
			body.setBrush("bust_spider_05_body");

			if (this.Math.rand(0, 100) < 90)
			{
				body.varySaturation(0.2);
			}

			if (this.Math.rand(0, 100) < 90)
			{
				body.varyColor(0.05, 0.05, 0.05);
			}
			local legs_back = this.addSprite("legs_back");
			legs_back.setBrush("bust_spider_05_legs_back");
			local legs_front = this.addSprite("legs_front");
			legs_front.setBrush("bust_spider_05_legs_front");
			legs_front.Color = body.Color;
			legs_front.Saturation = body.Saturation;
			legs_back.Color = body.Color;
			legs_back.Saturation = body.Saturation;
			local head = this.addSprite("head");
			head.setBrush("bust_spider_05_head");
			head.Color = body.Color;
			head.Saturation = body.Saturation;
			local injury = this.addSprite("injury");
			injury.Visible = false;
			injury.setBrush("bust_spider_05_injured");
			this.m.Skills.add(this.new("scripts/skills/effects/champion_type_2_effect"));
			this.m.Skills.add(this.new("scripts/skills/actives/hive_queen_bite_skill"));
			this.m.Skills.add(this.new("scripts/skills/racial/hive_queen_racial"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.removeByID("actives.spider_bite");
			this.m.Skills.removeByID("racial.spider_racial");
		}

		if (this.ClassName == "direwolf_high" && r <= 50)
		{		
			this.m.Name = "Жуткий волк";
			this.m.XP = 1000;
			local head_frenzy = this.getSprite("head_frenzy");
			head_frenzy.setBrush("");
			this.m.BaseProperties.Hitpoints = 300;
			this.m.BaseProperties.MeleeSkill = 85;
			this.m.BaseProperties.Initiative = 150;
			this.m.BaseProperties.Bravery = 90;
			this.m.BaseProperties.Stamina = 270;
			this.m.BaseProperties.MeleeDefense = 20;
			this.m.BaseProperties.RangedDefense = 20;
			this.m.BaseProperties.ActionPoints = 12;
			this.m.BaseProperties.DamageTotalMult = 1.35;
			this.m.BaseProperties.DamageDirectMult = 1.15;
			this.m.Skills.update();
			this.getSprite("miniboss").setBrush("bust_miniboss");
			this.m.Skills.removeByID("racial.champion");
			this.m.Skills.add(this.new("scripts/skills/effects/champion_type_2_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
			this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
			this.addSprite("socket").setBrush("bust_base_beasts");
			local body = this.addSprite("body");
			body.setBrush("bust_direvarg_02_body");

			if (this.Math.rand(0, 100) < 90)
			{
				body.varySaturation(0.2);
			}

			if (this.Math.rand(0, 100) < 90)
			{
				body.varyColor(0.05, 0.05, 0.05);
			}

			local head = this.addSprite("head");
			head.setBrush("bust_direvarg_02_head");
			head.Color = body.Color;
			head.Saturation = body.Saturation;
			local injury = this.addSprite("injury");
			injury.Visible = false;
			injury.setBrush("bust_direvarg_02_injured");
		}

		if (this.ClassName == "direwolf_high" && r > 50)
		{		
			this.m.Name = "Альфа-лютоволк";
			this.m.XP = 1000;
			local head_frenzy = this.getSprite("head_frenzy");
			head_frenzy.setBrush("");
			this.m.BaseProperties.Hitpoints = 255;
			this.m.BaseProperties.MeleeSkill = 75;
			this.m.BaseProperties.Initiative = 173;
			this.m.BaseProperties.Bravery = 105;
			this.m.BaseProperties.Stamina = 270;
			this.m.BaseProperties.MeleeDefense = 13;
			this.m.BaseProperties.RangedDefense = 13;
			this.m.BaseProperties.ActionPoints = 12;
			this.m.BaseProperties.DamageTotalMult = 1.5;
			this.m.Skills.update();
			this.getSprite("miniboss").setBrush("bust_miniboss");
			this.m.Skills.removeByID("racial.champion");
			this.m.Skills.add(this.new("scripts/skills/effects/champion_type_1_effect"));
			this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
			this.addSprite("socket").setBrush("bust_base_beasts");
			local body = this.addSprite("body");
			body.setBrush("bust_direvarg_01_body");

			if (this.Math.rand(0, 100) < 90)
			{
				body.varySaturation(0.2);
			}

			if (this.Math.rand(0, 100) < 90)
			{
				body.varyColor(0.05, 0.05, 0.05);
			}

			local head = this.addSprite("head");
			head.setBrush("bust_direvarg_01_head");
			head.Color = body.Color;
			head.Saturation = body.Saturation;
			local injury = this.addSprite("injury");
			injury.Visible = false;
			injury.setBrush("bust_direvarg_01_injured");
		}
		return true;
	})
});
})
