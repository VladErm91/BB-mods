::mods_registerMod("mod_terrain", 1.8, "True Balance Mod Terrain");
::mods_queue("mod_terrain", "mod_true_balance", function() {
::mods_hookNewObject("skills/terrain/swamp_effect", function(o) 
{
	o.isHidden = function()
	{
		local actor = this.getContainer().getActor();
		return actor.getSkills().hasSkill("effects.swamps")
	}

	o.onUpdate = function( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.getSkills().hasSkill("effects.swamps"))
		{
			_properties.MeleeDefenseMult *= 0.75;
			_properties.RangedDefenseMult *= 0.75;
			_properties.MeleeSkillMult *= 0.75;
		}
	}
});
})