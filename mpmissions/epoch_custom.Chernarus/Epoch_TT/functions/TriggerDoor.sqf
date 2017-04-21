if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};

params [['_targets', []], ['_targetDoor', objNull], ['_timeout', 1]];

_currentTimeout = _targetDoor getVariable ['Epoch_TT_DoorTimeout', time - _timeout];
if (time - _currentTimeout < _timeout) exitWith {};
_targetDoor setVariable ['Epoch_TT_DoorTimeout', time];

if ((_targetDoor animationPhase "doorl") > 0.25) exitWith {};

playsound3d ['a3\sounds_f\environment\structures\doors\GateDoors\GateSqueak_1.wss', _targetDoor];

_openAnimations = ['door_1_rot', 'door_2_rot'];

switch (typeOf _targetDoor) do {

    case 'Land_Wall_Gate_Ind1_L':
    {
        _openAnimations = ['doorl'];
    };
    case 'Land_Wall_Gate_Ind1_R':
    {
        _openAnimations = ['doorr'];
    };
    default {};
};

{
    _targetDoor animate [_x, 1];
    false
} count _openAnimations > 0;

[_targetDoor, _openAnimations] spawn {

     Sleep 1;
     playsound3d ['a3\sounds_f\environment\structures\doors\GateDoors\GateSqueak_2.wss', _this];

     {
         (_this select 0) animate [_x, 0];
         false
     } count (_this select 1) > 0;

 };
