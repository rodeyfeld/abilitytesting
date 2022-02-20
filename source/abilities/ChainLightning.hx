package abilities;

import actions.ProjectileAction;
import modifiers.LightningBallModifier;

class ChainLightning extends Ability
{
	override public function new()
	{
		var newModifiers = new Array<Modifier>();
		newModifiers.push(new LightningBallModifier());
		super(newModifiers);
	}

	override public function castAbility(x:Float, y:Float):Action
	{
		var pAction = new ProjectileAction(this.modifiers, x, y);
		pAction.executeAction();
		return pAction;
	}
}
