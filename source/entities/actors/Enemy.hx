package entities.actors;

class Enemy extends Actor
{
	public function new(x, y, actions)
	{
		super(x, y);
		this.actions = actions;
		this.stats = new Map<StatEnum, Float>();
		this.stats[StatEnum.HEALTH] = 10;
		this.modifierHandler = new ModifierHandler(stats);
		loadGraphic(AssetPaths.player__png, true, 16, 16);
	}
}
