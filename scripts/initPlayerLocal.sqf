triggerBLUFORPlayArea setTriggerInterval 2;

bombPosition = [0, 0, 0];


//Briefing for all players
player createDiaryRecord ["Diary", ["Search and Destroy","
	<br/>BLUFOR: Defend the bomb site at the red marker for 6 minutes. Eliminate the INDEPENDENT before they plant the bomb. If the bomb is planted you have 40 seconds to defuse the bomb (takes 5 seconds to defuse). 
	<br/>
	<br/>INDEPENDENT: Locate the bomb at one of the yellow markers on the map. Either plant the bomb (takes 5 seconds and requires Toolkit) or eliminate BLUFOR.
	<br/>
	<br/>MEDICAL SYSTEM: Vanilla, Advanced Incapacitation - Headshots always kill ect, player bleeds out after 60 seconds 
	<br/>
	<br/>START OF ROUND: Everyone can't move for the first 10 seconds, then the round lasts 6 minutes (unless the bomb is planted, which extends the round by 45 seconds). The dead become spectators. BLUFOR is not allowed to cross the red line on the map.
"]];

//Creates new sub briefing type
player createDiarySubject ["missionSettings","Mission Settings"];

//Briefing for all players
player createDiaryRecord ["missionSettings", ["Mission Settings","
	<br/>Start Time: 10 seconds
	<br/>Mission Time (Without Plant, includes Start Time): 370 seconds 
	<br/>Bomb Plant Requirements: Toolkit and Player is INDEPENDENT
	<br/>Bomb Defuse Requirements: Player is BLUFOR
"]];


/*
When the server initialises variables then
	
	If player is BLUFOR
		Hide the wrong bombsite and make the other one red
		Hide the bomb marker
*/
[] spawn {waitUntil{!isNil "randomStart"};

	if (side player == west) then {
		switch (randomStart) do {
			case 0: {"markerBombSiteB" setMarkerAlphaLocal 0; "markerBombSiteA" setMarkerColorLocal "ColorRed"};
			case 1: {"markerBombSiteA" setMarkerAlphaLocal 0; "markerBombSiteB" setMarkerColorLocal "ColorRed"};
		};
		
		"markerBomb" setMarkerAlphaLocal 0;
		
	};
	
	if (randomStart == 0) then {
		[defuseDeviceA, player] execVM "updateBombMarker.sqf";
	}
	else
	{
		[defuseDeviceB, player] execVM "updateBombMarker.sqf";
	};

};


//When mission starts freeze all players for 10 seconds
["checkMissionStarted", "onPreloadFinished", {

	if (startTimer) then {
		player enableSimulation false;
	};

	[] spawn{waitUntil{!startTimer}; player enableSimulation true;
};

}] call BIS_fnc_addStackedEventHandler;

