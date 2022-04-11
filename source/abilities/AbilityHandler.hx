package abilities;

import flixel.group.FlxGroup.FlxTypedGroup;

class AbilityHandler
{
	public var abilities:Array<Ability>;

	public function new()
	{
		this.abilities = new Array<Ability>();
	}

	public function addAbilities(newAbilities:Array<Ability>)
	{
		for (ability in newAbilities)
		{
			this.abilities.push(ability);
		}
	}

	public function addAbility(newAbility:Ability)
	{
		this.abilities.push(newAbility);
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
		for (ability in this.abilities)
		{
			if (ability.readyTimer <= 0 && ability.state == AbilityStateEnum.ACTIVE)
			{
				newActions = ability.castAbility(x, y);
				ability.readyTimer = ability.cooldown;
				ability.state = AbilityStateEnum.INACTIVE;
			}
			ability.readyTimer -= elapsed;
		}
		return newActions;
	}
}
