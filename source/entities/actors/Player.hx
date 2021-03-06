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
		this.stats[StatEnum.HEALTH] = 100;
		this.tags = new Map<TagEnum, Float>();
		this.tags[TagEnum.REFIRED] = 0;
		this.modifierHandler = new ModifierHandler(stats, tags);
		this.abilityHandler = new AbilityHandler();
		// Assign and create default weapon ability
		// var ability:Ability = new ChainLightning(3);
		var ability1:Ability = new FrostNova(10);
		var newAbilities1 = new Array<Ability>();
		newAbilities1.push(ability1);
		var newAbilitiesMap1 = new Map<AbilityKeyBindEnum, Array<Ability>>();
		newAbilitiesMap1.set(AbilityKeyBindEnum.SPACE, newAbilities1);
		this.abilityHandler.addAbilities(newAbilitiesMap1);

		var ability2:Ability = new Fireball(1);
		var newAbilities2 = new Array<Ability>();
		newAbilities2.push(ability2);
		var newAbilitiesMap2 = new Map<AbilityKeyBindEnum, Array<Ability>>();
		newAbilitiesMap2.set(AbilityKeyBindEnum.Q, newAbilities2);
		this.abilityHandler.addAbilities(newAbilitiesMap2);

		var ability3:Ability = new ChainLightning(3);
		var newAbilities3 = new Array<Ability>();
		newAbilities3.push(ability3);
		var newAbilitiesMap3 = new Map<AbilityKeyBindEnum, Array<Ability>>();
		newAbilitiesMap3.set(AbilityKeyBindEnum.E, newAbilities3);
		this.abilityHandler.addAbilities(newAbilitiesMap3);

		// var ability4:Ability = new FrostNova(10);
		// var newAbilities = new Array<Ability>();
		// newAbilities.push(ability4);
		// var newAbilitiesMap = new Map<AbilityKeyBindEnum, Array<Ability>>();
		// newAbilitiesMap.set(AbilityKeyBindEnum.R, newAbilities);
		// this.abilityHandler.addAbilities(newAbilitiesMap);

		// var ability5:Ability = new FrostNova(10);
		// var newAbilities = new Array<Ability>();
		// newAbilities.push(ability5);
		// var newAbilitiesMap = new Map<AbilityKeyBindEnum, Array<Ability>>();
		// newAbilitiesMap.set(AbilityKeyBindEnum.R, newAbilities);
		// this.abilityHandler.addAbilities(newAbilitiesMap);

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
		var q = FlxG.keys.anyPressed([Q]);
		var e = FlxG.keys.anyPressed([E]);
		var r = FlxG.keys.anyPressed([R]);
		var f = FlxG.keys.anyPressed([F]);
		// TODO: Fix this mess
		if (space)
		{
			var abilities = this.abilityHandler.abilities.get(AbilityKeyBindEnum.SPACE);
			for (ability in abilities)
			{
				if (ability.readyTimer <= 0)
				{
					ability.state = AbilityStateEnum.ACTIVE;
				}
			}
		}
		else if (q)
		{
			var abilities = this.abilityHandler.abilities.get(AbilityKeyBindEnum.Q);
			for (ability in abilities)
			{
				if (ability.readyTimer <= 0)
				{
					ability.state = AbilityStateEnum.ACTIVE;
				}
			}
		}
		else if (e)
		{
			var abilities = this.abilityHandler.abilities.get(AbilityKeyBindEnum.E);
			for (ability in abilities)
			{
				if (ability.readyTimer <= 0)
				{
					ability.state = AbilityStateEnum.ACTIVE;
				}
			}
		}
		else if (r)
		{
			var abilities = this.abilityHandler.abilities.get(AbilityKeyBindEnum.R);
			for (ability in abilities)
			{
				if (ability.readyTimer <= 0)
				{
					ability.state = AbilityStateEnum.ACTIVE;
				}
			}
		}
		else if (f)
		{
			var abilities = this.abilityHandler.abilities.get(AbilityKeyBindEnum.F);
			for (ability in abilities)
			{
				if (ability.readyTimer <= 0)
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
