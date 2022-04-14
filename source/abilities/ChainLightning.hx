package abilities;

import actions.ProjectileAction;
import modifiers.LightningBallModifier;
import visualeffects.VisualEffect;

class ChainLightning extends Ability
{
	override public function new(capacity:Int)
	{
		this.targetingEnum = AbilityTargetingEnum.MOUSE_ANGLE_INIT;
		super(capacity);
	}

	override public function castAbility(x:Float, y:Float):Array<Map<AbilityTargetingEnum, Array<Action>>>
	{
		var newModifiers = new Array<Modifier>();
		newModifiers.push(new LightningBallModifier(this.capacity));

		var vfx = new VisualEffect("LightningBall", AssetPaths.Electric_Effect_05__png, 15, true, 6, true);
		var vfxArray = new Array<VisualEffect>();
		vfxArray.push(vfx);

		var newActionMaps = new Array<Map<AbilityTargetingEnum, Array<Action>>>();

		var action = new Action(newModifiers, x, y, targetingEnum);
		action.visualEffects.set(ActionStateEnum.ACTIVE, vfxArray);
		var actionGroup = new Array<Action>();
		actionGroup.push(action);
		var actionMap = new Map<AbilityTargetingEnum, Array<Action>>();
		actionMap.set(this.targetingEnum, actionGroup);
		newActionMaps.push(actionMap);
		return newActionMaps;
	}
}
