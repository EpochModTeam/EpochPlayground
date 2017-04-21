if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};

params [ ['_toCheck', []], ['_combination', []], ['_order', false] ];
private ['_toCheck', '_combination', '_array'];

if (count _toCheck == 0 || count _combination == 0) exitWith { false };

// If correct order is required, use simple comparison
if (_order) exitWith {
    (
        (_toCheck select 0) == (_combination select 0) &&
        (_toCheck select 1) == (_combination select 1) &&
        (_toCheck select 2) == (_combination select 2)
    )
};

_array = +_combination;
if ({
    _index = _array find _x;
    if (_index < 0) exitWith { 1 };
    if (_index >= 0) then {
        _array deleteAt _index;
    };
    false
} count _toCheck > 0) exitWith { false };
if (count _array == 0) exitWith { true };

false
