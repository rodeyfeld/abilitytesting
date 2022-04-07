package abilities;

import flixel.FlxG;

class Ability
{
	public var modifiers:Array<Modifier>;
	public var state:AbilityStateEnum;
	public var capacity:Float;
	public var cooldown:Float;
	public var readyTimer:Float;
	public var keyBind:AbilityKeyBindEnum;
	public var targetingEnum:AbilityTargetingEnum;

	// publicvarablityType

	public function new(newModifiers:Array<Modifier>, capacity = -1)
	{
		this.state = AbilityStateEnum.INACTIVE;
		this.modifiers = new Array<Modifier>();
		this.keyBind = AbilityKeyBindEnum.SPACE;
		this.capacity = capacity;
		this.cooldown = 2;
		this.readyTimer = 0;
		for (modifier in newModifiers)
		{
			this.modifiers.push(modifier);
		}
	}

	public function castAbility(x:Float, y:Float):Action
	{
		var action = new Action(this.modifiers, x, y, targetingEnum);

		return action;
	}
}
