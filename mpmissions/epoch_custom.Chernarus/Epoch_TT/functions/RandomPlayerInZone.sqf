if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith { objNull };

params [['_filter', objNull], ['_iterations', 0]];
private ['_filter', '_iterations'];

if (count Epoch_TT_AllPlayersInZone == 0) exitWith { objnull };

_iterations = _iterations + 1;
if (_iterations > 20) exitWith { objNull };

if (isNull _filter) exitWith {
    (selectRandom Epoch_TT_AllPlayersInZone)
};

_target = (selectRandom Epoch_TT_AllPlayersInZone);
if (_target == _filter) exitWith {
    ([_filter, _iterations] call Epoch_TT_RandomPlayerInZone)
};

_target
