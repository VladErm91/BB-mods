this.perk_davkul <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.davkul";
		this.m.Name = this.Const.Strings.PerkName.Berserk;
		this.m.Description = this.Const.Strings.PerkDescription.Berserk;
		this.m.Icon = "ui/perks/perk_35.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		local body = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Head);

		if (body != null && head != null && body.getID() == "armor.body.armor_of_davkul" && head.getID() == "armor.head.mask_of_davkul")
		{
			this.getContainer().add(this.new("scripts/skills/effects/davkul_effect"));
		}
		else
		{
			this.m.Container.removeByID("effects.davkul");
		}
	}

});

