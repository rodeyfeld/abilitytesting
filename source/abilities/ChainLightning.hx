package abilities;

import actions.ProjectileAction;
import modifiers.LightningBallModifier;

class ChainLightning extends Ability
{
	override public function new(capacity)
	{
		var newModifiers = new Array<Modifier>();
		this.targetingEnum = AbilityTargetingEnum.MOUSE_ANGLE_INIT;
		newModifiers.push(new LightningBallModifier(capacity));
		super(newModifiers);
	}

	override public function castAbility(x:Float, y:Float):Action
	{
		var pAction = new ProjectileAction(this.modifiers, x, y, targetingEnum);
		return pAction;
	}
}
