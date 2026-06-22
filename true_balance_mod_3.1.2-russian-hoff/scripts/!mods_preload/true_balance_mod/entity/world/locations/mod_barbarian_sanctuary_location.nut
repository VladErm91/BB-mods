::mods_registerMod("mod_barbarian_sanctuary_location", 1.8, "True Balance Mod Barbarian Sanctuary Location");
::mods_queue("mod_barbarian_sanctuary_location", "mod_true_balance", function() {
::mods_hookExactClass("entity/world/locations/barbarian_sanctuary_location", function(o) 
{
	o.createDefenders <- function()
	{
		this.location.createDefenders()
		
		local Barbarian = {
		ID = this.Const.EntityType.BarbarianChampion,
		Variant = 1,
		Strength = 35,
		Cost = 35,
		Row = 0,
		Script = "scripts/entity/tactical/humans/barbarian_champion",
		NameList = this.Const.Strings.BarbarianNames,
		TitleList = this.Const.Strings.BarbarianTitles
		}
		
		if (this.World.getTime().Days >= 130)
		{
			this.Const.World.Common.addTroop(this, {
				Type = Barbarian
			}, false, 100);
		}
	}
});
})