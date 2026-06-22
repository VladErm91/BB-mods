this.perk_simple_weapon <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.simple_weapon";
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
		local actor = this.getContainer().getActor();

		if (actor.getSkills().hasSkill("perk.fast_adaption"))
		{
			local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (item != null && (item.getID() == "weapon.butchers_cleaver" || item.getID() == "weapon.hatchet" || item.getID() == "weapon.militia_spear" || item.getID() == "weapon.pickaxe" || item.getID() == "weapon.pitchfork" || item.getID() == "weapon.wooden_stick" || item.getID() == "weapon.woodcutters_axe" || item.getID() == "weapon.wooden_flail" || item.getID() == "weapon.shortsword" || item.getID() == "weapon.saif" || item.getID() == "weapon.bludgeon" || item.getID() == "weapon.nomad_mace" || item.getID() == "weapon.ancient_spear" || item.getID() == "weapon.claw_club" || item.getID() == "weapon.antler_cleaver" || item.getID() == "weapon.falx"))
			{
				_properties.MeleeSkill += 5;
			}
		}
	}

});

