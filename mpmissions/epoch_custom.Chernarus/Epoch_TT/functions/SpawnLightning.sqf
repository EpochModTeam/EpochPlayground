if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};

params ['_target', ['_kill', true]];


// Lightning group
_center = createCenter sideLogic;
_group = createGroup _center;

_lightning = _group createUnit ["ModuleLightning_F", _target ,[],0,""];

if (_kill) then {
    _target setDammage 1;
    /*_x setUnconscious true;
    _x spawn {
        Sleep 2;
        _this setPos EPOCH_TT_RestartPoint;
    };*/
};

[_lightning, _group] spawn {
    Sleep 0.5;
    deleteVehicle (_this select 0);
    deleteGroup (_this select 1);
};
