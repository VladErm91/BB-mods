::mods_registerMod("mod_retinue", 1.8, "True Balance Mod Retinue");
::mods_queue("mod_retinue", "mod_true_balance", function() {
local gt = this.getroottable();
gt.Const.FollowerSlotRequirements <- [
	0, //4
	6,
	8,
	10,
	12,
	14
];::mods_hookNewObject("retinue/followers/alchemist_follower", function(o) 
{
	o.onEvaluate = function()
	{
		this.m.Requirements[0].Text = "Создать " + this.Math.min(10, this.World.Statistics.getFlags().getAsInt("ItemsCrafted")) + "/5 вещей у скорняка";

		if (this.World.Statistics.getFlags().getAsInt("ItemsCrafted") >= 5)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}
});
::mods_hookNewObject("retinue/followers/cook_follower", function(o) 
{
	o.onEvaluate = function()
	{
		local uniqueProvisions = this.getAmountOfUniqueProvisions();
		this.m.Requirements[0].Text = "Иметь " + this.Math.min(6, uniqueProvisions) + "/6 разных видов провизии";

		if (uniqueProvisions >= 6)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}
});
::mods_hookNewObject("retinue/followers/agent_follower", function(o) 
{
	o.m.Cost = 200; //4000
	o.onEvaluate <- function() { this.m.Requirements[0].IsSatisfied = true; return; }
});
::mods_hookNewObject("retinue/followers/drill_sergeant_follower", function(o) 
{
		o.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Отправить в отставку любого бойца 4-го уровня с увечьем, кроме непрощённого"
			}
		];
});
::mods_hookNewObject("retinue/followers/brigand_follower", function(o) 
{
		o.m.Description = "Возможно, сейчас этот разбойник стар и слаб, но когда-то его имени боялись по всему миру. В обмен на горячую еду он с радостью поделится с вами тем, что узнает от своих знакомых о встречных караванах. Кроме того, бандиты примкнут к вам с гораздо большей готовностью.";
		o.m.Effects = [
			"Некоторые караваны видны в любое время, даже если они находятся вне вашего поля зрения. Позволяет собирать больше добычи."
			"Наёмники с предысторией разбойник встречаются чаще, и их найм обходится на 20% дешевле"
		];
});
::mods_hookNewObject("retinue/followers/quartermaster_follower", function(o) 
{
		o.m.Effects = [
			"Количество переносимых боеприпасов увеличивается на 100"
			"Увеличивается количество товаров на рынках"
			"Количество переносимых медикаментов, инструментов и материалов увеличивается на 50"
		];
});
::mods_hookNewObject("retinue/followers/bounty_hunter_follower", function(o) 
{
	o.onUpdate = function()
	{
		this.World.Assets.m.ChampionChanceAdditional = this.World.Assets.m.ChampionChanceAdditional + 3;
	}
});
})
