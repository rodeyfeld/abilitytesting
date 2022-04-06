package actions;

import actions.ActionStateEnum;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Action extends FlxSprite
{
	public var state:ActionStateEnum;
	public var modifiers:Array<Modifier>;
	public var sourceAbility:Ability;
	public var targetingEnum:AbilityTargetingEnum;

	public function new(modifiers, x:Float, y:Float, targetingEnum)
	{
		this.targetingEnum = targetingEnum;
		this.state = ActionStateEnum.INACTIVE;
		this.modifiers = modifiers;
		super(x + 30, y + 30);
	}

	public function executeAction()
	{
		velocity.set(50);
		makeGraphic(2, 2, FlxColor.BLUE);
		this.state = ActionStateEnum.ACTIVE;
	}
}
