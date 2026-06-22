::mods_registerMod("mod_barbarians_weapon", 1.8, "True Balance Mod Barbarians Weapon");
::mods_queue("mod_barbarians_weapon", "mod_true_balance", function() {
::mods_hookNewObject("items/weapons/barbarians/claw_club", function(o) 
{
		o.m.Value = 100;
		o.m.Condition = 76.0;
		o.m.ConditionMax = 76.0;
		o.m.StaminaModifier = -8;
		o.m.RegularDamage = 20;
		o.m.RegularDamageMax = 30;
		o.m.ArmorDamageMult = 0.90;
		o.m.DirectDamageMult = 0.4;
		o.m.DirectDamageAdd = 0.1;
});
::mods_hookNewObject("items/weapons/barbarians/rusty_warblade", function(o) 
{
		o.m.Value = 1600;
		o.m.ShieldDamage = 16;
		o.m.Condition = 52.0;
		o.m.ConditionMax = 52.0;
		o.m.StaminaModifier = -18;
		o.m.RegularDamage = 60;
		o.m.RegularDamageMax = 80;
		o.m.ArmorDamageMult = 1.1;
		o.m.DirectDamageAdd = 0.1;
		o.m.DirectDamageMult = 0.25;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local cleave = this.new("scripts/skills/actives/cleave");
		cleave.m.Icon = "skills/active_182.png";
		cleave.m.IconDisabled = "skills/active_182_sw.png";
		cleave.m.Overlay = "active_182";
		cleave.m.FatigueCost = 15;
		this.addSkill(cleave);
		local cleaves = this.new("scripts/skills/actives/decapitate");
		cleaves.m.FatigueCost = 25;
		this.addSkill(cleaves);
	}
});
::mods_hookNewObject("items/weapons/barbarians/two_handed_spiked_mace", function(o) 
{
		o.m.Value = 900;
		o.m.ShieldDamage = 20;
		o.m.Condition = 72.0;
		o.m.ConditionMax = 72.0;
		o.m.StaminaModifier = -14;
		o.m.RegularDamage = 50;
		o.m.RegularDamageMax = 70;
		o.m.ArmorDamageMult = 1.15;
		o.m.DirectDamageMult = 0.4;
		o.m.DirectDamageAdd = 0.1;
		o.m.ChanceToHitHead = 0;

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/cudgel_skill");
		skill.m.Icon = "skills/active_178.png";
		skill.m.IconDisabled = "skills/active_178_sw.png";
		skill.m.Overlay = "active_178";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/strike_down_skill");
		skill.m.Icon = "skills/active_179.png";
		skill.m.IconDisabled = "skills/active_179_sw.png";
		skill.m.Overlay = "active_179";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/split_shield");
		skill.setFatigueCost(skill.getFatigueCostRaw() + 5);
		this.addSkill(skill);
	}
});
})