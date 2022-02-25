package actions;

import flixel.util.FlxColor;

class ProjectileAction extends Action
{
	public function new(modifiers, x, y, targetingEnum)
	{
		super(modifiers, x, y, targetingEnum);
	}

	override public function executeAction()
	{
		makeGraphic(16, 16, FlxColor.GREEN);
		velocity.set(50);
		super.executeAction();
	}
}
