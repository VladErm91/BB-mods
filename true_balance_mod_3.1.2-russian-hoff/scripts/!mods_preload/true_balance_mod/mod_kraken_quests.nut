::mods_registerMod("mod_kraken_quests", 1.8, "True Balance Mod Kraken Quests");
::mods_queue("mod_kraken_quests", "mod_true_balance", function() {
::mods_hookNewObject("events/events/dlc2/location/kraken_cult_enter_event", function(o) 
{
	local onPrepare = o.onPrepare;
	o.onPrepare = function()
	{
		onPrepare();
		
		if (this.m.Hides > 3) this.m.Hides = 3;
		if (this.m.Dust > 3) this.m.Dust = 3;
	}
});
})