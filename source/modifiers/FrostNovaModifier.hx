// package modifiers;
// import Effect.DamageEffect;
// import Effect.RefireEffect;
// import FrequencyTypeEnum.FrequnceyTypeEnum;
// class FrostNovaModifier extends Modifier
// {
// 	public function new(capacity:Int)
// 	{
// 		this.effects = new Array<Effect<Dynamic>>();
// 		this.frequencyType = FrequnceyTypeEnum.ON_HIT;
// 		var damage = new DamageEffect(EffectEnum.DAMAGE, 20);
// 		effects.push(damage);
// 		if (capacity > 0)
// 		{
// 			var frostNova = new ChainLightning(capacity - 1);
// 			chainLightning.targetingEnum = AbilityTargetingEnum.NEAREST_ENEMY;
// 			var refire = new RefireEffect(EffectEnum.REFIRE, chainLightning);
// 			effects.push(refire);
// 		}
// 		super(capacity);
// 	}
// }
