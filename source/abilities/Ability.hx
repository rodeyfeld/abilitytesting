package abilities;

import flixel.FlxG;
import visualeffects.VisualEffect;

class Ability
{
	public var modifiers:Array<Modifier>;
	public var state:AbilityStateEnum;
	public var capacity:Int;
	public var cooldown:Float;
	public var readyTimer:Float;
	public var keyBind:AbilityKeyBindEnum;
	public var visualEffects:Map<ActionStateEnum, Array<VisualEffect>>;
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

	function createNewActionMaps():Array<Map<AbilityTargetingEnum, Array<Action>>>
	{
		var newActionMaps = new Array<Map<AbilityTargetingEnum, Array<Action>>>();
		return newActionMaps;
	}

	function createNewModifiers(modifiers)
	{
		var newModifiers = new Array<Modifier>();
		for (modifier in newModifiers)
		{
			newModifiers.push(modifier);
		}
		return newModifiers;
	}

	function generateActionMaps(currTargetingEnum, modifiers, x, y)
	{
		var actionMaps = createNewActionMaps();
		var actionGroup = new Array<Action>();
		for (_ in 0...this.capacity)
		{
			// Need to create fresh modifiers each time, so they are tied to
			// this specific cast
			var newModifiers = createNewModifiers(modifiers);
			var action = new Action(newModifiers, x, y, currTargetingEnum);
			actionGroup.push(action);
		}
		var actionMap = new Map<AbilityTargetingEnum, Array<Action>>();
		actionMap.set(currTargetingEnum, actionGroup);
		actionMaps.push(actionMap);
	}

	public function castAbility(x:Float, y:Float):Array<Map<AbilityTargetingEnum, Array<Action>>>
	{
		var newActionsMaps = createNewActionMaps();
		var newModifiers = createNewModifiers();
		var action = new Action(newModifiers, x, y, targetingEnum);
		var actionGroup = new Array<Action>();
		actionGroup.push(action);
		var actionMap = new Map<AbilityTargetingEnum, Array<Action>>();
		actionMap.set(AbilityTargetingEnum.MOUSE_ANGLE_INIT, actionGroup);
		newActionsMaps.push(actionMap);
		return newActionsMaps;
	}
}
