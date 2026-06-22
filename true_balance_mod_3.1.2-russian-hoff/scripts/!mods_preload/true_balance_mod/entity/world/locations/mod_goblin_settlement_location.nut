::mods_registerMod("mod_goblin_settlement_location", 1.8, "True Balance Mod Goblin Settlement Location");
::mods_queue("mod_goblin_settlement_location", "mod_true_balance", function() {
::mods_hookExactClass("entity/world/locations/goblin_settlement_location", function(o) 
{
	o.createDefenders <- function()
	{
		this.location.createDefenders()
		
		local Goblin = {
		ID = this.Const.EntityType.GoblinFighter,
		Variant = 1,
		Strength = 18,
		Cost = 15,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/goblin_fighter",
		NameList = this.Const.Strings.GoblinNames,
		TitleList = this.Const.Strings.GoblinTitles
		}

		if (this.World.getTime().Days >= 100)
		{
			this.Const.World.Common.addTroop(this, {
				Type = Goblin
			}, false, 100);
		}
	}
});
})