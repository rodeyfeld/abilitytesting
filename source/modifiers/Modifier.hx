package modifiers;

import FrequencyTypeEnum.FrequnceyTypeEnum;

class Modifier
{
	public var effects:Array<Effect<Dynamic>>;
	public var endTimer:Float;
	public var intervalTick:Float;
	public var readyTimer:Float;
	public var capacity:Int;
	public var frequencyType:FrequnceyTypeEnum;
	public var state:ModifierStateEnum;

	public function new(capacity:Int = -1)
	{
		this.capacity = capacity;

		this.state = ModifierStateEnum.INACTIVE;
	}
}
