package;

class Ability
{
	public var modifiers:Array<Modifier>;

	public function new(newModifiers:Array<Modifier>)
	{
		this.modifiers = new Array<Modifier>();
		for (modifier in newModifiers)
		{
			this.modifiers.push(modifier);
		}
	}

	public function castAbility(x:Float, y:Float):Action
	{
		var action = new Action(modifiers, x, y);
		return action;
	}
}
