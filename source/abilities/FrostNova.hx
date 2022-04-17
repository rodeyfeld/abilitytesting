package abilities;

class FrostNova extends Ability
{
	override public function new()
	{
		this.targetingEnum = AbilityTargetingEnum.NOVA;
		this.capacity = 10;
		super();
	}

	override public function castAbility(x:Float, y:Float):Array<Map<AbilityTargetingEnum, Array<Action>>>
	{
		var newModifiers = new Array<Modifier>();
		var magicDamage = new MagicDamageModifier();
		newModifiers.push(magicDamage);
		return generateActionMaps(AbilityTargetingEnum.NOVA, newModifiers, x, y);
	}
}
