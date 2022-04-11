package abilities;

import flixel.group.FlxGroup.FlxTypedGroup;

class AbilityHandler
{
	public var abilities:Map<AbilityKeyBindEnum, Array<Ability>>;

	public function new()
	{
		this.abilities = new Map<AbilityKeyBindEnum, Array<Ability>>();
		this.abilities.set(AbilityKeyBindEnum.SPACE, new Array<Ability>());
		this.abilities.set(AbilityKeyBindEnum.Q, new Array<Ability>());
		this.abilities.set(AbilityKeyBindEnum.E, new Array<Ability>());
		this.abilities.set(AbilityKeyBindEnum.ANONYMOUS, new Array<Ability>());
	}

	public function addAbilities(newAbilities:Map<AbilityKeyBindEnum, Array<Ability>>)
	{
		for (abilityKeyBindEnum => abilityArray in newAbilities)
		{
			for (ability in abilityArray)
			{
				trace(abilityKeyBindEnum, ability);
				this.abilities.get(abilityKeyBindEnum).push(ability);
			}
		}
	}

	public function update(x, y, elapsed:Float)
	{
		/*
			Main update for abilities. If an ability timer (readyTimer) is at 0 and the 
			ability state is ACTIVE, cast is called an a new action is pushed onto an array
			These actions will be passed into the actionHandler on function completion.
			Once ability is cast, it is reset to INACTIVE and its readyTimer is set to its 
			cooldown.
		 */
		var newActions = new Array<Map<AbilityTargetingEnum, Array<Action>>>();
		for (abilityKeyBindEnum => abilityArray in this.abilities)
		{
			for (ability in abilityArray)
			{
				if (ability.readyTimer <= 0 && ability.state == AbilityStateEnum.ACTIVE)
				{
					newActions = ability.castAbility(x, y);
					ability.readyTimer = ability.cooldown;
					ability.state = AbilityStateEnum.INACTIVE;
				}
				ability.readyTimer -= elapsed;
			}
		}
		return newActions;
	}
}
