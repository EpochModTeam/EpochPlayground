if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};
    
{
    _x setVariable ['Epoch_TT_JumpedFromTop', true];

    if (backpack _x != "B_Parachute") then {
        remoteExec ["Epoch_TT_LocalParachuteSetup", _x];
    };

    false
} count _this > 0;
