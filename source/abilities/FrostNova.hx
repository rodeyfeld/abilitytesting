package abilities;

import modifiers.BurningModifier;

class FrostNova extends Ability
{
	override public function new(capacity:Int)
	{
		this.targetingEnum = AbilityTargetingEnum.NOVA;
		super(capacity);
	}

	override public function castAbility(x:Float, y:Float):Array<Map<AbilityTargetingEnum, Array<Action>>>
	{
		var newModifiers = new Array<Modifier>();
		var newActionMaps = new Array<Map<AbilityTargetingEnum, Array<Action>>>();
		var action = new Action(newModifiers, x, y, targetingEnum);
		var actionGroup = new Array<Action>();
		actionGroup.push(action);
		var actionMap = new Map<AbilityTargetingEnum, Array<Action>>();
		actionMap.set(AbilityTargetingEnum.NOVA, actionGroup);
		newActionMaps.push(actionMap);
		return newActionMaps;
	}
}
