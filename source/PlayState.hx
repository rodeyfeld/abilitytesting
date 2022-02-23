package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:Player;
	var playerActions:FlxTypedGroup<Action>;
	var enemyActions:FlxTypedGroup<Action>;
	var enemies:FlxTypedGroup<Enemy>;

	override public function create()
	{
		playerActions = new FlxTypedGroup<Action>();
		enemyActions = new FlxTypedGroup<Action>();
		player = new Player(20, 20, playerActions);
		var enemy:Enemy = new Enemy(80, 80, enemyActions);
		add(player);
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);
		enemies.add(enemy);
		add(playerActions);
		add(enemyActions);
	}

	function actionCollideEntity(playerAction:Action, entity:Entity)
	{
		entity.modifierHandler.addModifiers(playerAction.modifiers);
		playerAction.kill();
	}

	override public function update(elapsed:Float)
	{
		FlxG.overlap(playerActions, enemies, actionCollideEntity);

		super.update(elapsed);
	}
}
