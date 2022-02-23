package;

class Modifier
{
	public var effects:Array<Effect<Dynamic>>;
	public var endTimer:Float;
	public var capacity:Float;

	public function new(capacity)
	{
		this.capacity = capacity;
	}
}
