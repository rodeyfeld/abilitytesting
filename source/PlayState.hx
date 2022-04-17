package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxAngle;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:Player;
	var enemies:FlxTypedGroup<Enemy>;
	var allEntities:FlxTypedGroup<Entity>;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var ground:FlxTilemap;

	var mainCam:FlxCamera;
	var camAnchor:FlxObject;

	override public function create()
	{
		super.create();
		// Load basic testing map
		map = new FlxOgmo3Loader(AssetPaths.enigma__ogmo, AssetPaths.sandbox__json);
		walls = map.loadTilemap(AssetPaths.TX_Tileset_Grass__png, "walls");
		ground = map.loadTilemap(AssetPaths.TX_Tileset_Grass__png, "ground");
		FlxG.worldBounds.set(0, 0, walls.width, walls.height);
		add(ground);
		add(walls);

		// Basic initilization
		player = new Player(20, 20);
		add(player);
		add(player.actionHandler.actions);
		player.initHealthBar();

		add(player.healthBar);
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);
		camAnchor = new FlxObject();
		add(camAnchor);
		FlxG.camera.follow(camAnchor, LOCKON, 0.2);
		map.loadEntities(placeEntities, "entities");

		var sprite = new FlxSprite();
		sprite.loadGraphic(AssetPaths.Electric_Effect_05__png, true, 16, 16);
		sprite.setPosition(300, 300);
		trace(sprite.frameWidth, sprite.frameHeight);
		sprite.setSize(16, 16);
		var animationFrames = [0, 1, 2, 3];
		sprite.animation.add("shine", animationFrames, 15, true);
		sprite.animation.play("shine");
		add(sprite);
	}

	function placeEntities(entity:EntityData)
	{
		// Place all entities
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
		else if (entity.name == "enemy")
		{
			var enemy = new Enemy(entity.x, entity.y);
			add(enemy.actionHandler.actions);
			enemy.initHealthBar();
			add(enemy.healthBar);
			enemies.add(enemy);
		}
	}

	function actionCollideEntity(action:Action, entity:Entity)
	{
		entity.modifierHandler.addModifiers(action.modifiers);
		action.kill();
	}

	public function updateCamera()
	{
		// Creates a camera anchor based on a fixed distance from the mouse
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
		// Update loop for camera and actions by enemy and player.
		updateCamera();
		FlxG.overlap(player.actionHandler.actions, enemies, actionCollideEntity);
		for (enemy in enemies)
		{
			// For every enemy, update their action handler

			for (action in enemy.actionHandler.actions)
			{
				// If the action state is ACTIVE, trigger collision check.
				if (action.state == ActionStateEnum.ACTIVE)
				{
					FlxG.overlap(action, enemies, actionCollideEntity);
				}
				// If action state is FINISHED, mark for deletion.
				else if (action.state == ActionStateEnum.FINISHED)
				{
					enemy.actionHandler.removeFinishedAction(action);
				}
			};
			enemy.actionHandler.update(enemy.x, enemy.y, enemies, elapsed);
		}
		var fireAngle:Float = FlxAngle.angleBetweenMouse(player, true);
		player.actionHandler.update(player.x, player.y, enemies, elapsed, fireAngle);

		super.update(elapsed);
	}
}
