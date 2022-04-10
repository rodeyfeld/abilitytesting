package abilities;

import actions.ProjectileAction;
import modifiers.LightningBallModifier;

class ChainLightning extends Ability
{
	override public function new(capacity:Int)
	{
		this.targetingEnum = AbilityTargetingEnum.MOUSE_ANGLE_INIT;
		super(capacity);
	}

	override public function castAbility(x:Float, y:Float):Action
	{
		var newModifiers = new Array<Modifier>();
		newModifiers.push(new LightningBallModifier(this.capacity));
		var pAction = new Action(newModifiers, x, y, targetingEnum);
		return pAction;
	}
}
