package;

import ActionStateEnum;
import flixel.FlxSprite;

class Action extends FlxSprite
{
	public var state:ActionStateEnum;
	public var modifiers:Array<Modifier>;
	public var sourceAbility:Ability;
	public var aimAtNearestEnemy:Bool;

	public function new(modifiers, x, y)
	{
		this.aimAtNearestEnemy = false;
		this.state = ActionStateEnum.INACTIVE;
		this.modifiers = modifiers;
		super(x, y);
	}

	public function executeAction()
	{
		this.state = ActionStateEnum.ACTIVE;
	}
}
