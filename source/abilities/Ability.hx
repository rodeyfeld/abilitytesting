package abilities;

import flixel.FlxG;

class Ability
{
	public var modifiers:Array<Modifier>;
	public var state:AbilityStateEnum;
	public var capacity:Int;
	public var cooldown:Float;
	public var readyTimer:Float;
	public var keyBind:AbilityKeyBindEnum;
	public var targetingEnum:AbilityTargetingEnum;

	// publicvarablityType

	public function new(capacity:Int = -1)
	{
		this.state = AbilityStateEnum.INACTIVE;
		this.modifiers = new Array<Modifier>();
		this.keyBind = AbilityKeyBindEnum.SPACE;
		this.capacity = capacity;
		this.cooldown = 2;
		this.readyTimer = 0;
	}

	public function castAbility(x:Float, y:Float):Array<Map<AbilityTargetingEnum, Array<Action>>>
	{
		var newModifiers = new Array<Modifier>();
		var newActionMaps = new Array<Map<AbilityTargetingEnum, Array<Action>>>();
		var action = new Action(newModifiers, x, y, targetingEnum);
		var actionGroup = new Array<Action>();
		actionGroup.push(action);
		var actionMap = new Map<AbilityTargetingEnum, Array<Action>>();
		actionMap.set(AbilityTargetingEnum.MOUSE_ANGLE_INIT, actionGroup);
		newActionMaps.push(actionMap);
		return newActionMaps;
	}
}
