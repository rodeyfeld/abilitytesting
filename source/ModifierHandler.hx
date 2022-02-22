package;

import actions.ProjectileAction;

class ModifierHandler
{
	public var modifiers:Array<Map<Modifier, Action>>;
	public var stats:Map<StatEnum, Float>;

	public function new(stats)
	{
		this.stats = stats;
		this.modifiers = new Array<Map<Modifier, Action>>();
	};

	public function addModifiers(playerAction:Action)
	{
		for (modifier in playerAction.modifiers)
		{
			var item = new Map<Modifier, Action>();
			item[modifier] = playerAction;
			this.modifiers.push(item);
		}
	}

	public function update(x, y, actions)
	{
		for (modifier in this.modifiers)
		{
			for (effect in modifier.effects)
			{
				if (effect.name == EffectEnum.DAMAGE)
				{
					var currHealth:Float = stats.get(StatEnum.HEALTH);
					currHealth -= effect.value;
					stats.set(StatEnum.HEALTH, currHealth);
				}
				if (effect.name == EffectEnum.REFIRE)
				{
					var _modifiers = new Array<Modifier>();
					_modifiers.push(modifier);
					trace(_modifiers);
					var ability = new Ability()
					var pAction = new ProjectileAction(_modifiers, x, y);
					actions.add(pAction);
					pAction.executeAction();
				}
			}
		}
	}
}
