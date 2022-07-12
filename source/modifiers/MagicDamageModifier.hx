package modifiers;

import Effect.DamageEffect;
import Effect.RefireEffect;
import FrequencyTypeEnum.FrequencyTypeEnum;

class MagicDamageModifier extends Modifier
{
	public function new()
	{
		this.effects = new Array<Effect<Dynamic>>();
		this.frequencyType = FrequencyTypeEnum.ON_HIT;
		var damage = new DamageEffect(EffectEnum.DAMAGE, 10);
		effects.push(damage);

		super();
	}
}
