package modifiers;

import Effect.DamageEffect;
import Effect.RefireEffect;
import FrequencyTypeEnum.FrequnceyTypeEnum;

class BasicRefireModifier extends Modifier
{
	public function new(capacity:Int, refireAbility:Ability)
	{
		this.effects = new Array<Effect<Dynamic>>();
		this.frequencyType = FrequnceyTypeEnum.ON_HIT;

		if (capacity > 0)
		{
			refireAbility.capacity -= 1;

			var refire = new RefireEffect(EffectEnum.REFIRE, refireAbility);
			effects.push(refire);
		}
		super(capacity);
	}
}
