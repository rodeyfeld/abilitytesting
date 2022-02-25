package entities.actors;

import flixel.group.FlxGroup.FlxTypedGroup;

class Enemy extends Actor
{
	var closestEnemy:Enemy;

	public function new(x, y)
	{
		super(x, y);
		this.stats = new Map<StatEnum, Float>();
		this.stats[StatEnum.HEALTH] = 10;
		this.modifierHandler = new ModifierHandler(stats);
		this.abilityHandler = new AbilityHandler();
		this.actionHandler = new ActionHandler();
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
		super.update(elapsed);
	}

	public function getClosestEnemy(enemies:FlxTypedGroup<Enemy>)
	{
		// var boundingBox:FlxRect = new FlxRect(this.x, this.y, 100, 100);
		// FlxG.overlap(enemies, boundingBox, assignClosestEnemy);
	}
}
