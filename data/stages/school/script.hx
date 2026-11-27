function onLoad()
{
	GameOverSubstate.deathSoundName = 'fnf_loss_sfx-pixel';
	GameOverSubstate.loopSoundName = 'gameOver-pixel';
	GameOverSubstate.endSoundName = 'gameOverEnd-pixel';
	GameOverSubstate.characterName = 'bf-pixel-dead';
	
	var sky:BGSprite = new BGSprite('backgrounds/weeb/weeb-sky', -626, -78, 0.2, 0.2);
	sky.antialiasing = false;
	sky.setScale(6, 6, true);
	add(sky);

	var backTrees:BGSprite = new BGSprite('backgrounds/weeb/weeb-trees-back', -842, -80, 0.5, 0.5);
	backTrees.antialiasing = false;
	backTrees.setScale(6, 6, true);
	add(backTrees);

	var school:BGSprite = new BGSprite('backgrounds/weeb/weeb-school', -816, -38, 0.75, 0.75);
	school.antialiasing = false;
	school.setScale(6, 6, true);
	add(school);

	var street:BGSprite = new BGSprite('backgrounds/weeb/weeb-street', -662, 6, 1, 1);
	street.antialiasing = false;
	street.setScale(6, 6, true);
	add(street);

	if (!ClientPrefs.lowQuality)
	{
		var treesFG:BGSprite = new BGSprite('backgrounds/weeb/weeb-trees-back', -500, 6, 1, 1);
		treesFG.antialiasing = false;
		treesFG.setScale(6, 6, true);
		add(treesFG);
	}

	var treesBG:FlxSprite = new FlxSprite(-806, -1050);
	treesBG.frames = Paths.getPackerAtlas('backgrounds/weeb/weeb-trees');
	treesBG.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
	treesBG.animation.play('treeLoop');
	treesBG.setScale(6, 6, true);
	treesBG.antialiasing = false;
	add(treesBG);

	if (!ClientPrefs.lowQuality)
	{
		var petals:BGSprite = new BGSprite('backgrounds/weeb/petals', -20, -40, 0.85, 0.85, ['PETALS ALL'], true);
		petals.setScale(6, 6, true);
		petals.antialiasing = false;
		add(petals);
		
		bgGirls = new BackgroundGirls(-646, 222);
		bgGirls.antialiasing = false;
		bgGirls.setScale(6, 6, true);
		add(bgGirls);
	}
}

function onCreatePost()
{
	initScript('data/scripts/pixelUI');
}

function onEvent(eventName, value1, value2)
{
	if (eventName == 'BG Freaks Expression') bgGirls.swapDanceType();
}

function onCountdownTick() if (!ClientPrefs.lowQuality) bgGirls.dance();

function onBeatHit() if (!ClientPrefs.lowQuality) bgGirls.dance();

var a = false;

function onStartCountdown()
{
	if (!a && PlayState.isStoryMode)
	{
		a = true;
		if (Paths.sanitize(PlayState.SONG.song) == 'roses') FlxG.sound.play(Paths.sound('week6/ANGRY'));
		
		camHUD.alpha = 0;
		camGame.flash(FlxColor.BLACK, 1);
		
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
