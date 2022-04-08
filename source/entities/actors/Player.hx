package entities.actors;

import abilities.ChainLightning;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxPoint;

class Player extends Actor
{
	public static inline var RUN_SPEED:Int = 100;

	public function new(x, y)
	{
		super(x, y);

		this.stats = new Map<StatEnum, Float>();
		this.stats[StatEnum.HEALTH] = 10;
		this.tags = new Map<TagEnum, Float>();
		this.tags[TagEnum.REFIRED] = 0;
		this.modifierHandler = new ModifierHandler(stats, tags);
		this.abilityHandler = new AbilityHandler();
		// Assign and create default weapon ability
		var ability:Ability = new ChainLightning(3);
		this.abilityHandler.addAbility(ability);
		this.actionHandler = new ActionHandler();
		loadGraphic(AssetPaths.player__png, true, 16, 16);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		animation.add("d", [0, 1, 2], 6, false);
		animation.add("lr", [15, 16, 17], 6, false);
		animation.add("u", [45, 46, 47], 6, false);
		drag.x = drag.y = 1600;
		offset.set(4, 4);
	}

	override public function update(elapsed:Float)
	{
		updateAbilityState(elapsed);
		updateMovement(elapsed);
		super.update(elapsed);
	}

	public function updateAbilityState(elapsed:Float)
	{
		var space = FlxG.keys.anyPressed([SPACE]);
		if (space)
		{
			// TODO: Make this reference ability directly by key instead of searching.
			for (ability in this.abilityHandler.abilities)
			{
				if (ability.keyBind == AbilityKeyBindEnum.SPACE && ability.readyTimer <= 0)
				{
					ability.state = AbilityStateEnum.ACTIVE;
				}
			}
		}
	}

	function updateMovement(elapsed:Float)
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		// var attack:Bool = false;
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);
		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;
		var newAngle:Float = 0;
		if (up || down || left || right)
		{
			if (up)
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
				facing = FlxObject.UP;
			}
			else if (down)
			{
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
				facing = FlxObject.DOWN;
			}
			else if (left)
			{
				newAngle = 180;
				facing = FlxObject.LEFT;
			}
			else if (right)
			{
				newAngle = 0;
				facing = FlxObject.RIGHT;
			}

			// determine our velocity based on angle and speed
			velocity.set(RUN_SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), newAngle);
			// if the player is moving (velocity is not 0 for either axis), we need to change the animation to match their facing
			if ((velocity.x != 0 || velocity.y != 0))
			{
				switch (facing)
				{
					case FlxObject.LEFT, FlxObject.RIGHT:
						animation.play("lr");
					case FlxObject.UP:
						animation.play("u");
					case FlxObject.DOWN:
						animation.play("d");
					case _:
				}
			}
		}
	}
}
