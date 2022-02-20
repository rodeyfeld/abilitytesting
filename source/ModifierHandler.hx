package;

import actions.ProjectileAction;

class ModifierHandler
{
	public var modifiers:Array<Modifier>;
	public var stats:Map<StatEnum, Float>;

	public function new(stats)
	{
		this.stats = stats;
		this.modifiers = new Array<Modifier>();
	};

	public function addModifiers(newModifiers:Array<Modifier>)
	{
		this.modifiers = this.modifiers.concat(newModifiers);
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
					if (effect.value > 0)
					{
						var _modifiers = new Array<Modifier>();
						effect.value -= 1;
						_modifiers.push(modifier);
						trace(_modifiers);
						var pAction = new ProjectileAction(_modifiers, x, y);
						actions.add(pAction);
						pAction.executeAction();
					}
				}
			}
		}
	}
}
