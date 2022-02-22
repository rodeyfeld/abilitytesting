package;

import FrequencyTypeEnum.FrequnceyTypeEnum;

class Effect<T>
{
	public var name:EffectEnum;
	public var value:T;
	public var frequencyType:FrequnceyTypeEnum;

	public function new(name, value:T)
	{
		this.name = name;
		this.value = value;
		this.frequencyType = FrequnceyTypeEnum.ON_HIT;
	}
}

class RefireEffect extends Effect<Ability>
{
	override public function new(name, value)
	{
		super(name, value);
	}
}

class DamageEffect extends Effect<Float>
{
	override public function new(name, value)
	{
		super(name, value);
	}
}
