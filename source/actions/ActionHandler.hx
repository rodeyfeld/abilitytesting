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
	public var newActionGroupQueue:ArrayedQueue<Map<AbilityTargetingEnum, Array<Action>>>;
	public var finishedActionQueue:ArrayedQueue<Action>;

	public function new()
	{
		this.newActionGroupQueue = new ArrayedQueue<Map<AbilityTargetingEnum, Array<Action>>>();
		this.finishedActionQueue = new ArrayedQueue<Action>();
		this.actions = new FlxTypedGroup<Action>();
	}

	public function addInactiveAction(inactiveActionGroup:Map<AbilityTargetingEnum, Array<Action>>)
	{
		this.newActionGroupQueue.enqueue(inactiveActionGroup);
	}

	public function addInactiveActions(newInactiveActions:Array<Map<AbilityTargetingEnum, Array<Action>>>)
	{
		for (inactiveActionGroup in newInactiveActions)
		{
			addInactiveAction(inactiveActionGroup);
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
			else
			{
				enemy.tags.set(TagEnum.REFIRED, 0.0);
			}
		});
		return closestEnemy;
	}

	function fireAction(action:Action, angle:Float)
	{
		// Convert to radians/polar for distance
		var distanceX = Math.cos(angle * (Math.PI / 180)) * 20;
		var distanceY = Math.sin(angle * (Math.PI / 180)) * 20;
		// Update position to accommodate deadzone
		action.setPosition(action.x + distanceX, action.y + distanceY);
		// Set velocity
		action.velocity.set(50);
		// Rotate sprite to angle
		action.velocity.rotate(FlxPoint.weak(0, 0), angle);
		action.angle = angle + 90;
		action.executeAction();
		actions.add(action);
	}

	public function update(x:Float, y:Float, enemies:FlxTypedGroup<Enemy>, elapsed:Float, mouseAngle:Float = 0)
	{
		/* 
			Action handler main logic. If the newActionGroupQueue is not empty, the first 
			available is polled. Angle is determined by the ability's targeting enum. 
			A deadzone is then created a certain distance from the current actions coordinates.
			Finally, it is "executed" which sets the actions state to ACTIVE.
		 */
		if (!newActionGroupQueue.isEmpty())
		{
			// TODO: Condense this code / break up into functions
			var currActionGroup = newActionGroupQueue.dequeue();
			// var actionPoint = FlxPoint.weak(currAction.trueX, currAction.trueY);
			var finalAngle:Float = 0;
			if (currActionGroup.get(AbilityTargetingEnum.MOUSE_ANGLE_INIT) != null)
			{
				for (action in currActionGroup.get(AbilityTargetingEnum.MOUSE_ANGLE_INIT))
				{
					trace(action);
					finalAngle = mouseAngle;
					fireAction(action, finalAngle);
				}
			}
			else if (currActionGroup.get(AbilityTargetingEnum.NEAREST_ENEMY) != null)
			{
				for (action in currActionGroup.get(AbilityTargetingEnum.NEAREST_ENEMY))
				{
					trace(action);
					var closestEnemy:Enemy = getClosestEnemyToAction(enemies, action);
					// If no enemies are available, terminate and return
					if (closestEnemy == null)
					{
						action.kill();
						return;
					}
					var closestEnemyAngle:Float = FlxAngle.angleBetween(action, closestEnemy, true);
					finalAngle = closestEnemyAngle;
					fireAction(action, finalAngle);
				}
			}
			else if (currActionGroup.get(AbilityTargetingEnum.NOVA) != null)
			{
				var actionGroupLength = currActionGroup.get(AbilityTargetingEnum.NOVA).length;
				for (action in currActionGroup.get(AbilityTargetingEnum.NOVA))
				{
					finalAngle += 360 / actionGroupLength;
					fireAction(action, finalAngle);
				}
			}
		}
	}
}
