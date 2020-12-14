/*
While the mission is running
	Check if player has toolkit
		update marker of bomb
	
	wait for 2 seconds
*/

params ["_bomb", "_player"];

_loop = true;
while {_loop} do {

	if ([_player, "ToolKit"] call BIS_fnc_hasItem) then {
		"markerBomb" setMarkerPos getPos _player;
	};
	
	if (_bomb getVariable "bombState" in [1, 2, 3]) then {
		_loop = false;
	};
	
	sleep 2;
};
