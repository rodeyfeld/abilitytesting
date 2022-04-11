package;

class Effect<T>
{
	public var name:EffectEnum;
	public var value:T;

	public function new(name, value:T)
	{
		this.name = name;
		this.value = value;
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

class NovaEffect extends Effect<Array<Ability>>
{
	override public function new(name, value)
	{
		super(name, value);
	}
}
