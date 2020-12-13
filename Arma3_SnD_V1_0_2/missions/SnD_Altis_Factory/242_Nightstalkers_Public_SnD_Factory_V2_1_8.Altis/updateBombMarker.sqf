while {true} do {

	if ([_this select 0, "ToolKit"] call BIS_fnc_hasItem) then {
		"markerBomb" setMarkerPos getPos (_this select 0);
	};
	
	sleep 2;
};