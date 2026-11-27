var bgGhouls:BGSprite;

function onLoad()
{
	var solid:FlxSprite = new FlxSprite(-500, -1000).makeGraphic(2400, 2000, FlxColor.BLACK);
	solid.scrollFactor.set();
	add(solid);

	var backTrees:BGSprite = new BGSprite('backgrounds/weeb/evil/evil-school-back-trees', -842, -80, 0.5, 0.5);
	backTrees.antialiasing = false;
	backTrees.setScale(6, 6, true);
	add(backTrees);

	var school:BGSprite = new BGSprite('backgrounds/weeb/evil/evil-school', -816, -38, 0.75, 0.75);
	school.antialiasing = false;
	school.setScale(6, 6, true);
	add(school);

	var street:BGSprite = new BGSprite('backgrounds/weeb/evil/evil-school-street', -662, 6, 1, 1);
	street.antialiasing = false;
	street.setScale(6, 6, true);
	add(street);

	var trees:BGSprite = new BGSprite('backgrounds/weeb/evil/evil-school-trees', -662, 6, 1, 1);
	trees.antialiasing = false;
	trees.setScale(6, 6, true);
	add(trees);
	
	if (!ClientPrefs.lowQuality)
	{
		bgGhouls = new BGSprite('backgrounds/weeb/evil/bgGhouls', -650, 260, 1, 1, ['BG freaks glitch instance'], true);
		bgGhouls.setScale(6, 6, true);
		bgGhouls.visible = false;
		bgGhouls.antialiasing = false;
		add(bgGhouls);
	}
}

function onCreatePost()
{
	initScript('data/scripts/pixelUI');
}

function onUpdate(elapsed)
{
	if (!ClientPrefs.lowQuality && bgGhouls.animation.curAnim.finished) bgGhouls.visible = false;
}

function onEvent(eventName, value1, value2)
{
	if (eventName == 'Trigger BG Ghouls')
	{
		bgGhouls.dance(true);
		bgGhouls.visible = true;
	}
}

var a = false;

function onStartCountdown()
{
	if (!a && PlayState.isStoryMode)
	{
		a = true;
		if (Paths.sanitize(PlayState.SONG.song) == 'roses') FlxG.sound.play(Paths.sound('week6/ANGRY'));
		
		camHUD.alpha = 0;
		
		var path = Paths.getPath('data/dialogue/' + songName + '/' + songName + 'Dialogue.txt', null, true);
		dialogueBox = new DialogueBox(false, CoolUtil.coolTextFile(path));
		dialogueBox.scrollFactor.set();
		dialogueBox.camera = camOther;
		dialogueBox.finishThing = startCountdown;
		
		schoolIntro(dialogueBox);
		
		return Function_Stop;
	}
	else if (a)
	{
		FlxTween.tween(camHUD, {alpha: 1}, 2);
	}
}

function schoolIntro(dialogueBox)
{
	inCutscene = true;
	snapCamToPos(600, 550);
	
	var black:FlxSprite = new FlxSprite(-100, -100).makeScaledGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
	black.scrollFactor.set();
	black.cameras = [camHUD];
	add(black);
	
	var red:FlxSprite = new FlxSprite(-100, -100).makeScaledGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
	red.cameras = [camOther];
	red.scrollFactor.set();
	
	var senpaiEvil:FlxSprite = new FlxSprite();
	senpaiEvil.frames = Paths.getSparrowAtlas('backgrounds/weeb/senpaiCrazy');
	senpaiEvil.animation.addByPrefix('idle', 'Senpai Pre Explosion', 24, false);
	senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
	senpaiEvil.scrollFactor.set();
	senpaiEvil.updateHitbox();
	senpaiEvil.screenCenter();
	senpaiEvil.cameras = [camOther];
	senpaiEvil.antialiasing = false;
	senpaiEvil.x += 300;
	
	var songName:String = Paths.sanitize(PlayState.SONG.song);
	if (songName == 'roses' || songName == 'thorns')
	{
		remove(black);
		
		if (songName == 'thorns')
		{
			add(red);
			camHUD.visible = false;
		}
	}
	
	new FlxTimer().start(0.3, function(tmr:FlxTimer) {
		black.alpha -= 0.15;
		
		if (black.alpha > 0)
		{
			tmr.reset(0.3);
		}
		else
		{
			if (dialogueBox != null)
			{
				if (Paths.sanitize(PlayState.SONG.song) == 'thorns')
				{
					add(senpaiEvil);
					senpaiEvil.alpha = 0;
					new FlxTimer().start(0.3, function(swagTimer:FlxTimer) {
						senpaiEvil.alpha += 0.15;
						if (senpaiEvil.alpha < 1)
						{
							swagTimer.reset();
						}
						else
						{
							senpaiEvil.animation.play('idle');
							FlxG.sound.play(Paths.sound('week6/Senpai_Dies'), 1, false, null, true, function() {
								// Just incase...
								senpaiEvil.alpha = 0.001;
								red.alpha = 0.001;
								
								remove(senpaiEvil);
								remove(red);
								camOther.fade(FlxColor.WHITE, 0.01, true, function() {
									add(dialogueBox);
									camHUD.visible = true;
								}, true);
							});
							new FlxTimer().start(3.2, function(deadTime:FlxTimer) {
								camOther.fade(FlxColor.WHITE, 1.6, false);
							});
						}
					});
				}
				else
				{
					add(dialogueBox);
				}
			}
			else startCountdown();
			
			remove(black);
		}
	});
}
