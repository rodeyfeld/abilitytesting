package modifiers;

import FrequencyTypeEnum.FrequnceyTypeEnum;

class Modifier
{
	public var effects:Array<Effect<Dynamic>>;
	public var endTimer:Float;
	public var capacity:Float;
	public var frequencyType:FrequnceyTypeEnum;
	public var state:ModifierStateEnum;

	public function new(capacity)
	{
		this.capacity = capacity;
		this.frequencyType = FrequnceyTypeEnum.ON_HIT;
		this.state = ModifierStateEnum.INACTIVE;
	}
}
