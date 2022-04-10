package abilities;

import modifiers.BurningModifier;

class Fireball extends Ability
{
	override public function new(capacity)
	{
		var newModifiers = new Array<Modifier>();
		this.targetingEnum = AbilityTargetingEnum.MOUSE_ANGLE_INIT;
		newModifiers.push(new BurningModifier(capacity));
		super(newModifiers);
	}

	override public function castAbility(x:Float, y:Float):Action
	{
		var pAction = new Action(this.modifiers, x, y, targetingEnum);
		return pAction;
	}
}
