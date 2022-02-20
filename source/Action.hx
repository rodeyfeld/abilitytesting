package;

import ActionStatusEnum.ActionStatus;
import flixel.FlxSprite;

class Action extends FlxSprite
{
	public var status:ActionStatus;
	public var modifiers:Array<Modifier>;

	public function new(modifiers, x, y)
	{
		this.status = ActionStatus.INACTIVE;
		this.modifiers = modifiers;
		super(x, y);
	}

	public function executeAction()
	{
		this.status = ActionStatus.ACTIVE;
	}
}
