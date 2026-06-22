::mods_registerMod("mod_cultist_origin_sacrifice_event", 1.8, "True Balance Mod Cultist Origin Sacrifice Event");
::mods_queue("mod_cultist_origin_sacrifice_event", "mod_true_balance", function() {
::mods_hookNewObject("events/events/dlc4/cultist_origin_sacrifice_event", function (o)
{
	foreach (screen in o.m.Screens)
	{
		if (screen.ID == "B"){
			screen.start = function(_event){
				this.Characters.push(_event.m.Sacrifice.getImagePath());
				local dead = _event.m.Sacrifice;
				local fallen = {
					Name = dead.getName(),
					Time = this.World.getTime().Days,
					TimeWithCompany = this.Math.max(1, dead.getDaysWithCompany()),
					Kills = dead.getLifetimeStats().Kills,
					Battles = dead.getLifetimeStats().Battles,
					KilledBy = "Принесён в жертву Давкулу",
					Expendable = dead.getBackground().getID() == "background.slave"
				};
				this.World.Statistics.addFallen(fallen);
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Sacrifice.getName() + " скончался"
				});
				_event.m.Sacrifice.getItems().transferToStash(this.World.Assets.getStash());
				this.World.getPlayerRoster().remove(_event.m.Sacrifice);
				local brothers = this.World.getPlayerRoster().getAll();
				local hasProphet = false;

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasSkill("trait.cultist_prophet"))
					{
						hasProphet = true;
						break;
					}
				}

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
					{
						bro.improveMood(2.0, "Восславил Давкула");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}

						for( ; this.Math.rand(1, 100) > 1;  )
						{
						}

						local skills = bro.getSkills();
						local skill;

						if (skills.hasSkill("trait.cultist_prophet"))
						{
							continue;
						}
						else if (skills.hasSkill("trait.cultist_chosen") && this.Math.rand(1, 100) > 70)
						{
							if (hasProphet)
							{
								continue;
							}

							hasProphet = true;
							this.updateAchievement("VoiceOfDavkul", 1, 1);
							skills.removeByID("trait.cultist_chosen");
							skill = this.new("scripts/skills/actives/voice_of_davkul_skill");
							skills.add(skill);
							skill = this.new("scripts/skills/traits/cultist_prophet_trait");
							skills.add(skill);
						}
						else if (skills.hasSkill("trait.cultist_disciple") && this.Math.rand(1, 100) > 60)
						{
							skills.removeByID("trait.cultist_disciple");
							skill = this.new("scripts/skills/traits/cultist_chosen_trait");
							skills.add(skill);
						}
						else if (skills.hasSkill("trait.cultist_acolyte") && this.Math.rand(1, 100) > 50)
						{
							skills.removeByID("trait.cultist_acolyte");
							skill = this.new("scripts/skills/traits/cultist_disciple_trait");
							skills.add(skill);
						}
						else if (skills.hasSkill("trait.cultist_zealot") && this.Math.rand(1, 100) > 40)
						{
							skills.removeByID("trait.cultist_zealot");
							skill = this.new("scripts/skills/traits/cultist_acolyte_trait");
							skills.add(skill);
						}
						else if (skills.hasSkill("trait.cultist_fanatic") && this.Math.rand(1, 100) > 30)
						{
							skills.removeByID("trait.cultist_fanatic");
							skill = this.new("scripts/skills/traits/cultist_zealot_trait");
							skills.add(skill);
						}
						else if (!skills.hasSkill("trait.cultist_chosen") && !skills.hasSkill("trait.cultist_disciple") && !skills.hasSkill("trait.cultist_acolyte") && !skills.hasSkill("trait.cultist_zealot") && !skills.hasSkill("trait.cultist_fanatic") && this.Math.rand(1, 100) > 20)
						{
							skill = this.new("scripts/skills/traits/cultist_fanatic_trait");
							skills.add(skill);
						}

						if (skill != null)
						{
							this.List.push({
								id = 10,
								icon = skill.getIcon(),
								text = bro.getName() + " теперь " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
							});
						}
					}
					else if (!bro.getSkills().hasSkill("trait.mad"))
					{
						bro.worsenMood(4.0, "В ужасе от то, что в жертву был принесён " + _event.m.Sacrifice.getName());

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}
		}
	}
});	
})
