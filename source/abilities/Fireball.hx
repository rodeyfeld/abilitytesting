package abilities;

import modifiers.BurningModifier;

class Fireball extends Ability
{
	override public function new(capacity:Int)
	{
		this.targetingEnum = AbilityTargetingEnum.MOUSE_ANGLE_INIT;
		super();
	}

	override public function castAbility(x:Float, y:Float):Action
	{
		var newModifiers = new Array<Modifier>();
		newModifiers.push(new BurningModifier());
		var pAction = new Action(newModifiers, x, y, this.targetingEnum);
		return pAction;
	}
}
