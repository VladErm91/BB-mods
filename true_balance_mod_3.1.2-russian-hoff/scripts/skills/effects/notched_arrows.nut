this.notched_arrows <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.notched_arrows";
		this.m.Name = "Зазубренные стрелы";
		this.m.Icon = "ui/perks/strely.png";
		this.m.Description = "У этого персонажа закончились боеприпасы для экипированного в настоящее время оружия дальнего боя!";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect | this.Const.SkillType.Alert;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
	}

	function isHidden()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		this.m.IsHidden = false;

		if (item != null && item.isItemType(this.Const.Items.ItemType.RangedWeapon) && (item.getAmmoID() != "" || item.isItemType(this.Const.Items.ItemType.Ammo)))
		{
			if (item.getAmmoMax() == 0)
			{
				local ammo = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

				if (ammo == null || ammo.getID() != item.getAmmoID() || ammo.getAmmo() == 0)
				{
					this.m.IsHidden = true;
				}
			}
			else if (item.getAmmo() == 0)
			{
				this.m.IsHidden = true;
			}
		}

		return this.m.IsHidden;
	}

});

