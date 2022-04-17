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
		var actionGroup = new Array<Action>();
		for (_ in 0...this.capacity)
		{
			var newModifiers = new Array<Modifier>();
			newModifiers.push(new BurningModifier());
			var action = new Action(newModifiers, x, y, this.targetingEnum);
			actionGroup.push(action);
		}
		return generateActionMaps(actionGroup);
	}
}
