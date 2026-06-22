::mods_registerMod("mod_lindwurm", 1.8, "True Balance Mod Lindwurm");
::mods_queue("mod_lindwurm", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/actor", function ( a )
{
	while (!("onDeath" in a))
	{
		a = a[a.SuperName];
	}
	local onDeath = a.onDeath;
	a.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		onDeath( _killer, _skill, _tile, _fatalityType );

		if (this.ClassName == "lindwurm")
		{
			if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
			{
				local loots = this.new("scripts/items/loot/lindwurm_hoard_item");
				loots.drop(_tile);
			}	
		}	
	};
});		
})