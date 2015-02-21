// Plot Take Ownership by RimBlock (http://epochmod.com/forum/index.php?/user/12612-rimblock/)
//
// This script allows Plot pole owners to take ownership of all allowed buildables on their plot except lockable storage and tents.
//
// Note:
// This code calls server_publishFullObject which also saves damage, inventory and fuel.  Hitpoints are assumed to be empty as this is for buildables only.

private ["_distance","_plotpole","_playerUID","_isowner", "_findNearestObjects","_classname","_objectID", "_objectUID", "_position", "_worldspace", "_object", "_key","_invW","_invM","_invB","_itemsExist","_charID","_inventory","_changecount","_playerObj","_clientID","_nil"];

_playerObj = _this select 0;
_plotpole = _this select 1;
_distance = _this select 2;

diag_log format["[Plot Take Ownership] PlayerObj: %1, Plotpole: %2, Distance: %3",_playerObj,_plotpole,_distance];
diag_log format["[Plot Take Ownership] DZE_plotTakeOwnershipItems: %1",DZE_plotTakeOwnershipItems];

_playerUID = [_playerObj] call FNC_GetPlayerUID;
_changecount = 0;

// Check is owner of the plot pole.

_isowner = [_playerObj, _plotpole] call FNC_check_owner;
_itemsExist = false;

if ((_isowner select 0 )) then {
	diag_log text "[Plot Take Ownership] Player is plot pole owner.";
//	_findNearestObjects = (position _plotpole) nearEntities _distance;
	_findNearestObjects = nearestObjects [(position _plotpole), [], _distance];
	{
		_object = _x;
		_classname = typeOf _object;
		diag_log format["[Plot Take Ownership] Object: %1, Classname: %2",_object,_classname];
		if (_classname in DZE_plotTakeOwnershipItems)then {
		
			_isowner = [_playerObj, _object] call FNC_check_owner;
			diag_log text "[Plot Take Ownership] Object in DZE_plotTakeOwnershipItems";
		
			if !( _isowner select 0 ) then{
				diag_log text "[Plot Take Ownership] Is not already the owner";
				
				_objectID 	= _object getVariable ["ObjectID","0"];
				_objectUID	= _object getVariable ["ObjectUID","0"];
				
				_nil = [_objectID, _objectUID, player] call server_deleteObj;
				
				_object setvariable["ObjectID", "0"];
				
				if (_classname in DZE_DoorsLocked) then {
					_charID =		_object getVariable ["characterID",dayz_characterID];				
				}else{
					_charID =		dayz_characterID;
				};
				
				_position = 	getPosATL _object;
				_worldspace = 	[round(direction _object),_position,_playerUID];

				_invW = getWeaponCargo _object;
				{
					if ((count _x) != 0) then {_itemsExist = true;};
				}foreach _invW;
				
				_invM = getMagazineCargo _object;
				if !(_itemsExist) then{
					{
						if ((count _x) != 0) then {_itemsExist = true;};
					}foreach _invM;
				};
				
				_invB = getBackpackCargo _object;
				if !(_itemsExist) then{
					{
						if ((count _x) != 0) then {_itemsExist = true;};
					}foreach _invB;
				};
				
				if (_itemsExist) then{
					_inventory = format["[%1,%2,%3]", _invW, _invM, _invB];				
				}else{
					_inventory = "[]";
				};
				
				_hitpoints =	'[]';
				_damage =		damage _object;
				_fuel =			fuel _object;
				
				_nil = [_charID,_object,_worldspace,_classname, _inventory, _hitpoints, _damage, _fuel] call server_publishFullObject;
				
				if !(DZE_APlotforLife) then {
					_object setvariable["ownerPUID", dayz_characterID];
				}else{
					_object setvariable["ownerPUID", _playerUID];	
				};	
				_changecount = _changecount + 1;
			};
		};
	} count _findNearestObjects;
};

_clientID = owner _playerObj;
PVDZE_TakeOwnershipCount = _changecount;
_clientID publicVariableclient "PVDZE_TakeOwnershipCount";