package abilities;

import flixel.group.FlxGroup.FlxTypedGroup;

class AbilityHandler
{
	public var abilities:Array<Ability>;
	public var actions:FlxTypedGroup<Action>;

	public function new(actions:FlxTypedGroup<Action>)
	{
		this.abilities = new Array<Ability>();
		this.actions = actions;
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
		var newActions = new Array<Action>();
		for (ability in this.abilities)
		{
			if (ability.readyTimer <= 0 && ability.state == AbilityStateEnum.ACTIVE)
			{
				var action:Action = ability.castAbility(x, y);
				newActions.push(action);
				ability.readyTimer = ability.cooldown;
				ability.state = AbilityStateEnum.INACTIVE;
			}
			ability.readyTimer -= elapsed;
		}
		return newActions;
	}
}
