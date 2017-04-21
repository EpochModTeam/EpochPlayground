if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};

params ['_source', ['_target', objnull]];

if (isNull _target) exitWith {};

if (_source distance _target > 2.5) exitWith {};

Epoch_TT_SecurityActive = !Epoch_TT_SecurityActive;

if (Epoch_TT_SecurityActive) then {
    playSound3D ["a3\sounds_f\sfx\alarmCar.wss", _source];
} else {
    playSound3D ["a3\sounds_f\sfx\alarm.wss", _source];
};
