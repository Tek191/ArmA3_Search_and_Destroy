startTimer = true;
publicVariable "startTimer";

randomStart = [0,1] call BIS_fnc_randomInt;
publicVariable "randomStart";

[] spawn {sleep 10; startTimer = false; publicVariable "startTimer"; ["Mission started!"] remoteExec ["hint"]};



//Set the position of the table and laptop at the bomb site pos, pos has to be acquired by hand

if (randomStart == 0) then
{
	defuseTable setPos [6158.309, 16281.55, 0.055]; 
	defuseDevice setPos [6158.213, 16281.56, 0.871]; 
	bombTrolley setPos [6162.402, 16278.23, 0.059]; 
}
else
{
	defuseTable setPos [6153.9, 16212.622, 0.263];   
	defuseDevice setPos [6153.804, 16212.63, 1.079];  
	bombTrolley setPos [6161.283, 16211.21, 0.259]; 
};
