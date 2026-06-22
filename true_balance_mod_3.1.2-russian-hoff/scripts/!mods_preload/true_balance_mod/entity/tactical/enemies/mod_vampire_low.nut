::mods_registerMod("mod_vampire_low", 1.8, "True Balance Mod Vampire Low");
::mods_queue("mod_vampire_low", "mod_true_balance", function() {
::mods_hookBaseClass("entity/tactical/enemies/vampire", function ( a )
{
	while (!("assignRandomEquipment" in a))
	{
		a = a[a.SuperName];
	}

	local assignRandomEquipment = a.assignRandomEquipment;
	a.assignRandomEquipment <- function()
	{
		assignRandomEquipment();

		if (this.ClassName == "vampire_low")
		{
			this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));

			local r;

		   	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days < 80)
		    {
				r = this.Math.rand(1, 1);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
				}
			}
			else
			{
				r = this.Math.rand(1, 4);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
				}
			}
		}		
	};
});
})