package actions;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import haxe.ds.GenericStack;

class ActionHandler
{
	public var actions:FlxTypedGroup<Action>;
	public var waitingForTarget:Bool;
	public var actionStack:GenericStack<Action>;

	public function new()
	{
		this.actionStack = new GenericStack<Action>();
		this.actions = new FlxTypedGroup<Action>();
		var inactiveActions = new FlxTypedGroup<Action>();
		var activeActions = new FlxTypedGroup<Action>();
		// actions[ActionStateEnum.INACTIVE] = inactiveActions;
		// actions[ActionStateEnum.ACTIVE] = activeActions;
	}

	public function addInactiveAction(inactiveAction:Action)
	{
		this.actionStack.add(inactiveAction);
	}

	public function addInactiveActions(newInactiveActions:Array<Action>)
	{
		for (inactiveAction in newInactiveActions)
		{
			addInactiveAction(inactiveAction);
		}
	}

	// public function addActiveAction(activeAction:Action)
	// {
	// 	this.actions[ActionStateEnum.ACTIVE].add(activeAction);
	// }
	// public function addActiveActions(newActiveActions:Array<Action>)
	// {
	// 	for (activeAction in newActiveActions)
	// 	{
	// 		addActiveAction(activeAction);
	// 	}
	// }

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
		if (!actionStack.isEmpty())
		{
			var currAction = actionStack.pop();
			actions.add(currAction);
			currAction.executeAction();
			trace(currAction.ID, currAction, currAction.targetingEnum);
			if (currAction.targetingEnum == AbilityTargetingEnum.MOUSE_ANGLE_INIT)
			{
				currAction.velocity.rotate(FlxPoint.weak(0, 0), mouseAngle);
				currAction.angle = mouseAngle + 90;
			}
			else if (currAction.targetingEnum == AbilityTargetingEnum.NEAREST_ENEMY)
			{
				var closestEnemyAngle:Float = FlxAngle.angleBetween(currAction, getClosestEnemyToAction(currAction, enemies), true);
				currAction.velocity.rotate(FlxPoint.weak(0, 0), closestEnemyAngle);
			}
			currAction.velocity.rotate(FlxPoint.weak(0, 0), mouseAngle);
		}
	}
}
