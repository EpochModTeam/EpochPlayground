if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};

params [

    ['_targets', []],
    ['_launcher', objNull],
    ['_fireAtPlayer', true],
    ['_properties',
        // Accuracy, Volley, Speed, MinDelay, RangeProfile
        [
            1,
            5,
            0.75,
            [-7, -2, 12, 25]
        ]
    ],
    ['_fireCondition', { true }]
];

if (count _targets == 0 || isNull _launcher) exitWith {};

_accuracy = (1 - (_properties select 0)) max 0.01;
_volley = (_properties select 1) max 1;
_delay = (_properties select 2) max 1;
_rangeProfile =  (_properties select 3);

// Barrel launcher profiles for testing
// Top
/*_accuracy = 0.1;
_volley = 4;
_delay = 3;
_rangeProfile = [35, 10, 35, 17];*/

//Mid
/*_accuracy = 0.3;
_volley = 4;
_delay = 3;
_rangeProfile = [35, 10, 30, 22];*/

//Bottom
/*_accuracy = 0.8;
_volley = 5;
_delay = 2.5;
_rangeProfile = [35, 10, 30, 22];*/

// Per launcher rate limiting
if !(call _fireCondition) exitWith {};

_lastLaunch = _launcher getVariable ['Epoch_TT_LastBallSpawn', time - _delay];

if (time - _lastLaunch < _delay || Epoch_TT_ActiveBarrels > Epoch_TT_MaxActiveBarrels) exitWith {};
_launcher setVariable ['Epoch_TT_LastBallSpawn', time];

_barrelSpawnPoint = _launcher getVariable ['Epoch_TT_LaunchPoint', []];
if (count _barrelSpawnPoint == 0) then {
    _barrelSpawnPoint = _launcher modelToWorld [0,-2,-0.5];
    _barrelSpawnPoint = _barrelSpawnPoint vectorAdd [0,0,0];
    _launcher setVariable ['Epoch_TT_LaunchPoint', _barrelSpawnPoint];
};

// Array used for cleanup
_itemsToDespawn = [];

// Select a random alive player (not unconscious) as a target
_alivePlayers = [];
{
    if (
        alive _x &&
        animationState player != "unconscious"
    ) then { _alivePlayers pushbackunique _x; };
    false
} count _targets;

if (count _alivePlayers == 0) exitWith {};
_playerTarget = selectRandom _alivePlayers;

Epoch_TT_ActiveBarrels = Epoch_TT_ActiveBarrels + 1;

// Spawn individual barrels, target player with random speed and adjust direction to miss occasionally
for "_i" from 0 to (_volley - 1) step 1 do {
    _barrel = createVehicle ["Land_WaterBarrel_F", _barrelSpawnPoint, [], 0, "FLY"];
    _barrel disableCollisionWith _launcher;
    _barrel setPos _barrelSpawnPoint;
    _barrel setVectorUp [random 1, random 1, random 1];

    _vel = velocity _barrel;
    _playerPos = _playerTarget modelToWorld [0,0,0.5];
    _targetPos = _playerPos vectorAdd (velocity _playerTarget);

    if (_fireAtPlayer) then {

        _sourcePos = _barrelSpawnPoint;
        _targetPos = (_playerTarget modelToWorld [0,0,0.25]) vectorAdd (velocity _playerTarget);

        // Adjust final position based on accuracy property
        _targetPos = _targetPos vectorAdd [
            ((random 10) - 5) * _accuracy,
            ((random 10) - 5) * _accuracy,
            0
        ];

        _range = _sourcePos distance _targetPos;
        _heading = [_sourcePos, _targetPos] call BIS_fnc_vectorFromXToY;

        // Use custom range profile so it fires faster for targets further away
        _speed = linearConversion [(_rangeProfile select 0), (_rangeProfile select 1), _range, (_rangeProfile select 2), (_rangeProfile select 3)];
        _velocity = [_heading, _speed] call BIS_fnc_vectorMultiply;

        _barrel setVelocity _velocity;

    } else {

        _dirTo = getDir _launcher;
        _speed = 10 + random 5;
        _barrel setvelocity [(_vel select 0) - _speed * (sin _dirTo),(_vel select 1) - _speed * (cos _dirTo), 0];
    };

    _barrel enableSimulationGlobal true;
    _barrel allowDamage false;
    _itemsToDespawn pushback _barrel;

    /*// testing
    _barrel disableCollisionWith player;*/

    playSound3D [Epoch_TT_AirLaunchSound, _barrel];

    Sleep 0.3;

};

playSound3D [Epoch_TT_AirCompleteSound, _launcher];

// Cleanup
[_itemsToDespawn, _delay] spawn {
    Sleep ((_this select 1) * 2);
    {  deleteVehicle _x; false } count (_this select 0) > 0;
    Epoch_TT_ActiveBarrels = Epoch_TT_ActiveBarrels - 1;
}
