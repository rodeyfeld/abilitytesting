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
		this.frameWidth = 16;
		this.frameHeight = 16;
		super(x, y);
	}

	public function executeAction()
	{
		// Sets the state to ACTIVE. Actions do not show up or collide until ACTIVE is set
		var currVisualEffect = this.visualEffects.get(ActionStateEnum.ACTIVE)[0];
		loadGraphic(currVisualEffect.assetPath, currVisualEffect.animated, 16, 16);
		var _test = [for (i in 0...currVisualEffect._frames) i];
		trace(_test);
		animation.add(currVisualEffect.name, [
			for (i in 0...currVisualEffect._frames)
				i
		], 16);
		animation.play(currVisualEffect.name);
		trace(currVisualEffect);
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
