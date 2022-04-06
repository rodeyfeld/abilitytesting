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

	function getClosestEnemyToAction(action:Action, enemies:FlxTypedGroup<Enemy>)
	{
		var closestEnemy:Enemy = enemies.getFirstAlive();
		var closestDifference = Math.POSITIVE_INFINITY;
		enemies.forEach(function(enemy)
		{
			if (enemy.tags.get(TagEnum.REFIRED) != 1)
			{
				var currentDistance:Float = FlxMath.distanceBetween(enemy, action);
				if (closestDifference < currentDistance)
				{
					closestEnemy = enemy;
				}
			}
		});
		return closestEnemy;
	}

	public function update(x:Float, y:Float, enemies:FlxTypedGroup<Enemy>, elapsed:Float, mouseAngle:Float = 0)
	{
		// TODO: CLEAN THIS UP / MOVE TO ACTION CLASS
		if (!actionStack.isEmpty())
		{
			var currAction = actionStack.pop();
			var finalAngle:Float = 0;
			if (currAction.targetingEnum == AbilityTargetingEnum.MOUSE_ANGLE_INIT)
			{
				finalAngle = mouseAngle;
			}
			else if (currAction.targetingEnum == AbilityTargetingEnum.NEAREST_ENEMY)
			{
				var closestEnemyAngle:Float = FlxAngle.angleBetween(currAction, getClosestEnemyToAction(currAction, enemies), true);
				finalAngle = closestEnemyAngle;
			}
			var distanceX = Math.cos(finalAngle * Math.PI / 180);
			var distanceY = Math.sin(finalAngle * Math.PI / 180);
			currAction.setPosition(currAction.x + distanceX * 20, currAction.y + distanceY * 20);
			currAction.velocity.set(20);
			currAction.velocity.rotate(FlxPoint.weak(0, 0), finalAngle);
			currAction.angle = mouseAngle + 90;
			// trace(currAction.)
			actions.add(currAction);

			// for (action in actions)
			// {
			// 	trace(action.ID, action.alive);
			// }
			currAction.executeAction();
		}
	}
}
