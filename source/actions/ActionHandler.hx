package actions;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;

class ActionHandler
{
	public var inactiveActions:FlxTypedGroup<Action>;
	public var activeActions:FlxTypedGroup<Action>;
	public var waitingForTarget:Bool;

	public function new(activeActions:FlxTypedGroup<Action>, inactiveActions:FlxTypedGroup<Action>)
	{
		this.activeActions = activeActions;
		this.inactiveActions = inactiveActions;
	}

	public function addInactiveAction(inactiveAction:Action)
	{
		this.inactiveActions.add(inactiveAction);
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
		this.activeActions.add(activeAction);
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

	public function update(x:Float, y:Float, elapsed:Float)
	{
		for (action in this.inactiveActions)
		{
			if (action.targetingEnum == AbilityTargetingEnum.MOUSE_ANGLE_INIT) {}
		}
	}
}
