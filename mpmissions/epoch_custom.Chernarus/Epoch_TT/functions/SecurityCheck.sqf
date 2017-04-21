if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};

Epoch_TT_AllPlayersInZone = _this;

Epoch_TT_SecurityActive = if ((Epocy_TT_SecurityGate animationPhase "Door_1_rot") == 0) then { true } else { false };

// Unconscious player check
/*{

    // Is a player unconscious (lifestate unreliable...)
    _isUnconscious = if (['unconscious', animationState player] call bis_fnc_inString || lifestate player == "INCAPACITATED") then { true } else { false };
    if (_isUnconscious) then {

         _unconsciousSince = _x getVariable ['Epoch_TT_UnconsciousSince', -1];
         _unconsciousSince = if (_unconsciousSince == -1) then { time } else { _unconsciousSince };
         _x setVariable ['Epoch_TT_UnconsciousSince', _unconsciousSince];

         // If player has been unconscious for more than 5 seconds
        if (time - _unconsciousSince < 5) exitWith {};

        _x setVariable ['Epoch_TT_UnconsciousSince', nil];

        _x setPos Epoch_TT_RestartPoint;

    };

    false
} count _this > 0;*/



if (Epoch_TT_SecurityActive) then {
    {
        if (getDammage _x > 0) then { _x setdammage 0; };
        [_x, true] call Epoch_TT_SpawnLightning;
        false
    } count _this > 0;
};
