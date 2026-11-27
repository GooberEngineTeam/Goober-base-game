var vcamGroup:FlxTypedGroup;
var vCam:FlxCamera;

function onCreatePost()
{
    vCam = new FlxCamera();
    vCam.bgColor = 0x0;
    vCam.alpha = 0;
    FlxG.cameras.insert(vCam, FlxG.cameras.list.indexOf(camOther), false);
    
    vcamGroup = new FlxTypedGroup();
    vcamGroup.camera = vCam;
    add(vcamGroup);
    
    if (ClientPrefs.inDevMode)
    {
        var blueScreen:FunkinSprite = new FunkinSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.CYAN);
        blueScreen.alpha = 0.15;
        vcamGroup.add(blueScreen);
        
        var vcam_center:FunkinSprite = new FunkinSprite(0, 0).loadGraphic(Paths.image("vcam/vcam_center"));
        vcam_center.screenCenter();
        vcamGroup.add(vcam_center);

        var vcam_cornerTL:FunkinSprite = new FunkinSprite(0, 0).loadGraphic(Paths.image("vcam/vcam_corner"));
        vcam_cornerTL.color = FlxColor.BLACK;
        vcamGroup.add(vcam_cornerTL);

        var vcam_lineHT:FunkinSprite = new FunkinSprite(0, 0).loadGraphic(Paths.image("vcam/vcam_line_horizontal"));
        vcam_lineHT.screenCenter(FlxAxes.X);
        vcam_lineHT.color = FlxColor.BLACK;
        vcamGroup.add(vcam_lineHT);

        var vcam_cornerTR:FunkinSprite = new FunkinSprite(FlxG.width - 42, 0).loadGraphic(Paths.image("vcam/vcam_corner"));
        vcam_cornerTR.color = FlxColor.BLACK;
        vcam_cornerTR.angle = 90;
        vcamGroup.add(vcam_cornerTR);

        var vcam_lineVR:FunkinSprite = new FunkinSprite(FlxG.width - 9, 0).loadGraphic(Paths.image("vcam/vcam_line_vertical"));
        vcam_lineVR.screenCenter(FlxAxes.Y);
        vcam_lineVR.color = FlxColor.BLACK;
        vcamGroup.add(vcam_lineVR);

        var vcam_cornerBR:FunkinSprite = new FunkinSprite(FlxG.width - 42, FlxG.height - 42).loadGraphic(Paths.image("vcam/vcam_corner"));
        vcam_cornerBR.color = FlxColor.BLACK;
        vcam_cornerBR.angle = 180;
        vcamGroup.add(vcam_cornerBR);

        var vcam_lineHB:FunkinSprite = new FunkinSprite(0, FlxG.height - 9).loadGraphic(Paths.image("vcam/vcam_line_horizontal"));
        vcam_lineHB.screenCenter(FlxAxes.X);
        vcam_lineHB.color = FlxColor.BLACK;
        vcamGroup.add(vcam_lineHB);

        var vcam_cornerBL:FunkinSprite = new FunkinSprite(0, FlxG.height - 42).loadGraphic(Paths.image("vcam/vcam_corner"));
        vcam_cornerBL.zoomFactor = 0;
        vcam_cornerBL.scrollFactor.set();
        vcam_cornerBL.color = FlxColor.BLACK;
        vcam_cornerBL.angle = -90;
        vcamGroup.add(vcam_cornerBL);

        var vcam_lineVL:FunkinSprite = new FunkinSprite(0, 0).loadGraphic(Paths.image("vcam/vcam_line_vertical"));
        vcam_lineVL.screenCenter(FlxAxes.Y);
        vcam_lineVL.color = FlxColor.BLACK;
        vcamGroup.add(vcam_lineVL);
    }
}

function onUpdate(elapsed)
{
    if (FlxG.keys.justPressed.F7)
    {
        if (vCam.alpha == 0) vCam.alpha = 1;
        else vCam.alpha = 0;
    }
}