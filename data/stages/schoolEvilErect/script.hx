var bgGhouls:BGSprite;

function onLoad()
{
	var solid:FlxSprite = new FlxSprite(-500, -1000).makeGraphic(2400, 2000, "#000000");
	solid.scrollFactor.set();
	add(solid);

	var school:FlxSprite = new FlxSprite(-816, -38).loadGraphic(Paths.image("backgrounds/weeb/erect/evil/evil-school-erect"));
	school.setScale(6, 6, true);
	school.zIndex = 20;
	school.scrollFactor.set(0.75, 0.75);
	add(school);

	var backSpike:FlxSprite = new FlxSprite(1416, 464).loadGraphic(Paths.image("backgrounds/weeb/erect/evil/evil-school-erect-back-spike"));
	backSpike.setScale(6, 6, true);
	backSpike.zIndex = 25;
	backSpike.scrollFactor.set(0.85, 0.85);
	add(backSpike);

	var weebBackSpikes:FlxSprite = new FlxSprite(-842, -180).loadGraphic(Paths.image("backgrounds/weeb/erect/evil/evil-school-erect-back-spikes"));
	weebBackSpikes.setScale(6, 6, true);
	weebBackSpikes.zIndex = 15;
	weebBackSpikes.scrollFactor.set(0.5, 0.5);
	add(weebBackSpikes);

	var evilstreet:FlxSprite = new FlxSprite(-662, 6).loadGraphic(Paths.image("backgrounds/weeb/erect/evil/evil-school-erect-street"));
	evilstreet.setScale(6, 6, true);
	evilstreet.zIndex = 30;
	evilstreet.scrollFactor.set(1, 1);
	add(evilstreet);

	bgGhouls = new BGSprite('backgrounds/weeb/evil/bgGhouls', -650, 260, 1, 1, ['BG freaks glitch instance'], false);
	bgGhouls.setScale(6, 6, true);
	bgGhouls.visible = false;
	bgGhouls.zIndex = 35;
	add(bgGhouls);

	for (i in stage.members) i.antialiasing = false;
}

function onCreatePost()
{
	initScript('data/scripts/pixelUI');
}

function onEvent(eventName, value1, value2)
{
	if (eventName == 'Trigger BG Ghouls')
	{
		bgGhouls.dance(true);
		bgGhouls.visible = true;
	}
}

function onUpdate(elapsed)
{
	if (bgGhouls.animation.curAnim.finished) bgGhouls.visible = false;
}
