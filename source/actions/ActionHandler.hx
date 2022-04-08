package actions;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import polygonal.ds.ArrayedQueue;

class ActionHandler
{
	public var actions:FlxTypedGroup<Action>;
	public var waitingForTarget:Bool;
	public var newActionQueue:ArrayedQueue<Action>;
	public var finishedActionQueue:ArrayedQueue<Action>;

	public function new()
	{
		this.newActionQueue = new ArrayedQueue<Action>();
		this.finishedActionQueue = new ArrayedQueue<Action>();
		this.actions = new FlxTypedGroup<Action>();
	}

	public function addInactiveAction(inactiveAction:Action)
	{
		this.newActionQueue.enqueue(inactiveAction);
	}

	public function addInactiveActions(newInactiveActions:Array<Action>)
	{
		for (inactiveAction in newInactiveActions)
		{
			addInactiveAction(inactiveAction);
		}
	}

	public function removeFinishedAction(action:Action)
	{
		actions.remove(action);
	}

	function getClosestEnemyToAction(enemies:FlxTypedGroup<Enemy>, action:Action)
	{
		var closestEnemy:Enemy = null;
		var closestDifference = Math.POSITIVE_INFINITY;
		enemies.forEach(function(enemy)
		{
			// If target hasn't been hit, skip
			if (enemy.tags.get(TagEnum.REFIRED) != 1.0)
			{
				var currentDistance:Float = FlxMath.distanceBetween(action, enemy);
				if (currentDistance < closestDifference)
				{
					closestEnemy = enemy;
					closestDifference = currentDistance;
				}
			}
		});

		return closestEnemy;
	}

	public function update(x:Float, y:Float, enemies:FlxTypedGroup<Enemy>, elapsed:Float, mouseAngle:Float = 0)
	{
		/* 
			Action handler main logic. If the newActionQueue is not empty, the first 
			available is polled. Angle is determined by the ability's targeting enum. 
			A deadzone is then created a certain distance from the current actions coordinates.
			Finally, it is "executed" which sets the actions state to ACTIVE.
		 */
		if (!newActionQueue.isEmpty())
		{
			var currAction = newActionQueue.dequeue();
			// var actionPoint = FlxPoint.weak(currAction.trueX, currAction.trueY);
			var finalAngle:Float = 0;
			if (currAction.targetingEnum == AbilityTargetingEnum.MOUSE_ANGLE_INIT)
			{
				finalAngle = mouseAngle;
			}
			else if (currAction.targetingEnum == AbilityTargetingEnum.NEAREST_ENEMY)
			{
				var closestEnemy:Enemy = getClosestEnemyToAction(enemies, currAction);
				var closestEnemyAngle:Float = FlxAngle.angleBetween(currAction, closestEnemy, true);

				finalAngle = closestEnemyAngle;
			}

			// Constant values used until bug figured out.

			// Convert to radians/polar for distance
			var distanceX = Math.cos(finalAngle * (Math.PI / 180)) * 20;
			var distanceY = Math.sin(finalAngle * (Math.PI / 180)) * 20;
			// Update position to accommodate deadzone
			currAction.setPosition(currAction.x + distanceX, currAction.y + distanceY);
			// Set velocity
			currAction.velocity.set(50);
			// Rotate sprite to angle
			currAction.velocity.rotate(FlxPoint.weak(0, 0), finalAngle);
			currAction.angle = finalAngle + 90;
			currAction.executeAction();
			actions.add(currAction);
		}
	}
}
