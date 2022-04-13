package visualeffects;

import flixel.FlxSprite;
import visualeffects.VisualEffectEnum.VisualEffectStateEnum;

class VisualEffect extends FlxSprite
{
	public var name:String;
	public var _frames:Array<Int>;
	public var assetPath:String;
	public var animated:Bool;
	public var framerate:Int;
	public var looped:Bool;
	public var state:VisualEffectStateEnum;

	public function new(name, assetPath, _frames, animated, framerate, looped = false)
	{
		this.name = name;
		this.assetPath = assetPath;
		this._frames = _frames;
		this.animated = animated;
		this.framerate = framerate;
		this.looped = looped;
		this.state = VisualEffectStateEnum.ACTIVE;
		super(x, y);
	}

	public function executeVisualEffect()
	{
		loadGraphic(this.assetPath, true, 16, 16);
	}
}
