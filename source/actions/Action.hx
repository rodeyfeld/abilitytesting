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
	public var living:Bool;
	public var trueX:Float;
	public var trueY:Float;

	public function new(modifiers, x:Float, y:Float, targetingEnum)
	{
		this.targetingEnum = targetingEnum;
		this.state = ActionStateEnum.INACTIVE;
		this.modifiers = modifiers;
		this.trueX = x;
		this.trueY = y;
		super(x, y);
	}

	public function executeAction()
	{
		// Sets the state to ACTIVE. Actions do not show up or collide until ACTIVE is set
		makeGraphic(3, 3, FlxColor.MAGENTA);
		this.state = ActionStateEnum.ACTIVE;
	}

	override public function kill()
	{
		// Sets the action state to FINISHED. Actions marked finished will be
		// removed in the action handler on its next update
		this.state = ActionStateEnum.FINISHED;
		super.kill();
	}
}
