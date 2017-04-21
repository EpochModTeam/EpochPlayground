if (!isServer) exitWith {};

{

    _didJump = _x getVariable ['Epoch_TT_JumpedFromTop', false];
    _alreadyCompleted = _x getVariable ['Epoch_TT_TowerComplete', false];

    if (
        _didJump &&
        !_alreadyCompleted &&
        alive _x
    ) then {

        playSound3D ["A3\sounds_f\sfx\alarm_blufor.wss", _x];
        _x setVariable ['Epoch_TT_TowerComplete', true];

        _x spawn {

            Sleep (random 3) + 2;

            _target = [_this] call Epoch_TT_RandomPlayerInZone;
            if (!isNull _target) then {
                [_target, true] call Epoch_TT_SpawnLightning;
            };

        };

    };

    false

} count _this > 0;
