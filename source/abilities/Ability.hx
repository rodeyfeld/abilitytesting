package abilities;

import flixel.FlxG;
import visualeffects.VisualEffect;

class Ability
{
	public var modifiers:Array<Modifier>;
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
		this.modifiers = new Array<Modifier>();
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

	function generateActionMaps(currTargetingEnum, modifiers, x, y):Array<Map<AbilityTargetingEnum, Array<Action>>>
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
		return actionMaps;
	}

	public function castAbility(x:Float, y:Float):Array<Map<AbilityTargetingEnum, Array<Action>>>
	{
		var newActionsMaps = generateActionMaps(AbilityTargetingEnum.MOUSE_ANGLE_INIT, null, 0, 0);
		return newActionsMaps;
	}
}
