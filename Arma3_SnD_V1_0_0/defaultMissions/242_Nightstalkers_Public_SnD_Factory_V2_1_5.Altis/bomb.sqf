#define UNACTIVATED 0
#define ACTIVATED 1
#define DETONATE 2
#define DEFUSED 3
#define END_GREENFORELIMINATED 0
#define END_BLUFORELIMINATED 1
#define END_BOMBEXPLODED 2
#define END_BOMBDEFUSED 3
#define END_TIMESUP 4

tek_fnc_setActivated = {
    params ["_bomb"];
    ["Bomb has been planted!"] remoteExec ["hint"];
    _bomb setVariable ["bombActivatedTime", time, true];
    _bomb setVariable ["bombState", ACTIVATED, true];
};

tek_fnc_setDefused = {
    params ["_bomb"];
    _bomb setVariable ["bombState", DEFUSED, true];
    ["Bomb has been defused!"] remoteExec ["hint"];
};

tek_fnc_missionEnd = {
	params ["_endType"];
		
	if (isServer) then {
		switch(_endType) do {
			case END_GREENFORELIMINATED: {[] spawn {sleep 3; "endGREENFOREliminated" call BIS_fnc_endMissionServer}};
			case END_BLUFORELIMINATED: {[] spawn {sleep 3; "endBLUFOREliminated" call BIS_fnc_endMissionServer}};
			case END_BOMBEXPLODED: {[] spawn {sleep 3; "endBombExploded" call BIS_fnc_endMissionServer}};
			case END_BOMBDEFUSED: {[] spawn {sleep 3; "endBombDefused" call BIS_fnc_endMissionServer}};
			case END_TIMESUP: {[] spawn {sleep 3; "endTimesUp" call BIS_fnc_endMissionServer}};
		};
		
	};
};

params["_bomb","_time"];

[
    _bomb,                                            // Object the action is attached to
    "Plant Bomb",                                        // Title of the action
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",    // Idle icon shown on screen
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",    // Progress icon shown on screen
    "_this distance _target < 3 && ('ToolKit' in (items _this)) && (_target getVariable ""bombState"" == 0) && side _this == resistance",               /* Condition for the action to be shown */
    "_caller distance _target < 3 && (_target getVariable ""bombState"" == 0)",                        // Condition for the action to progress
    {hint "Planting Bomb"},                                                    // Code executed when action starts
    {},                                                    // Code executed on every progress tick
    {params ["_target", "_caller", "_actionId", "_arguments"]; [_target] remoteExecCall ["tek_fnc_setActivated", 2]},            // Code executed on completion
    {hint "Planting interrupted"},                                                    // Code executed on interrupted
    [],                                                    // Arguments passed to the scripts as _this select 3
    5,                                                    // Action duration [s]
    999,                                                    // Priority
    true,                                                // Remove on completion
    false                                                // Show in unconscious state
] call BIS_fnc_holdActionAdd;

[
    _bomb,                                            // Object the action is attached to
    "Defuse Bomb",                                        // Title of the action
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",    // Idle icon shown on screen
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",    // Progress icon shown on screen
    "_this distance _target < 3 && _target getVariable ""bombState"" == 1 && side _this == west",                  /* Condition for the action to be shown */
    "_caller distance _target < 3 && _target getVariable ""bombState"" == 1",                        // Condition for the action to progress
    {hint "Defusing Bomb"},                                                    // Code executed when action starts
    {},                                                    // Code executed on every progress tick
    {params ["_target", "_caller", "_actionId", "_arguments"]; [_target] remoteExecCall ["tek_fnc_setDefused", 2]},                // Code executed on completion
    {hint "Defusing interrupted"},                                                    // Code executed on interrupted
    [],                                                    // Arguments passed to the scripts as _this select 3
    5,                                                    // Action duration [s]
    998,                                                    // Priority
    true,                                                // Remove on completion
    false                                                // Show in unconscious state
] call BIS_fnc_holdActionAdd;


if (isServer) then {
	_loop = true;
    _bomb setVariable ["bombState", UNACTIVATED, true];

    while {_loop} do {
        switch (_bomb getVariable "bombState") do {
            case UNACTIVATED: {
				if (time > 310) then {
					[END_TIMESUP] remoteExecCall ["tek_fnc_missionEnd", 0];
					_loop = false;
				}
			};
            case ACTIVATED: {
                if (time > (_bomb getVariable "bombActivatedTime") + _time) then {
                    _bomb setVariable ["bombState", DETONATE, true];
                }
            };
            case DETONATE: {
                _bombDet = "Bo_GBU12_LGB" createVehicle getPos bombTrolley;
				[END_BOMBEXPLODED] remoteExecCall ["tek_fnc_missionEnd", 0];
				_loop = false;
            };
            case DEFUSED: {
				[END_BOMBDEFUSED] remoteExecCall ["tek_fnc_missionEnd", 0];
				_loop = false;
			};
        };
        sleep 0.5
    }
}