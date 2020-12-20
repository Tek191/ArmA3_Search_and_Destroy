_player = _this select 0;

_maxTimer = 5;
_currentTimer = _maxTimer;

while {triggerActivated triggerBLUFORPlayArea && _currentTimer >= 0} do {
		
		hint ("RETURN TO THE AO: " + str(_currentTimer));
		
		sleep 1;
		
		_currentTimer = _currentTimer - 1;
		
		if (_currentTimer < 0) then {
			_player setDamage 1;
		};
};

