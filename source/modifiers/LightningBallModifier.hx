package modifiers;

import Effect.DamageEffect;
import Effect.RefireEffect;

class LightningBallModifier extends Modifier
{
	public function new()
	{
		this.effects = new Array<Effect>();
		var damage = new DamageEffect(EffectEnum.DAMAGE, 10);
		var refire = new RefireEffect(EffectEnum.REFIRE, 2);
		effects.push(damage);
		effects.push(refire);
	}
}
