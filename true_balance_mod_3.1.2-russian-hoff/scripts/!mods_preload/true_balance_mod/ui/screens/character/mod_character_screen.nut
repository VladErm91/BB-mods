::mods_registerMod("mod_character_screen", 1.8, "True Balance Mod Character Screen");
::mods_queue("mod_character_screen", "mod_true_balance", function() {
::mods_hookNewObject("ui/screens/character/character_screen", function(o) 
{
	o.onDismissCharacter = function( _data )
	{
		local bro = this.Tactical.getEntityByID(_data[0]);
		local payCompensation = _data[1];

		if (bro != null)
		{
			this.World.Statistics.getFlags().increment("BrosDismissed");

			if (bro.getSkills().hasSkillOfType(this.Const.SkillType.PermanentInjury) && bro.getBackground().getID() != "background.slave" && bro.getLevel() >= 4)
			{
				this.World.Statistics.getFlags().increment("BrosWithPermanentInjuryDismissed");
			}

			if (payCompensation)
			{
				this.World.Assets.addMoney(-10 * this.Math.max(1, bro.getDaysWithCompany()));

				if (bro.getBackground().getID() == "background.slave")
				{
					local playerRoster = this.World.getPlayerRoster().getAll();

					foreach( other in playerRoster )
					{
						if (bro.getID() == other.getID())
						{
							continue;
						}

						if (other.getBackground().getID() == "background.slave")
						{
							other.improveMood(this.Const.MoodChange.SlaveCompensated, "Рад, что " + bro.getName() + " получил плату за время, проведённое в отряде");
						}
					}
				}
			}
			else if (bro.getBackground().getID() == "background.slave")
			{
			}
			else if (bro.getLevel() >= 11 && !this.World.Statistics.hasNews("dismiss_legend") && this.World.getPlayerRoster().getSize() > 1)
			{
				local news = this.World.Statistics.createNews();
				news.set("Name", bro.getName());
				this.World.Statistics.addNews("dismiss_legend", news);
			}
			else if (bro.getDaysWithCompany() >= 50 && !this.World.Statistics.hasNews("dismiss_veteran") && this.World.getPlayerRoster().getSize() > 1 && this.Math.rand(1, 100) <= 33)
			{
				local news = this.World.Statistics.createNews();
				news.set("Name", bro.getName());
				this.World.Statistics.addNews("dismiss_veteran", news);
			}
			else if (bro.getLevel() >= 3 && bro.getSkills().hasSkillOfType(this.Const.SkillType.PermanentInjury) && !this.World.Statistics.hasNews("dismiss_injured") && this.World.getPlayerRoster().getSize() > 1 && this.Math.rand(1, 100) <= 33)
			{
				local news = this.World.Statistics.createNews();
				news.set("Name", bro.getName());
				this.World.Statistics.addNews("dismiss_injured", news);
			}
			else if (bro.getDaysWithCompany() >= 7)
			{
				local playerRoster = this.World.getPlayerRoster().getAll();

				foreach( other in playerRoster )
				{
					if (bro.getID() == other.getID())
					{
						continue;
					}

					if (bro.getDaysWithCompany() >= 50)
					{
						other.worsenMood(this.Const.MoodChange.VeteranDismissed, "Был выгнан " + bro.getName());
					}
					else
					{
						other.worsenMood(this.Const.MoodChange.BrotherDismissed, "Был выгнан " + bro.getName());
					}
				}
			}

			bro.getItems().transferToStash(this.World.Assets.getStash());
			this.World.getPlayerRoster().remove(bro);
			this.loadData();
			this.World.State.updateTopbarAssets();
		}
	}
});
})
