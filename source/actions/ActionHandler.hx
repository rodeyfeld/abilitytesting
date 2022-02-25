package actions;

import flixel.group.FlxGroup.FlxTypedGroup;

class ActionHandler
{
	public var inactiveActions:FlxTypedGroup<Action>;
	public var activeActions:FlxTypedGroup<Action>;

	public function new(activeActions:FlxTypedGroup<Action>, inactiveActions:FlxTypedGroup<Action>)
	{
		this.activeActions = activeActions;
		this.inactiveActions = inactiveActions;
	}

	public function addInactiveAction(inactiveAction:Action)
	{
		this.inactiveActions.add(inactiveAction);
	}

	public function addInactiveActions(newInactiveActions:FlxTypedGroup<Action>)
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

	public function addActiveActions(newActiveActions:FlxTypedGroup<Action>)
	{
		for (activeAction in newActiveActions)
		{
			addActiveAction(activeAction);
		}
	}

	public function update(elapsed:Float)
	{
		for (action in this.inactiveActions) {}
	}
}
