package;

import FrequencyTypeEnum.FrequnceyTypeEnum;

class Effect
{
	public var name:EffectEnum;
	public var frequencyType:FrequnceyTypeEnum;
	public var value:Float;

	public function new(name, ?value = null)
	{
		this.name = name;
		this.value = value;
		this.frequencyType = FrequnceyTypeEnum.ON_HIT;
	}
}

class RefireEffect extends Effect
{
	override public function new(name, value)
	{
		super(name, value);
	}
}

class DamageEffect extends Effect
{
	override public function new(name, value)
	{
		super(name, value);
	}
}
