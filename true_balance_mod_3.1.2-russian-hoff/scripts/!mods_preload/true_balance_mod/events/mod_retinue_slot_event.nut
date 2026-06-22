::mods_registerMod("mod_retinue_slot_event", 1.8, "True Balance Mod Retinue Slot Event");
::mods_queue("mod_retinue_slot_event", "mod_true_balance", function() {
::mods_hookNewObject("events/events/special/retinue_slot_event", function (o)
{
o.m.Cooldown <- 999999.0 * this.World.getTime().SecondsPerDay;
});	
})