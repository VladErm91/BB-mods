this.marksman_vision_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.marksman_vision";
		this.m.Name = "Жажда крови удовлетворена";
		this.m.Icon = "skills/status_effect_34.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		local items = this.getContainer().getActor().getItems();
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (main != null && (main.getID() == "weapon.crossbow" || main.getID() == "weapon.light_crossbow"))
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInCrossbows)
			{
				_properties.Vision -= 1;
			}
		}
	}
});

