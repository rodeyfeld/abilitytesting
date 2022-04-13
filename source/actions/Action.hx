package actions;

import actions.ActionStateEnum;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import visualeffects.VisualEffect;

class Action extends FlxSprite
{
	public var state:ActionStateEnum;
	public var modifiers:Array<Modifier>;
	public var targetingEnum:AbilityTargetingEnum;
	public var visualEffects:Map<ActionStateEnum, Array<VisualEffect>>;

	public function new(modifiers, x:Float, y:Float, targetingEnum)
	{
		this.targetingEnum = targetingEnum;
		this.state = ActionStateEnum.INACTIVE;
		this.modifiers = modifiers;
		this.visualEffects = new Map<ActionStateEnum, Array<VisualEffect>>();
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
