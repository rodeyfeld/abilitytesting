package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Entity extends FlxSprite
{
	public var modifierHandler:ModifierHandler;
	public var ability:Ability;
	public var stats:Map<StatEnum, Float>;
	public var actions:FlxTypedGroup<Action>;

	public function new(x:Float, y:Float)
	{
		super(x, y);
	}

	override public function update(elapsed)
	{
		this.modifierHandler.update(x, y, actions);
		super.update(elapsed);
	}
}
