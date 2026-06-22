::mods_registerMod("mod_civilwar_intro_event", 1.8, "True Balance Mod civilwar_intro_event");
::mods_queue("mod_civilwar_intro_event", "mod_true_balance", function() {
::mods_hookNewObject("events/events/crisis/civilwar_intro_event", function (o)
{
	foreach (screen in o.m.Screens)
	{
		if (screen.ID == "A"){
			screen.start = function(_event)
			{
				this.World.Flags.set("StartCrisisDay", this.World.getTime().Days);
				this.logInfo("Захукен")
			}
		}
	}
});	
})
