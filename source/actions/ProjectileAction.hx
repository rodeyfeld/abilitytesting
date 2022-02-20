package actions;

import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class ProjectileAction extends Action
{
	public function new(modifiers, x, y)
	{
		super(modifiers, x, y);
	}

	override public function executeAction()
	{
		makeGraphic(16, 16, FlxColor.GREEN);
		velocity.set(50);
		velocity.rotate(FlxPoint.weak(0, 0), 30);
		super.executeAction();
	}
}
