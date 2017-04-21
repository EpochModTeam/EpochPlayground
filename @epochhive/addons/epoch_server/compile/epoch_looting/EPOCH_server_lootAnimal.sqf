/*
	Author: Aaron Clark - EpochMod.com

    Contributors:

	Description:
	Server side animal looting

    Licence:
    Arma Public License Share Alike (APL-SA) - https://www.bistudio.com/community/licenses/arma-public-license-share-alike

    Github:
    https://github.com/EpochModTeam/Epoch/tree/release/Sources/epoch_server/compile/epoch_looting/EPOCH_server_lootAnimal.sqf
*/
private["_item", "_class", "_pos", "_objectClass"];
params ["_object","_player",["_token","",[""]]];
if !([_player, _token] call EPOCH_server_getPToken) exitWith{};

if !(isNull _object) then {
	_pos = getPosATL _object;
	_objectClass = typeOf _object;
	_classOverride = getText (configFile >> "CfgVehicles" >> _objectClass >> "epochLootClass");
	if (_classOverride != "") then {
		_objectClass = _classOverride;
	};
	deleteVehicle _object;
	_item = createVehicle["groundWeaponHolder", [0,0,0], [], 0.0, "CAN_COLLIDE"];
	_item setPosATL _pos;
	_class = "SeaFood";
	_config = configFile >> "CfgMainTable" >> _objectClass;
	if (isClass(_config)) then {
		_class = _objectClass;
	};
	[_item, _class, true] call EPOCH_serverLootObject;

	_errorMsg = "You found something!";
	[_errorMsg, 5] remoteExec ['Epoch_message',_player];
};
true
