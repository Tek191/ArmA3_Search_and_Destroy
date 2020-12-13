params ["_bomb"];

_counter = 44;

sleep 1;

while {_counter >= 0} do {
		
	if (_bomb getVariable "bombState" == 1) then {
	
		hint str(_counter);
		_counter = _counter - 1;
		sleep 1;
	};
};