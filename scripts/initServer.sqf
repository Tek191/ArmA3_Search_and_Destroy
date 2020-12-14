//initialise variables
startTimer = true;
publicVariable "startTimer";

//generate random int
randomStart = [0,1] call BIS_fnc_randomInt;
publicVariable "randomStart";

//after 10 seconds update all players to be able to move
[] spawn {sleep 10; startTimer = false; publicVariable "startTimer"; ["Mission started!"] remoteExec ["hint"]};



//Set the position of the table and laptop at the bomb site pos, pos has to be acquired by hand

if (randomStart == 0) then
{
	deleteVehicle defuseDeviceB; deleteVehicle defuseTableB; deleteVehicle bombTrolleyB;
	serverBombSite = defuseDeviceA;
	_scriptA = [[defuseDeviceA, 45], "bomb.sqf"] remoteExecCall ["BIS_fnc_execVM", 0, false];
}
else
{
	deleteVehicle defuseDeviceA; deleteVehicle defuseTableA; deleteVehicle bombTrolleyA;
	serverBombSite = defuseDeviceB;
	_scriptB = [[defuseDeviceB, 45], "bomb.sqf"] remoteExecCall ["BIS_fnc_execVM", 0, false];
};
