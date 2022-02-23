package modifiers;

import Effect.DamageEffect;
import Effect.RefireEffect;

class LightningBallModifier extends Modifier
{
	public function new(capacity)
	{
		this.effects = new Array<Effect<Dynamic>>();

		var damage = new DamageEffect(EffectEnum.DAMAGE, 10);
		effects.push(damage);

		if (capacity > 0)
		{
			var chainLightning = new ChainLightning(capacity - 1);
			var refire = new RefireEffect(EffectEnum.REFIRE, chainLightning);
			effects.push(refire);
		}
	}
}
