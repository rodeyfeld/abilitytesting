package modifiers;

import FrequencyTypeEnum.FrequnceyTypeEnum;

class ModifierHandler
{
	public var modifiers:Array<Modifier>;
	public var stats:Map<StatEnum, Float>;
	public var tags:Map<TagEnum, Float>;

	public function new(stats, tags)
	{
		this.stats = stats;
		this.tags = tags;
		this.modifiers = new Array<Modifier>();
	};

	public function addModifiers(newModifiers:Array<Modifier>)
	{
		for (modifier in newModifiers)
		{
			modifier.state = ModifierStateEnum.ACTIVE;
			this.modifiers.push(modifier);
		}
	}

	public function removeFinishedModifiers()
	{
		var i = this.modifiers.length;
		while (--i >= 0)
			if (this.modifiers[i].state == ModifierStateEnum.FINISHED)
				this.modifiers.splice(i, 1);
	}

	public function update(x, y, elapsed:Float)
	{
		var postEffectAbilities = new Array<Ability>();
		for (modifier in this.modifiers)
		{
			if (modifier.state == ModifierStateEnum.ACTIVE)
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
						var currRefired:Float = tags.get(TagEnum.REFIRED);
						currRefired = 1;
						tags.set(TagEnum.REFIRED, currRefired);
						var ability:Ability = effect.value;
						ability.state = AbilityStateEnum.ACTIVE;
						postEffectAbilities.push(ability);
					}
				}
				if (modifier.frequencyType == FrequnceyTypeEnum.ON_HIT)
				{
					modifier.state = ModifierStateEnum.FINISHED;
				}
			}
		}
		removeFinishedModifiers();
		return postEffectAbilities;
	}
}
