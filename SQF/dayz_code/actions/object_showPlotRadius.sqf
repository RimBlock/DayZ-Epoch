// Build preview adopted from Axe Cop (@vos) Base Destruction Script
// Amended by RimBlock (http://epochmod.com/forum/index.php?/user/12612-rimblock/) to allow plot radius removal.

private ["_location","_object","_i","_dir","_nearestPole","_distance","_IsNearPlot","_BD_radius","_BD_center","_plotcheck"];

// global vars

_plotcheck = [player, false] call FNC_find_plots;
_distance = _plotcheck select 0;
_nearestPole = _plotcheck select 2;

//"privatized" center variable
_BD_radius = _distance;
_BD_center = [_nearestPole] call FNC_getPos;
	
// circle
for "_i" from 0 to 360 step (450 / _BD_radius) do {
	_location = [(_BD_center select 0) + ((cos _i) * _BD_radius), (_BD_center select 1) + ((sin _i) * _BD_radius), (_BD_center select 2) - 0.18];

	_object = createVehicle ["Land_coneLight", _location, [], 0, "CAN_COLLIDE"];
	_object setVariable ["Inventory", ["PPMarker"],true];
	_object enableSimulation false;
	_object setpos _location;

};

