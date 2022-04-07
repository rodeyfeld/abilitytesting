package entities;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Entity extends FlxSprite
{
	public var modifierHandler:ModifierHandler;
	public var abilityHandler:AbilityHandler;
	public var actionHandler:ActionHandler;
	public var abilities:Array<Ability>;
	public var stats:Map<StatEnum, Float>;
	public var tags:Map<TagEnum, Float>;

	public function new(x:Float, y:Float)
	{
		super(x, y);
	}

	override public function update(elapsed)
	{
		/* 
			Entity Logic Managment 
			All entities have an modifier handler, and ability handler,
			and an action handler. Modifier handler updates first, and responds
			back with any new abilities that need to be cast as a result of an 
			effect. If there are abilities to be cast, they are added to the ability
			handler before it updates. The ability handler then does a similar process.
			Any new actions as a result of a casted ability are passed to the action 
			handler for action specific tuning.
		 */
		var postEffectAbilities = this.modifierHandler.update(x, y, elapsed);
		if (postEffectAbilities.length > 0)
		{
			abilityHandler.addAbilities(postEffectAbilities);
		}
		var newActions:Array<Action> = this.abilityHandler.update(x, y, elapsed);
		if (newActions.length > 0)
		{
			actionHandler.addInactiveActions(newActions);
		}

		super.update(elapsed);
	}
}
