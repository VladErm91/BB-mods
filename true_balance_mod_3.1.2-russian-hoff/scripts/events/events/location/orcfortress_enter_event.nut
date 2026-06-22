this.orcfortress_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.orcfortress_enter";
		this.m.Title = "По мере приближения...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_49.png[/img]{Ворота украшены мозаикой из черепов всевозможных созданий, некоторые из которых не знакомы вам. Видно, что неизвестный 'художник' располагал их с несвойственной оркам аккуратностью и трудолюбием. %randombrother% сплевывает с отвращением, но вы чувствуете, что он пытается скрыть страх. Вы слышите перешептывания ваших людей позади.%SPEECH_ON%Мы что и правда собираемся зайти сюда?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Заходим внутрь.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Отступаем.",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_93.png[/img]Ворота не заперты. Украшения на них красноречивее любых замков. Приглашение на бойню. Вы видите громадные фигуры орков, пляшущих воркуг огромного пламени. Их невообразимые песнопения эхом разносятся по округе. Вы разбираете лишь одно слово. Или это имя? %SPEECH_ON%Йуши-Грод. Йуши-Грод. Йуши-Грод.%SPEECH_OFF%Один из орков поднимается и идёт прямо к вам. В его глазах отражается пламя костра, делая его похожим скорее на демона из кошмаров, нежели на привычного вам соперника. Ваши люди обнажают мечи, но орк этого даже не замечает.%SPEECH_ON%Молись%SPEECH_OFF%Произносит он на ломанном людском языке.%SPEECH_ON%Вы в доме Йуши-Грода, владыки драконов.%SPEECH_OFF%В этот момент вы замечаете силуэты ещё более гигантские, нежели орки. Ещё более пугающие, потому что эти звери возвышаются над зеленокожими гигантами, даже лежа. Стальные цепи тянутся от них к трону из костей, на котором восседает вождь орков. Он смотрит прямо на вас и вдруг издаёт боевой клич. Десятки голов оборачиваются к вам. Громадные линдвурмы начинают движение. И в этот момент ворота позади вас захлопываются с глухим грохотом.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "К оружию!",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setAttackable(true);
							this.World.State.getLastLocation().setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getID());
						}

						this.World.Events.showCombatDialog(true, true, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
	}

});

