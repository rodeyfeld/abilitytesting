package modifiers;

import Effect.DamageEffect;
import Effect.RefireEffect;
import FrequencyTypeEnum.FrequnceyTypeEnum;

class MagicDamageModifier extends Modifier
{
	public function new()
	{
		this.effects = new Array<Effect<Dynamic>>();
		this.frequencyType = FrequnceyTypeEnum.ON_HIT;
		var damage = new DamageEffect(EffectEnum.DAMAGE, 10);
		effects.push(damage);

		super();
	}
}
