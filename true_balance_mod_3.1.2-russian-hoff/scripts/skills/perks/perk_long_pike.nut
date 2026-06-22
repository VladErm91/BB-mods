this.perk_long_pike <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.long_pike";
		this.m.Name = this.Const.Strings.PerkName.Berserk;
		this.m.Description = this.Const.Strings.PerkDescription.Berserk;
		this.m.Icon = "ui/perks/perk_35.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onAfterUpdate( _properties )
	{
		local items = this.getContainer().getActor().getItems();
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && main != null && (main.getID() == "weapon.pike" || main.getID() == "weapon.bladed_pike" || main.getID() == "weapon.broken_bladed_pike" || main.getID() == "weapon.named_pike" || main.getID() == "weapon.named_bladed_pike"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/long_impale"));
		}
		else
		{
			this.m.Container.removeByID("actives.long_impale");
		}
	}

});

