/*
While the mission is running
	Check if player has toolkit
		update marker of bomb
	
	wait for 2 seconds
*/

params ["_bomb", "_player"];

if (side _player == west) exitWith {};

_loop = true;
while {_loop} do {

	if ([_player, "ToolKit"] call BIS_fnc_hasItem) then {
		bombPosition = getPos _player;
		publicVariable "bombPosition";
	};
	
	"markerBomb" setMarkerPosLocal bombPosition;
	
	if (_bomb getVariable "bombState" in [1, 2, 3]) then {
		"markerBomb" setMarkerAlpha 0;
		_loop = false;
	};
	
	sleep 2;
};
