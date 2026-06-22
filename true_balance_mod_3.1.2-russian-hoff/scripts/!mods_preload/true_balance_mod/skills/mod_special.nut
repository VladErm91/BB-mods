::mods_registerMod("mod_special", 1.8, "True Balance Mod Special");
::mods_queue("mod_special", "mod_true_balance", function() {
::mods_hookNewObject("skills/special/double_grip", function(o) 
{
	o.canDoubleGrip = function()
	{
		local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local off = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		return main != null && (off == null || (off != null && (off.getID() == "shield.buckler" || off.getID() == "shield.goblin_light_shield" || off.getID() == "shield.goblin_heavy_shield") && this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)) && main.isDoubleGrippable();
	}

	o.onUpdate = function( _properties )
	{
		if (this.canDoubleGrip())
		{
			local main = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			if (main != null && main.getID() != "weapon.firelance")
			{
				_properties.DamageTotalMult *= 1.25;
			}
			else if (main != null)
			{
				_properties.MeleeDamageMult *= 1.25;
			}
		}
	}
});
})