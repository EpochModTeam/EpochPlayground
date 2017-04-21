if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};

{
    _player = _x;

    // Reset checkpoint status
    _player setVariable ['Epoch_TT_TowerStatus', 0];

    // Remove all weapons and backpack
    if (count weapons _player > 0) then {
        remoteExec ["Epoch_TT_LocalPlayerSetup", _player, false];
    };

    // Make sure player isn't damaged
    if (getdammage _player > 0) then { _player setDammage 0; };
    _player setUnconscious false;

    // Ensure player always has 3 first aid kits
    _numKits = { _x == "FirstAidKit" } count (items _player);
    if (3 - _numKits > 0) then {
        for "_i" from 1 to (3 - _numKits) step 1 do {
            _player addItem "FirstAidKit";
        };
    };

    // Add teleport menu to object (if we are an admin)
    _adminCheckComplete = _player getVariable ['Epoch_TT_AdminCheckComplete', false];
    if (!_adminCheckComplete && !isNil "EPOCH_server_isPAdmin") then {
         _player setVariable ['Epoch_TT_AdminCheckComplete', true];         
        if !(_player call EPOCH_server_isPAdmin) exitWith {};
        remoteExec ['Epoch_TT_LocalTeleportActions', _player];            
    };


    false
} count _this > 0;
