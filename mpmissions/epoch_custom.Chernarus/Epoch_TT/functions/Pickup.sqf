if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};


params [['_action', 'none'], ['_targets', []], ['_object', objNull], ['_timeout', 0]];

// Testing
// _timeout = 5;

if (_action == "none") exitWith {};
if (isNull _object) exitWith {};

_currentTimeout = _object getVariable ['Epoch_TT_Timeout', time - _timeout];
if (time - _currentTimeout < _timeout) exitWith {};
_object setVariable ['Epoch_TT_Timeout', time + _timeout];

// "a3\sounds_f\weapons\flare_gun\flaregun_1.wss"
// a3\sounds_f\weapons\reloads\kohoutek1.wss
// a3\sounds_f\weapons\GM6Lynx\GM6_lynx_hlaven.wssi
// a3\sounds_f\weapons\GM6Lynx\GM6_lynx_dry.wss
// GM6_lynx_hlaven
// Epoch_TT_LightningZone

if (_timeout > 0 && count _targets == 0) exitWith {
    _object setVariable ['Epoch_TT_Timeout', time - _timeout];
};

if (_action == "Hatchet") exitWith {

    {
        if (
            !("Hatchet" in (weapons _x)) || !("Hatchet_Swing" in (magazines _x))
        ) then {

            // a3\sounds_f\weapons\reloads\kohoutek1.wss
            // a3\sounds_f\weapons\GM6Lynx\GM6_lynx_hlaven.wss
            // a3\sounds_f\weapons\GM6Lynx\GM6_lynx_dry.wss
            playSound3d[
                selectRandom [
                    "a3\sounds_f\weapons\GM6lynx\GM6_lynx_dry.wss",
                    "a3\sounds_f\weapons\GM6Lynx\GM6_lynx_hlaven.wss",
                    "a3\sounds_f\weapons\GM6Lynx\GM6_lynx_dry.wss"
                ],
            _x];
            remoteExec ['Epoch_TT_LocalHatchetSetup', _x];
        };
        false
    } count _targets > 0;

};


if (_action == "Lightning") exitWith {

    // Dont initiate with no targets
    if (count _targets == 0) exitWith {};

    // Set timeout texture
    _object setObjectTextureGlobal [0, "Epoch_TT\images\timeout_red.paa"];

    // Warning sound
    playSound3D["a3\sounds_f\sfx\alarmCar.wss", _object];

    [_timeout, _object] spawn {
        // Reset texture after duration
        Sleep (_this select 0);
        (_this select 1) setObjectTextureGlobal [0, "Epoch_TT\images\lightning.paa"];
    };

    [(selectRandom _targets), _timeout, _object] spawn {

        // Spawn actual lightning after the warning
        Sleep 2;
        [(_this select 0), true] call Epoch_TT_SpawnLightning;

    };

};


if (_action == "Launcher") exitWith {

    // Dont initiate with no targets
    if (count _targets == 0) exitWith {};

    // Set timeout texture
    _object setObjectTextureGlobal [0, "Epoch_TT\images\timeout_red.paa"];

    // Warning sound
    playSound3D["a3\sounds_f\sfx\alarm.wss", _object];

    _null = [_object, _timeout] spawn {
        Sleep (_this select 1);
        (_this select 0) setObjectTextureGlobal [0, "Epoch_TT\images\launch.paa"];
    };

    _null = [_object, _timeout] spawn {

        Sleep 0.25;

        _towersToLaunch = +Epoch_TT_LaunchableTowers;

        for "_i" from 0 to (count Epoch_TT_LaunchableTowers) - 1 step 1 do {

            _tower = selectRandom _towersToLaunch;

            _object = (_tower select 0);
            _object enableSimulationGlobal true;
            _object setVelocity [0,0,70];

            playSound3D [Epoch_TT_AirLaunchSound, _object];

            Sleep 0.3;

            _towersToLaunch deleteAt (_towersToLaunch find _tower);
        };

        Sleep 10;

        {
            _object = (_x select 0);
            _object setPosWorld (_x select 1);
            _object setVectorDirAndUp (_x select 2);
            _object enableSimulationGlobal false;
            false
        } count Epoch_TT_LaunchableTowers > 0;

    };



};
