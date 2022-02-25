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

	public function new(x:Float, y:Float)
	{
		super(x, y);
	}

	override public function update(elapsed)
	{
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
