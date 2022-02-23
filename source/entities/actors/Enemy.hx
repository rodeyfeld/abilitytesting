package entities.actors;

import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRect;

class Enemy extends Actor
{
	var closestEnemy:Enemy;

	public function new(x, y, actions)
	{
		super(x, y);
		this.actions = actions;
		this.stats = new Map<StatEnum, Float>();
		this.stats[StatEnum.HEALTH] = 10;
		this.modifierHandler = new ModifierHandler(stats);
		this.abilityHandler = new AbilityHandler(actions);
		loadGraphic(AssetPaths.player__png, true, 16, 16);
	}

	public function assignClosestEnemy(enemy, thisEnemy)
	{
		if (closestEnemy != null)
		{
			this.closestEnemy = enemy;
		}
	}

	override public function update(elapsed:Float)
	{
		trace(stats);
		super.update(elapsed);
	}

	public function getClosestEnemy(enemies:FlxTypedGroup<Enemy>)
	{
		// var boundingBox:FlxRect = new FlxRect(this.x, this.y, 100, 100);
		// FlxG.overlap(enemies, boundingBox, assignClosestEnemy);
	}
}
