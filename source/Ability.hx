package;

class Ability
{
	public var modifiers:Array<Modifier>;
	public var capacity:Float;

	public function new(newModifiers:Array<Modifier>, capacity = -1)
	{
		this.modifiers = new Array<Modifier>();
		this.capacity = capacity;
		for (modifier in newModifiers)
		{
			this.modifiers.push(modifier);
		}
	}

	public function castAbility(x:Float, y:Float):Action
	{
		var action = new Action(this, x, y);
		return action;
	}
}
