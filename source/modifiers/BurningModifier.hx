package modifiers;

import Effect.DamageEffect;
import Effect.RefireEffect;
import FrequencyTypeEnum.FrequnceyTypeEnum;

class BurningModifier extends Modifier
{
	public function new()
	{
		this.effects = new Array<Effect<Dynamic>>();
		this.frequencyType = FrequnceyTypeEnum.INTERVAL;
		this.endTimer = 5;
		this.intervalTick = 1;
		this.readyTimer = 0;
		var damage = new DamageEffect(EffectEnum.DAMAGE, 10);
		effects.push(damage);

		super();
	}
}
