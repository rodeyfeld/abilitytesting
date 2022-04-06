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

	public function new(modifiers, x:Float, y:Float, targetingEnum)
	{
		this.targetingEnum = targetingEnum;
		this.state = ActionStateEnum.INACTIVE;
		this.modifiers = modifiers;
		super(x, y);
		makeGraphic(10, 10, FlxColor.BLUE);
	}

	public function executeAction()
	{
		this.state = ActionStateEnum.ACTIVE;
	}

	override public function kill()
	{
		this.state = ActionStateEnum.INACTIVE;
		super.kill();
	}
}
