::mods_registerMod("mod_holywar_intro_south_event", 1.8, "True Balance Mod holywar_intro_south_event");
::mods_queue("mod_holywar_intro_south_event", "mod_true_balance", function() {
::mods_hookNewObject("events/events/dlc6/crisis/holywar_intro_south_event", function (o)
{
	foreach (screen in o.m.Screens)
	{
		if (screen.ID == "A"){
			screen.start = function(_event)
			{
				this.World.Flags.set("StartCrisisDay", this.World.getTime().Days);
			}
		}
	}
});	
})