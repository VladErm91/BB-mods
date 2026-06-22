::mods_hookNewObjectOnce("ui/global/data_helper", function(o)
{
	local convertEntityHireInformationToUIData = o.convertEntityHireInformationToUIData;
	o.convertEntityHireInformationToUIData = function( _entity )
	{
		local ret = convertEntityHireInformationToUIData(_entity);

		ret.Properties <- {};
		local backgroundProperties = _entity.getSkills().getAllSkillsOfType(::Const.SkillType.Background)[0].onChangeAttributes();

		foreach (ID, property in ::TrueBalance.BaseProperties)
		{
			ret.Properties[ID] <- array(1);
			ret.Properties[ID][0] = _entity.getBaseProperties()[ID];
		}
		return ret;
	}
})
