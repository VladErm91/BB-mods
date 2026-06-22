::mods_registerMod("mod_blueprint", 1.8, "True Balance Mod Blueprint");
::mods_queue("mod_blueprint", "mod_true_balance", function() {
::mods_hookBaseClass("crafting/blueprint", function ( a )
{
	a.craft <- function()
	{
		if (!this.isQualified())
		{
			return;
		}

		this.updateAchievement("IMadeThis", 1, 1);
		local stash = this.World.Assets.getStash();
		local hasAlchemist = this.World.Retinue.hasFollower("follower.alchemist");

		foreach( c in this.m.PreviewComponents )
		{
			for( local j = 0; j < c.Num; j = ++j )
			{
				local item = stash.getItemByID(c.Instance.getID());
				item.setMagicNumber(this.Math.rand(1, 100));

				if (!hasAlchemist || item.getMagicNumber() > 25)
				{
					stash.remove(item);
				}
			}
		}
		++this.m.TimesCrafted;
		this.onCraft(stash);
	}
});
})