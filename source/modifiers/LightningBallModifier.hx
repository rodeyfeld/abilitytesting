package modifiers;

import Effect.DamageEffect;
import Effect.RefireEffect;

class LightningBallModifier extends Modifier
{
	public function new()
	{
		this.effects = new Array<Effect>();

		var damage = new DamageEffect(EffectEnum.DAMAGE, 10);
		effects.push(damage);

		var newModifiers = new Array<Modifier>();
		var newDamage = DamageEffect(EffectEnum.DAMAGE, 10);
		newModifiers.push(newDamage);
		var chainLightning = new Ability(newModifiers, 2);

		var refire = new RefireEffect(EffectEnum.REFIRE, chainLightning);
		effects.push(refire);
	}
}
