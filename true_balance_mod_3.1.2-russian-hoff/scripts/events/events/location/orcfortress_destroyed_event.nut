this.orcfortress_destroyed_event <- this.inherit("scripts/events/event", {
	m = {
		Brother = null
	},
	function create()
	{
		this.m.ID = "event.location.orcfortress_destroyed";
		this.m.Title = "После битвы";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_101.png[/img]{Тела орков и линдвурмов удивительно похожи. Раньше вы не замечали этого, так как никогда не бились против обоих одновременно. Огромные зеленые твари, что способны разорвать человека пополам в многвение ока. Вы до сих пор не понимаете как, но вы победили.\n\nЯдовитая кровь устрашающих ящеров всё ещё шипит под ногами, разъедая дерево и металл. Стараясь избегать кислотных брызг скорее по-привычке, ведь все доспехи и так пришли в негодность, вы ступаете по телам орков и подходите к костяному трону. В последние секунды жизни вождя орков сумел добраться сюда и теперь повис на символе своей власти, уцепившись одной рукой за стальной поводок дракона. Вторая его рука вцепилась в необычный меч. К нему не подобраться, поэтому вы пытаетесь спихнуть вождя ногой, но чёртова туша слишком тяжёлая. Вам понадобилась помощь ещё трех человек, прежде чем вы смогли отпихнуть гиганта в сторону. Теперь вы можете разглядеть клинок. Рукоять, богато украшенная неизвестными, пылающими кристаллами и лезвие, густо залитое кровью. Вы собиратесь было разжать руку орка, чтобы извлечь оружие, но вспомнив о предыдущих неуклюжих попытках, решаете не давать вашим людям лишних поводов для шуток и подзываете наёмника. Он достаёт свой меч - пара ударов и вождь лишается руки, а %brother% берётся за лезвие освободившегося оружия, но через секунду с воплем отшвыривает клинок - его рука объята пламенем. И не только рука - сам клинок вспыхнул в мновение ока, обжигая тела вокруг. Пламя быстро угасает и вы, обернув руку мокрой тряпкой осторожно поднимаете опасное оружие. Через мгновение драгоценности на клинке снова загораются алым светом, а сам клинок обуревает пламя. Ваши люди отшатываются от нахлынувшего жара, но, как ни странно, вы не ощущаете его. Магия клинка защищает своего владельца.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Такое оружие нам пригодится.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brother.getImagePath());
				local injury = _event.m.Brother.addInjury(this.Const.Injury.BurningHand);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Brother.getName() + " получает травму " + injury.getNameOnly()
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local brother_candidates = [];
		foreach( bro in brothers )
		{
			brother_candidates.push(bro);
		}
		this.m.Brother = brother_candidates[this.Math.rand(0, brother_candidates.len() - 1)];
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"brother",
			this.m.Brother.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Brother = null;
	}

});

