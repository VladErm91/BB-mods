::mods_registerMod("mod_nomad_tent_city_location", 1.8, "True Balance Mod Nomad Tent City Location");
::mods_queue("mod_nomad_tent_city_location", "mod_true_balance", function() {
::mods_hookExactClass("entity/world/locations/nomad_tent_city_location", function(o) 
{
	o.createDefenders <- function()
	{
		this.location.createDefenders()
		
		local Nomad = {
		ID = this.Const.EntityType.NomadLeader,
		Variant = 1,
		Strength = 30,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/humans/nomad_leader",
		NameList = this.Const.Strings.SouthernNames,
		TitleList = this.Const.Strings.NomadChampionTitles
		}
		
		if (this.World.getTime().Days >= 130)
		{
			this.Const.World.Common.addTroop(this, {
				Type = Nomad
			}, false, 100);
		}
	}
});
})