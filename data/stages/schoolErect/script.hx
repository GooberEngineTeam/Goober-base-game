import funkin.game.shaders.DropShadowShader;

using StringTools;

function onLoad()
{
	var sky:BGSprite = new BGSprite('backgrounds/weeb/erect/weeb-sky', -626, -78, 0.2, 0.2);
	sky.antialiasing = false;
	sky.setScale(6, 6, true);
	add(sky);

	var backTrees:BGSprite = new BGSprite('backgrounds/weeb/erect/weeb-trees-back', -842, -80, 0.5, 0.5);
	backTrees.antialiasing = false;
	backTrees.setScale(6, 6, true);
	add(backTrees);

	var school:BGSprite = new BGSprite('backgrounds/weeb/erect/weeb-school', -816, -38, 0.75, 0.75);
	school.antialiasing = false;
	school.setScale(6, 6, true);
	add(school);

	var street:BGSprite = new BGSprite('backgrounds/weeb/erect/weeb-street', -662, 6, 1, 1);
	street.antialiasing = false;
	street.setScale(6, 6, true);
	add(street);

	if (!ClientPrefs.lowQuality)
	{
		var treesFG:BGSprite = new BGSprite('backgrounds/weeb/erect/weeb-trees-back', -500, 6, 1, 1);
		treesFG.antialiasing = false;
		treesFG.setScale(6, 6, true);
		add(treesFG);
	}

	var treesBG:FlxSprite = new FlxSprite(-806, -1050);
	treesBG.frames = Paths.getPackerAtlas('backgrounds/weeb/erect/weeb-trees');
	treesBG.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
	treesBG.animation.play('treeLoop');
	treesBG.setScale(6, 6, true);
	treesBG.antialiasing = false;
	add(treesBG);

	if (!ClientPrefs.lowQuality)
	{
		var petals:BGSprite = new BGSprite('backgrounds/weeb/erect/petals', -20, -40, 0.85, 0.85, ['PETALS ALL'], true);
		petals.setScale(6, 6, true);
		petals.antialiasing = false;
		add(petals);
	}
}

function onCreatePost()
{
	initScript('data/scripts/pixelUI');

	if (boyfriend.curCharacter == "pico-pixel")
	{
		GameOverSubstate.deathSoundName = 'fnf_loss_sfx-pixel-pico';
		GameOverSubstate.loopSoundName = 'gameOver-pixel-pico';
		GameOverSubstate.endSoundName = 'gameOverEnd-pixel-pico';
		GameOverSubstate.characterName = 'pico-pixel';
	}
	else
	{
		GameOverSubstate.deathSoundName = 'fnf_loss_sfx-pixel';
		GameOverSubstate.loopSoundName = 'gameOver-pixel';
		GameOverSubstate.endSoundName = 'gameOverEnd-pixel';
		GameOverSubstate.characterName = 'bf-pixel-dead';
	}

	addShaderToObject(dad);
	addShaderToObject(boyfriend);
	addShaderToObject(gf);
}

function addShaderToObject(char)
{
	var rim = new DropShadowShader();
	rim.setAdjustColor(-66, -10, 24, -23);
	rim.color = 0xFF52351d;
	rim.antialiasAmt = 0;
	rim.attachedSprite = char;
	rim.distance = 5;

	switch (char)
	{
		case boyfriend:
			rim.angle = 90;
			boyfriend.shader = rim;

			if (boyfriend.curCharacter == 'pico-pixel') rim.loadAltMask(Paths.image('backgrounds/weeb/erect/masks/picoPixel_mask'));
			else rim.loadAltMask(Paths.image('backgrounds/weeb/erect/masks/bfPixel_mask'));

			rim.maskThreshold = 1;
			rim.useAltMask = true;

			boyfriend.animation.onFrameChange.add(function()
			{
				rim.updateFrameInfo(boyfriend.frame);
			});

		case gf:
			rim.setAdjustColor(-42, -10, 5, -25);
			rim.angle = 90;
			gf.shader = rim;
			rim.distance = 3;
			rim.threshold = 0.3;

			if (gf.curCharacter == 'nene-pixel') rim.loadAltMask(Paths.image('backgrounds/weeb/erect/masks/nenePixel_mask'));
			else rim.loadAltMask(Paths.image('backgrounds/weeb/erect/masks/gfPixel_mask'));

			rim.maskThreshold = 1;
			rim.useAltMask = true;

			gf.animation.onFrameChange.add(function()
			{
				rim.updateFrameInfo(gf.frame);
			});

		case dad:
			rim.angle = 90;
			dad.shader = rim;

			rim.loadAltMask(Paths.image('backgrounds/weeb/erect/masks/senpai_mask'));
			rim.maskThreshold = 1;
			rim.useAltMask = true;

			dad.animation.onFrameChange.add(function()
			{
				if (dad != null) rim.updateFrameInfo(dad.frame);
			});
	}
}
