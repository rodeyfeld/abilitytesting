package entities.actors;

import flixel.group.FlxGroup.FlxTypedGroup;

class Enemy extends Actor
{
	var closestEnemy:Enemy;

	public function new(x, y)
	{
		super(x, y);
		this.stats = new Map<StatEnum, Float>();
		this.stats[StatEnum.HEALTH] = 100;
		this.tags = new Map<TagEnum, Float>();
		this.tags[TagEnum.REFIRED] = 0;
		this.modifierHandler = new ModifierHandler(stats, tags);
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
}
