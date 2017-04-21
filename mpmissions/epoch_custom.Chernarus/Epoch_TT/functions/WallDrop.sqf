if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};

    
{
    if (
        !simulationEnabled _x &&
        random 100 > 40
    ) then {

        _pos = getPosWorld _x;
        _dirAndUp = [vectorDir _x, vectorUp _x];
        _x enableSimulationGlobal true;

        playSound3D [
            selectRandom [
                "A3\sounds_f\structures\doors\PlasticDoors\plasticdoorssqueake_2.wss",
                "A3\sounds_f\structures\doors\PlasticDoors\plasticdoorssqueake_1.wss"
            ],
            _x
        ];

        [_x, _pos, _dirAndUp] spawn {
            Sleep 1;
            (_this select 0) setPosWorld (_this select 1);
            (_this select 0) setVectorDirAndUp (_this select 2);
            (_this select 0) enableSimulationGlobal false;
        };
    };
    false
} count Epoch_TT_DroppableWalls > 0;
