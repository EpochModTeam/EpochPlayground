if (!isServer) exitWith {};

_hasFiredEH = _this getVariable ['Epoch_TT_HasSecurityToggle', false];
if (_hasFiredEH) exitWith {};
_this setVariable ['Epoch_TT_HasSecurityToggle', true];

_this removeAllEventHandlers 'FiredNear';
_this addEventHandler ['FiredNear', Epoch_TT_SecurityUnlock];

Epoch_TT_SecurityActive = false;
