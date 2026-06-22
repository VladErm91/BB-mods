::mods_registerMod("mod_item", 1.8, "True Balance Mod Item");
::mods_queue("mod_item", "mod_true_balance", function() {
::mods_hookBaseClass("items/item", function (o)
{
	::mods_override (o[o.SuperName], "onEquip", function()
	{
		if (this.m.Container != null && this.m.Container.getActor() != null && !this.isKindOf(this.getContainer().getActor().get(), "zombie_player"))
		{
			this.m.LastEquippedByFaction = this.m.Container.getActor().getFaction();
		}
		
		if (this.m.Container != null && this.m.Container.getActor() != null && this.m.Container.getActor().getSkills().hasSkill("actives.remove_quick_hands"))
		{
			this.m.Container.getActor().getSkills().add(this.new("scripts/skills/effects/quick_hands_effect"));
		}
		else if (this.m.Container != null && this.m.Container.getActor() != null && !this.m.Container.getActor().getSkills().hasSkill("actives.remove_quick_hands") && this.m.Container.getActor().getSkills().hasSkill("effects.quick_hands"))
		{
			this.m.Container.getActor().getSkills().removeByID("effects.quick_hands");
		}

	})
});
})
