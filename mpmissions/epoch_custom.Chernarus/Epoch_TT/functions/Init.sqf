//
//
//     Client Functions
//
//

Epoch_TT_LocalHatchetSetup = {
    removeAllWeapons player;
    player addWeapon "Hatchet";
    player addMagazine "Hatchet_swing";
};

Epoch_TT_LocalPlayerSetup = {
    removeAllWeapons player;
    removeBackpack player;
};

Epoch_TT_LocalParachuteSetup = {
    removeBackpack player;
    player addBackpack 'B_Parachute';
};

Epoch_TT_LocalPlaySound = {
    player say _this;
};

Epoch_TT_LocalTeleportActions = {

    removeAllActions Epoch_TT_TeleportMenuObject;
    Epoch_TT_TeleportMenuObject addAction ['[1] Barrel Run', { player setPos (Epoch_TT_Marker1 modelToWorld [0,0,0.5]); }]; 
    Epoch_TT_TeleportMenuObject addAction ['[2] Box of Mystery', { player setPos (Epoch_TT_Marker2 modelToWorld [0,0,0.5]); }]; 
    Epoch_TT_TeleportMenuObject addAction ['[3] Wall Traps', { player setPos (Epoch_TT_Marker3 modelToWorld [0,0,0.5]); }]; 
    Epoch_TT_TeleportMenuObject addAction ['[4] Launcher Traps', { player setPos (Epoch_TT_Marker4 modelToWorld [0,0,0.5]); }]; 
    Epoch_TT_TeleportMenuObject addAction ['[5] Hard Barrel Run', { player setPos (Epoch_TT_Marker5 modelToWorld [0,0,0.5]); }]; 
    Epoch_TT_TeleportMenuObject addAction ['[6] Parachute Drop', { player setPos (Epoch_TT_Marker6 modelToWorld [0,0,0.5]); }];

};


if (!isServer) exitWith {};

//
//
//       Default Variables
//
//

_isDevelopment = true;
_compileFinal = if (_isDevelopment) then { 'compile' } else { 'compileFinal' };

Epoch_TT_ActiveBarrels = 0;
Epoch_TT_MaxActiveBarrels = 10;

Epoch_TT_SecurityActive = true;
Epoch_TT_AllPlayersInZone = [];

_root = 'Epoch_TT_';
_dir = 'Epoch_TT\functions\';

_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
Epoch_TT_AirLaunchSound = _soundPath + "Epoch_TT\sound\AirLaunch.ogg";
Epoch_TT_AirCompleteSound = _soundPath + "Epoch_TT\sound\AirComplete.ogg";


//
//  Box of mystery defaults
//

// Generate a random combination on init
Epoch_TT_MysteryCombination = [0,1,2];

Epoch_TT_MysteryMarkers = [[0,0,0], [0,0,0]];
Epoch_TT_MysteryCompleteMarker = [0,0,0];
Epoch_TT_MysteryStartMarker = [0,0,0];

// Player restart point
Epoch_TT_RestartPoint = [0,0,0];

// Trigger zonez
Epoch_TT_LightningZone = [];
Epoch_TT_LauncherZone = [];


//
//
//      Function Compilation
//
//

{
    _format = format["%1%2 = %4 preprocessFile '%3%2.sqf';",  _root, _x, _dir, _compileFinal];
	call compile _format;
    false
} count [
    'BarrelDrop'
    ,'Finish'
    ,'Parachute'
    ,'PlayerSetup'
    ,'Restart'
    ,'Pickup'
    ,'SecurityCheck'
    ,'RandomPlayerInZone'
    ,'SpawnLightning'
    ,'SetFate'
    ,'TriggerDoor'
    ,'WallDrop'
    ,'TeleportActions'
];

_null = [] spawn {

    // Wait until all objects loaded
    waitUntil {
        time > 0
    };

    // Random combination
    Epoch_TT_MysteryCombination =
    [
        round random 2,
        round random 2,
        round random 2
    ];

    // Droppable walls
    Epoch_TT_DroppableWalls = [
        Epoch_TT_WallDrop1,
        Epoch_TT_WallDrop2,
        Epoch_TT_WallDrop3,
        Epoch_TT_WallDrop4,
        Epoch_TT_WallDrop5
    ];

    // Droppable walls
    Epoch_TT_LaunchableTowers = [];
    for "_i" from 1 to 10 step 1 do {
        _arr = call compile format['
            [
                Epoch_TT_TowerLauncher%1,
                getPosWorld Epoch_TT_TowerLauncher%1,
                [vectorDir Epoch_TT_TowerLauncher%1, vectorUp Epoch_TT_TowerLauncher%1]
            ]
        ', _i];
        Epoch_TT_LaunchableTowers pushback _arr;
    };

    Epoch_TT_RestartPoint = Epoch_TT_RestartPointMarker modelToWorld [0,0,0.5];

    Epoch_TT_CheckpointPositions = {
        Epoch_TT_RestartPoint,
        Epoch_TT_Marker1 modelToWorld [0,0,0.5],
        Epoch_TT_Marker2 modelToWorld [0,0,0.5],
        Epoch_TT_Marker3 modelToWorld [0,0,0.5]
    };

    Epoch_TT_MysteryMarkers =
    [
        Epoch_TT_MysteryMarker1 modelToWorld [0,0,0.5],
        Epoch_TT_MysteryMarker2 modelToWorld [0,0,0.5]
    ];

    Epoch_TT_MysteryCompleteMarker = Epoch_TT_MysteryComplete modelToWorld [0,0,0.5];
    Epoch_TT_MysteryStartMarker = Epoch_TT_MysteryStart modelToWorld [0,0,0.5];


    diag_log 'Epoch - Tower of Terror Initialized';
    Epoch_TT_Initialized = true;

    Epoch_TT_SecurityActive = false;

};
