package;

import ActionStatusEnum.ActionStatus;
import flixel.FlxSprite;

class Action extends FlxSprite
{
	public var status:ActionStatus;
	public var modifiers:Array<Modifier>;
	public var sourceAbility:Ability;

	public function new(sourceAbility, x, y)
	{
		this.status = ActionStatus.INACTIVE;
		this.sourceAbility = sourceAbility;
		super(x, y);
	}

	public function executeAction()
	{
		this.status = ActionStatus.ACTIVE;
	}
}
