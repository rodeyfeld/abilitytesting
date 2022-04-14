package visualeffects;

import flixel.FlxSprite;
import visualeffects.VisualEffectEnum.VisualEffectStateEnum;

class VisualEffect
{
	public var name:String;
	public var _frames:Int;
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
	}
}
