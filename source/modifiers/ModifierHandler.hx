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

	function removeFinishedModifiers()
	{
		var i = this.modifiers.length;
		while (--i >= 0)
			if (this.modifiers[i].state == ModifierStateEnum.FINISHED)
				this.modifiers.splice(i, 1);
	}

	public function update(x, y, elapsed:Float)
	{
		/* 
			Modifier handler main update method. Initializes post effect abilities 
			array for any chain ability like refiring. Handles setting of tags and
			adjusting stats. If a new ability is found in the modifier, it added to
			the postEffectAbilities as an instant cast (ACTIVE state). Removes modifiers
			based on frequencyType and eventually timers. 
		 */

		var postEffectAbilities = new Map<AbilityKeyBindEnum, Array<Ability>>();
		postEffectAbilities.set(AbilityKeyBindEnum.ANONYMOUS, new Array<Ability>());
		for (modifier in this.modifiers)
		{
			// TODO: Condense this code
			if (modifier.state == ModifierStateEnum.ACTIVE)
			{
				for (effect in modifier.effects)
				{
					if (modifier.frequencyType == FrequnceyTypeEnum.ON_HIT)
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
							currRefired = 1.0;
							tags.set(TagEnum.REFIRED, currRefired);
							var ability:Ability = effect.value;
							ability.state = AbilityStateEnum.ACTIVE;
							postEffectAbilities.get(AbilityKeyBindEnum.ANONYMOUS).push(ability);
						}
						modifier.state = ModifierStateEnum.FINISHED;
					}
					else if (modifier.frequencyType == FrequnceyTypeEnum.INTERVAL)
					{
						modifier.readyTimer += elapsed;
						modifier.endTimer -= elapsed;
						if (modifier.endTimer >= 0 && modifier.readyTimer >= modifier.intervalTick)
						{
							if (effect.name == EffectEnum.DAMAGE)
							{
								var currHealth:Float = stats.get(StatEnum.HEALTH);
								currHealth -= effect.value;
								stats.set(StatEnum.HEALTH, currHealth);
								modifier.readyTimer = 0;
							}
						}
						else if (modifier.endTimer <= 0)
						{
							modifier.state = ModifierStateEnum.FINISHED;
						}
					}
				}
			}
		}
		removeFinishedModifiers();
		return postEffectAbilities;
	}
}
