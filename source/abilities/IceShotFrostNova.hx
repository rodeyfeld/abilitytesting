package abilities;

class IceShotFrostNova extends Ability
{
	override public function new()
	{
		this.targetingEnum = AbilityTargetingEnum.MOUSE_ANGLE_INIT;
		super();
	}

	override public function castAbility(x:Float, y:Float):Array<Map<AbilityTargetingEnum, Array<Action>>>
	{
		var newModifiers = new Array<Modifier>();
		var frostNova = new FrostNova();
		newModifiers.push(new BasicRefireModifier(1, frostNova));
		return generateActionMaps(AbilityTargetingEnum.MOUSE_ANGLE_INIT, newModifiers, x, y);
	}
}
