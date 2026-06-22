::mods_hookExactClass("states/world_state", function (o)
{
	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();

		::World.createRoster(::TrueBalance.ID);
		local tempPlayer = ::World.getRoster(::TrueBalance.ID).create("scripts/entity/tactical/player");
		local tempBackground = ::new("scripts/skills/backgrounds/character_background");
		tempPlayer.getSkills().add(tempBackground);
		tempPlayer.setHitpoints = function( _hitpoints ) {}
		local rand = ::Math.rand;
		::Math.rand = @(_a, _b) _b;
		tempBackground.buildAttributes();
		::Math.rand = rand;
		::TrueBalance.BaseProperties = ::MSU.Class.OrderedMap();
		::TrueBalance.BaseProperties.Hitpoints <- tempPlayer.getBaseProperties().Hitpoints,
		::TrueBalance.BaseProperties.MeleeSkill <- tempPlayer.getBaseProperties().MeleeSkill,
		::TrueBalance.BaseProperties.Stamina <- tempPlayer.getBaseProperties().Stamina,
		::TrueBalance.BaseProperties.RangedSkill <- tempPlayer.getBaseProperties().RangedSkill,
		::TrueBalance.BaseProperties.Bravery <- tempPlayer.getBaseProperties().Bravery,
		::TrueBalance.BaseProperties.MeleeDefense <- tempPlayer.getBaseProperties().MeleeDefense,
		::TrueBalance.BaseProperties.Initiative <- tempPlayer.getBaseProperties().Initiative
		::TrueBalance.BaseProperties.RangedDefense <- tempPlayer.getBaseProperties().RangedDefense,
		::World.deleteRoster(::TrueBalance.ID);
	}
});
