package abilities;

import flixel.FlxG;
import visualeffects.VisualEffect;

class Ability
{
	public var state:AbilityStateEnum;
	public var capacity:Int;
	public var refires:Int;
	public var cooldown:Float;
	public var readyTimer:Float;
	public var keyBind:AbilityKeyBindEnum;
	public var visualEffects:Map<ActionStateEnum, Array<VisualEffect>>;
	public var targetingEnum:AbilityTargetingEnum;

	// publicvarablityType

	public function new(refires:Int = -1)
	{
		this.state = AbilityStateEnum.INACTIVE;
		this.keyBind = AbilityKeyBindEnum.SPACE;
		this.capacity = 1;
		this.refires = refires;
		this.cooldown = 2;
		this.readyTimer = 0;
	}

	function createNewActionMaps():Array<Map<AbilityTargetingEnum, Array<Action>>>
	{
		var newActionMaps = new Array<Map<AbilityTargetingEnum, Array<Action>>>();
		return newActionMaps;
	}

	function createNewModifiers(modifiers:Array<Modifier>)
	{
		var newModifiers = new Array<Modifier>();
		for (modifier in modifiers)
		{
			newModifiers.push(modifier);
		}
		return newModifiers;
	}

	function createActionMaps(actionMap):Array<Map<AbilityTargetingEnum, Array<Action>>>
	{
		var actionMaps = createNewActionMaps();
		var actionMap = new Map<AbilityTargetingEnum, Array<Action>>();
		actionMap.set(currTargetingEnum, actionGroup);
		actionMaps.push(actionMap);
		return actionMap;
	}

	public function castAbility(x:Float, y:Float):Array<Map<AbilityTargetingEnum, Array<Action>>>
	{
		var newActionsMaps = generateActionMaps(AbilityTargetingEnum.MOUSE_ANGLE_INIT, null, 0, 0);
		return newActionsMaps;
	}
}
