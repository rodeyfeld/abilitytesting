package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Entity extends FlxSprite
{
	public var modifierHandler:ModifierHandler;
	public var abilityHandler:AbilityHandler;
	public var abilities:Array<Ability>;
	public var stats:Map<StatEnum, Float>;
	public var actions:FlxTypedGroup<Action>;

	public function new(x:Float, y:Float)
	{
		super(x, y);
	}

	override public function update(elapsed)
	{
		var postEffectAbilities = this.modifierHandler.update(x, y, elapsed);
		this.abilityHandler.update(x, y, this.angle, elapsed);
		if (postEffectAbilities.length > 0)
		{
			abilityHandler.addAbilities(postEffectAbilities);
		}

		super.update(elapsed);
	}
}
