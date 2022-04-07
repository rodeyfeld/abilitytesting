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
	public var newActionStack:GenericStack<Action>;
	public var finishedActionStack:GenericStack<Action>;

	public function new()
	{
		this.newActionStack = new GenericStack<Action>();
		this.finishedActionStack = new GenericStack<Action>();
		this.actions = new FlxTypedGroup<Action>();
	}

	public function addInactiveAction(inactiveAction:Action)
	{
		this.newActionStack.add(inactiveAction);
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
		var closestEnemy:Enemy = enemies.getFirstAlive();
		var closestDifference = Math.POSITIVE_INFINITY;
		enemies.forEach(function(enemy)
		{
			// Get targets that haven't been hit
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
		/* 
			Action handler main logic. If the newActionStack is not empty, the first 
			available is polled. Angle is determined by the ability's targeting enum. 
			A deadzone is then created a certain distance from the current actions coordinates.
			Finally, it is "executed" which sets the actions state to ACTIVE.
		 */
		if (!newActionStack.isEmpty())
		{
			var currAction = newActionStack.pop();
			currAction.setPosition(currAction.trueX, currAction.trueY);
			// var actionPoint = FlxPoint.weak(currAction.trueX, currAction.trueY);
			var finalAngle:Float = 0;
			if (currAction.targetingEnum == AbilityTargetingEnum.MOUSE_ANGLE_INIT)
			{
				finalAngle = mouseAngle;
			}
			else if (currAction.targetingEnum == AbilityTargetingEnum.NEAREST_ENEMY)
			{
				var closestEnemyAngle:Float = FlxAngle.angleBetween(getClosestEnemyToAction(enemies, currAction), currAction, true);
				finalAngle = closestEnemyAngle;
			}
			var distanceX = Math.cos(finalAngle * Math.PI / 180);
			var distanceY = Math.sin(finalAngle * Math.PI / 180);
			currAction.setPosition(currAction.x + distanceX * 20, currAction.y + distanceY * 20);
			actions.add(currAction);
			currAction.velocity.set(3);
			currAction.velocity.rotate(FlxPoint.weak(0, 0), finalAngle);
			currAction.angle = finalAngle + 90;
			currAction.executeAction();
		}
	}
}
