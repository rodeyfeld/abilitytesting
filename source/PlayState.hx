package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:Player;
	var playerActions:FlxTypedGroup<Action>;
	var enemyActions:FlxTypedGroup<Action>;
	var enemies:FlxTypedGroup<Enemy>;
	var allEntityActions:FlxTypedGroup<FlxTypedGroup<Action>>;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var ground:FlxTilemap;
	var healthBar:FlxBar;
	var mainCam:FlxCamera;
	var camAnchor:FlxObject;

	override public function create()
	{
		super.create();
		map = new FlxOgmo3Loader(AssetPaths.enigma__ogmo, AssetPaths.sandbox__json);
		walls = map.loadTilemap(AssetPaths.TX_Tileset_Grass__png, "walls");
		ground = map.loadTilemap(AssetPaths.TX_Tileset_Grass__png, "ground");
		FlxG.worldBounds.set(0, 0, walls.width, walls.height);
		add(ground);
		add(walls);

		playerActions = new FlxTypedGroup<Action>();
		player = new Player(20, 20, playerActions);
		add(player);
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);
		add(playerActions);
		allEntityActions = new FlxTypedGroup<FlxTypedGroup<Action>>();
		allEntityActions.add(playerActions);

		camAnchor = new FlxObject();
		add(camAnchor);
		FlxG.camera.follow(camAnchor, LOCKON, 0.2);

		map.loadEntities(placeEntities, "entities");

		healthBar = new FlxBar(0, 0, LEFT_TO_RIGHT, 20, 6, player, "health", 0, 100, true);
		healthBar.createFilledBar(FlxColor.RED, FlxColor.GREEN, true);
		healthBar.trackParent(-6, 15);
		add(healthBar);
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
		else if (entity.name == "enemy")
		{
			enemyActions = new FlxTypedGroup<Action>();
			var enemy = new Enemy(entity.x, entity.y, enemyActions);
			add(enemyActions);
			allEntityActions.add(enemyActions);
			enemies.add(enemy);
			// add(enemy.enemyHealthBar);
		}
	}

	function actionCollideEntity(playerAction:Action, entity:Entity)
	{
		entity.modifierHandler.addModifiers(playerAction.modifiers);
		playerAction.kill();
	}

	function getClosestEnemyToAction(action:Action)
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

	public function updateCamera()
	{
		var diffX = FlxG.mouse.screenX - (FlxG.width / 2);
		var diffY = FlxG.mouse.screenY - (FlxG.height / 2);
		var angle = Math.atan2(diffY, diffX);
		var distance = Math.sqrt(diffX * diffX + diffY * diffY);
		distance *= 0.2;
		var distanceX = Math.cos(angle) * distance;
		var distanceY = Math.sin(angle) * distance;
		camAnchor.x = distanceX + player.x;
		camAnchor.y = distanceY + player.y;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		updateCamera();
		FlxG.overlap(playerActions, enemies, actionCollideEntity);
		allEntityActions.forEach(function(actionTypedGroup)
		{
			actionTypedGroup.forEach(function(action)
			{
				if (action.targetingEnum == AbilityTargetingEnum.NEAREST_ENEMY && action.state == ActionStateEnum.INACTIVE)
				{
					trace("Adujsting");
					var fireAngle = FlxAngle.angleBetween(action, getClosestEnemyToAction(action), true);
					action.angle = fireAngle;
				}
				else if (action.targetingEnum == AbilityTargetingEnum.MOUSE_ANGLE_INIT && action.state == ActionStateEnum.INACTIVE)
				{
					var fireAngle = FlxAngle.angleBetweenMouse(player, true);
					action.angle = fireAngle;
				}
			});
		});
	}
}
