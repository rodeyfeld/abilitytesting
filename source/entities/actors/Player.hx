package entities.actors;

import abilities.ChainLightning;

class Player extends Actor
{
	public function new(x, y, actions)
	{
		super(x, y);
		this.actions = actions;
		this.ability = new ChainLightning();
		this.stats = new Map<StatEnum, Float>();
		this.stats[StatEnum.HEALTH] = 10;
		this.modifierHandler = new ModifierHandler(stats);
		loadGraphic(AssetPaths.player__png, true, 16, 16);

		var playerAction:Action = ability.castAbility(x, y);
		actions.add(playerAction);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
