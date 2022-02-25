package actions;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class ActionHandler
{
	public var actions:Map<ActionStateEnum, FlxTypedGroup<Action>>;
	public var waitingForTarget:Bool;

	public function new()
	{
		this.actions = new Map<ActionStateEnum, FlxTypedGroup<Action>>();
		var inactiveActions = new FlxTypedGroup<Action>();
		var activeActions = new FlxTypedGroup<Action>();
		actions[ActionStateEnum.INACTIVE] = inactiveActions;
		actions[ActionStateEnum.ACTIVE] = activeActions;
	}

	public function addInactiveAction(inactiveAction:Action)
	{
		this.actions[ActionStateEnum.INACTIVE].add(inactiveAction);
	}

	public function addInactiveActions(newInactiveActions:Array<Action>)
	{
		for (inactiveAction in newInactiveActions)
		{
			addInactiveAction(inactiveAction);
		}
	}

	public function addActiveAction(activeAction:Action)
	{
		this.actions[ActionStateEnum.ACTIVE].add(activeAction);
	}

	public function addActiveActions(newActiveActions:Array<Action>)
	{
		for (activeAction in newActiveActions)
		{
			addActiveAction(activeAction);
		}
	}

	function getClosestEnemyToAction(action:Action, enemies:FlxTypedGroup<Enemy>)
	{
		var closestEnemy:Enemy = null;
		var closestDifference = Math.POSITIVE_INFINITY;
		enemies.forEach(function(enemy)
		{
			var currentDistance:Float = FlxMath.distanceBetween(enemy, action);
			if (closestEnemy != null && closestDifference < currentDistance)
			{
				closestEnemy = enemy;
			}
			else
			{
				closestEnemy = enemy;
			}
		});
		return closestEnemy;
	}

	public function update(x:Float, y:Float, enemies:FlxTypedGroup<Enemy>, elapsed:Float, mouseAngle:Float = 0)
	{
		for (action in this.actions[ActionStateEnum.INACTIVE])
		{
			if (action.targetingEnum == AbilityTargetingEnum.MOUSE_ANGLE_INIT)
			{
				action.velocity.rotate(FlxPoint.weak(0, 0), mouseAngle);
			}
			else if (action.targetingEnum == AbilityTargetingEnum.NEAREST_ENEMY)
			{
				var closestEnemyAngle:Float = FlxAngle.angleBetween(action, getClosestEnemyToAction(action, enemies), true);
				action.velocity.rotate(FlxPoint.weak(0, 0), closestEnemyAngle);
			}
		}
	}
}
