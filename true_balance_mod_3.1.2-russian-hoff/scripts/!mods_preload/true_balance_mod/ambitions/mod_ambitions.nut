::mods_registerMod("mod_ambitions", 1.8, "True Balance Mod Ambitions");
::mods_queue("mod_ambitions", "mod_true_balance", function() {
::mods_hookNewObject("ambitions/ambitions/ranged_mastery_ambition", function(o) 
{
o.m.ButtonText = "Отряду не хватает умелых лучников, это сужает наши тактические возможности.\nНам нужно три бойца, что будут сеять смерть издалека!";
o.m.UIText = "Трое должны стать мастерами лука/арбалета/метательного";
o.m.TooltipText = "Трое ваших бойцов должны изучить навык 'Мастер лука/арбалета/метательного'.";
	o.getBrosWithMastery = function()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local count = 0;

		foreach( bro in brothers )
		{
			local p = bro.getCurrentProperties();

			if (p.IsSpecializedInBows)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInCrossbows)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInThrowing)
			{
				count = ++count;
			}
		}

		return count;
	}
});
})
