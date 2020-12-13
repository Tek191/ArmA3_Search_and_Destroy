Place these into your mission folder alongside the 'mission.sqm' file: [initServer.sqf, init.sqf, initPlayerLocal.sqf, description.ext, bomb.sqf].


Code to change (ei bombsite locations):

initServer.sqf
	Nothing

init.sqf
	Line 1: The modpack assumes you are using ACRE2 and ensures the two teams can't understand each other
	ingame. If you are using TFAR you have to delete this.

description.ext
	Nothing

bomb.sqf 
	Nothing

updateBombMarker.sqf
	Nothing


Code you can change (ei length of bomb plant):

initServer.sqf
	Line 7:	Length of start timer where players can't move, default 10

init.sqf
	Nothing

description.ext
	Nothing

bomb.sqf
	Line 29-33: Length of time before mission ends, default 3
	
	Line 53: Bomb Plant timer, default 5

	Line 71: Bomb Defuse timer, default 5
	
	Line 85: Round time length, should equal the start timer + round length time, default 370 (10 + 360)
	
	Line 105: Frequency of script updating, higher is more accurate but lowers performance, default 0.5

updateBombMarker.sqf
	Nothing


You can change the loadouts of the units in the editor either via scripts or by accessing the arsenal.