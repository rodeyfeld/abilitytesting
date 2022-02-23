package entities.actors;

import abilities.ChainLightning;
import flixel.FlxG;

class Player extends Actor
{
	public function new(x, y, actions)
	{
		super(x, y);
		this.stats = new Map<StatEnum, Float>();
		this.stats[StatEnum.HEALTH] = 10;
		this.modifierHandler = new ModifierHandler(stats);
		this.abilityHandler = new AbilityHandler(actions);
		var ability:Ability = new ChainLightning(3);
		this.abilityHandler.addAbility(ability);
		loadGraphic(AssetPaths.player__png, true, 16, 16);
	}

	override public function update(elapsed:Float)
	{
		updateAbilityState(elapsed);
		super.update(elapsed);
	}

	public function updateAbilityState(elapsed:Float)
	{
		var space = FlxG.keys.anyPressed([SPACE]);
		if (space)
		{
			for (ability in this.abilityHandler.abilities)
			{
				if (ability.keyBind == AbilityKeyBindEnum.SPACE)
				{
					ability.state = AbilityStateEnum.ACTIVE;
				}
			}
		}
	}
}
