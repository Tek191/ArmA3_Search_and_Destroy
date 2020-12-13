startTimer = true;
publicVariable "startTimer";

randomStart = [0,1] call BIS_fnc_randomInt;
publicVariable "randomStart";

[] spawn {sleep 10; startTimer = false; publicVariable "startTimer"; ["Mission started!"] remoteExec ["hint"]};



//Set the position of the table and laptop at the bomb site pos, pos has to be acquired by hand

if (randomStart == 0) then
{
	deleteVehicle defuseDeviceB; deleteVehicle defuseTableB; deleteVehicle bombTrolleyB; _script = [defuseDeviceA, 45] execVM "bomb.sqf";
}
else
{
	deleteVehicle defuseDeviceA; deleteVehicle defuseTableA; deleteVehicle bombTrolleyA; _script = [defuseDeviceB, 45] execVM "bomb.sqf";
};
