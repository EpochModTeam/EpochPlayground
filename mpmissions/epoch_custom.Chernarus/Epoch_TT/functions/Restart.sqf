if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};

{
    _x setPos EPOCH_TT_RestartPoint;
    false
} count _this > 0;
