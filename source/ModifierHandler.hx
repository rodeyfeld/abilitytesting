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
		for (modifier in newModifiers)
		{
			this.modifiers.push(modifier);
		}
	}

	public function update(x, y, actions)
	{
		var postEffectAbilities = new Array<Ability>();
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
					postEffectAbilities.push(effect.value);
				}
			}
		}
		return postEffectAbilities;
	}
}
