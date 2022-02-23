package;

import flixel.FlxG;

class Ability
{
	public var modifiers:Array<Modifier>;
	public var state:AbilityStateEnum;
	public var capacity:Float;
	public var cooldown:Float;
	public var keyBind:AbilityKeyBindEnum;

	public function new(newModifiers:Array<Modifier>, capacity = -1)
	{
		this.state = AbilityStateEnum.INACTIVE;
		this.modifiers = new Array<Modifier>();
		this.keyBind = AbilityKeyBindEnum.SPACE;
		this.capacity = capacity;
		this.cooldown = 5;
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
