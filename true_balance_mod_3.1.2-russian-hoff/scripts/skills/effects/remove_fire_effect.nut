this.remove_fire_effect <- this.inherit("scripts/skills/skill", {
	m = {
		FireTiles = [],
		Delay = 2
	},
	function create()
	{
		this.m.ID = "effects.remove_fire";
		this.m.Name = "Жажда крови удовлетворена";
		this.m.Icon = "skills/status_effect_34.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function onTurnStart()
	{
		if (--this.m.Delay <= 0)
		{
			foreach(tile in this.m.FireTiles)
  			{
    			this.Tactical.Entities.removeTileEffect(tile)
  			}

 			this.m.IsGarbage = true;
		}
		else
		{
 		}
	}
});

