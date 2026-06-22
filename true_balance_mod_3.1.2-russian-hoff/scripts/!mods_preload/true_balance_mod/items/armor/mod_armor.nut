::mods_registerMod("mod_armor", 1.8, "True Balance Mod Armor");
::mods_queue("mod_armor", "mod_true_balance", function() {
::mods_hookNewObject("items/armor/basic_mail_shirt", function(o) 
{
		o.m.Value = 405;
		o.m.Condition = 115;
		o.m.ConditionMax = 115;
		o.m.StaminaModifier = -12;
});
::mods_hookNewObject("items/armor/coat_of_plates", function(o) 
{
		o.m.Value = 6300;
		o.m.Condition = 320;
		o.m.ConditionMax = 320;
		o.m.StaminaModifier = -42;
});
::mods_hookNewObject("items/armor/coat_of_scales", function(o) 
{
		o.m.Value = 5400;
		o.m.Condition = 300;
		o.m.ConditionMax = 300;
		o.m.StaminaModifier = -38;
});
::mods_hookNewObject("items/armor/decayed_coat_of_plates", function(o) 
{
		o.m.Value = 2600;
		o.m.Condition = 260;
		o.m.ConditionMax = 260;
		o.m.StaminaModifier = -42;
});
::mods_hookNewObject("items/armor/decayed_coat_of_scales", function(o) 
{
		o.m.Value = 1700;
		o.m.Condition = 240;
		o.m.ConditionMax = 240;
		o.m.StaminaModifier = -36;
});
::mods_hookNewObject("items/armor/decayed_reinforced_mail_hauberk", function(o) 
{
		o.m.Value = 900;
		o.m.Condition = 170;
		o.m.ConditionMax = 170;
		o.m.StaminaModifier = -26;
});
::mods_hookNewObject("items/armor/footman_armor", function(o) 
{
		o.m.Value = 1440;
		o.m.Condition = 190;
		o.m.ConditionMax = 190;
		o.m.StaminaModifier = -24;
});
::mods_hookNewObject("items/armor/heavy_lamellar_armor", function(o) 
{
		o.m.Value = 4500;
		o.m.Condition = 285;
		o.m.ConditionMax = 285;
		o.m.StaminaModifier = -40;
});
::mods_hookNewObject("items/armor/heraldic_mail", function(o) 
{
		o.m.Value = 2250;
		o.m.Condition = 185;
		o.m.ConditionMax = 185;
		o.m.StaminaModifier = -18;
});
::mods_hookNewObject("items/armor/lamellar_harness", function(o) 
{
		o.m.Value = 2700;
		o.m.Condition = 230;
		o.m.ConditionMax = 230;
		o.m.StaminaModifier = -30;
});
::mods_hookNewObject("items/armor/leather_lamellar", function(o) 
{
		o.m.Value = 270;
		o.m.Condition = 95;
		o.m.ConditionMax = 95;
		o.m.StaminaModifier = -10;
});
::mods_hookNewObject("items/armor/leather_scale_armor", function(o) 
{
		o.m.Value = 720;
		o.m.Condition = 140;
		o.m.ConditionMax = 140;
		o.m.StaminaModifier = -16;
});
::mods_hookNewObject("items/armor/light_scale_armor", function(o) 
{
		o.m.Value = 1170;
		o.m.Condition = 170;
		o.m.ConditionMax = 170;
		o.m.StaminaModifier = -21;
});
::mods_hookNewObject("items/armor/mail_hauberk", function(o) 
{
		o.m.Value = 900;
		o.m.Condition = 150;
		o.m.ConditionMax = 150;
		o.m.StaminaModifier = -18;
});
::mods_hookNewObject("items/armor/mail_shirt", function(o) 
{
		o.m.Value = 585;
		o.m.Condition = 130;
		o.m.ConditionMax = 130;
		o.m.StaminaModifier = -14;
});
::mods_hookNewObject("items/armor/noble_mail_armor", function(o) 
{
		o.m.Value = 2250;
		o.m.Condition = 160;
		o.m.ConditionMax = 160;
		o.m.StaminaModifier = -15;
});
::mods_hookNewObject("items/armor/reinforced_mail_hauberk", function(o) 
{
		o.m.Value = 1800;
		o.m.Condition = 210;
		o.m.ConditionMax = 210;
		o.m.StaminaModifier = -26;
});
::mods_hookNewObject("items/armor/scale_armor", function(o) 
{
		o.m.Value = 3600;
		o.m.Condition = 240;
		o.m.ConditionMax = 240;
		o.m.StaminaModifier = -28;
});
::mods_hookNewObject("items/armor/sellsword_armor", function(o) 
{
		o.m.Value = 4050;
		o.m.Condition = 260;
		o.m.ConditionMax = 260;
		o.m.StaminaModifier = -32;
});
::mods_hookNewObject("items/armor/ancient/ancient_plate_harness", function(o) 
{
		o.m.Value = 2000;
		o.m.Condition = 180;
		o.m.ConditionMax = 180;
		o.m.StaminaModifier = -23;
});
::mods_hookNewObject("items/armor/ancient/ancient_plated_mail_hauberk", function(o) 
{
		o.m.Value = 1600;
		o.m.Condition = 160;
		o.m.ConditionMax = 160;
		o.m.StaminaModifier = -21;
});
::mods_hookNewObject("items/armor/ancient/ancient_plated_scale_hauberk", function(o) 
{
		o.m.Value = 2200;
		o.m.Condition = 190;
		o.m.ConditionMax = 190;
		o.m.StaminaModifier = -24;
});
::mods_hookNewObject("items/armor/ancient/ancient_scale_coat", function(o) 
{
		o.m.Value = 1800;
		o.m.Condition = 170;
		o.m.ConditionMax = 170;
		o.m.StaminaModifier = -22;
});
::mods_hookNewObject("items/armor/named/named_armor", function(o) 
{
	o.randomizeValues = function()
	{
		this.m.StaminaModifier = this.Math.min(-10, this.m.StaminaModifier + this.Math.rand(3, 9));
		this.m.Condition = this.Math.floor(this.m.Condition * this.Math.rand(110, 125) * 0.01) * 1.0;
		this.m.ConditionMax = this.m.Condition;
	}
});
::mods_hookNewObject("items/armor/named/named_noble_mail_armor", function(o) 
{
		o.m.Condition = this.Math.floor(160 * this.Math.rand(117, 133) * 0.01) * 1.0;
		o.m.ConditionMax = o.m.Condition;
		o.m.StaminaModifier =  this.Math.min(-10, -18 + this.Math.rand(5, 8));;
});
::mods_hookNewObject("items/armor/named/blue_studded_mail_armor", function(o) 
{
		o.m.Condition = this.Math.floor(150 * this.Math.rand(110, 125) * 0.01) * 1.0;
		o.m.ConditionMax = o.m.Condition;
		o.m.StaminaModifier =  this.Math.min(-10, -18 + this.Math.rand(4, 9));;
});
::mods_hookNewObject("items/armor/oriental/assassin_robe", function(o) 
{
		o.m.Value = 1860;
		o.m.Condition = 120;
		o.m.ConditionMax = 120;
		o.m.StaminaModifier = -9;
});
::mods_hookNewObject("items/armor/oriental/mail_and_lamellar_plating", function(o) 
{
		o.m.Value = 1350;
		o.m.Condition = 180;
		o.m.ConditionMax = 180;
		o.m.StaminaModifier = -22;
});
::mods_hookNewObject("items/armor/oriental/padded_mail_and_lamellar_hauberk", function(o) 
{
		o.m.Value = 5040;
		o.m.Condition = 290;
		o.m.ConditionMax = 290;
		o.m.StaminaModifier = -36;
});
::mods_hookNewObject("items/armor/oriental/southern_long_mail_with_padding", function(o) 
{
		o.m.Value = 1620;
		o.m.Condition = 200;
		o.m.ConditionMax = 200;
		o.m.StaminaModifier = -25;
});
::mods_hookNewObject("items/armor/barbarians/rugged_scale_armor", function(o) 
{
		o.m.StaminaModifier = -17;
});
::mods_hookNewObject("items/armor/barbarians/rugged_scale_armor", function(o) 
{
		o.m.StaminaModifier = -22;
});
})