/*
While the mission is running
	Check if player has toolkit
		update marker of bomb
	
	wait for 2 seconds
*/
while {true} do {

	if ([_this select 0, "ToolKit"] call BIS_fnc_hasItem) then {
		"markerBomb" setMarkerPos getPos (_this select 0);
	};
	
	sleep 2;
};