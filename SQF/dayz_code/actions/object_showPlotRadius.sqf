// Build preview adopted from Axe Cop (@vos) Base Destruction Script
// Amended by RimBlock (http://epochmod.com/forum/index.php?/user/12612-rimblock/) to allow plot radius removal.

private ["_location","_obj","_x","_dir","_nearPlotPole","_i","_markerCount","_BD_radius","_BD_center"];

// global vars
_nearPlotPole = nearestObject [player, "Plastic_Pole_EP1_DZ"];

//"privatized" center variable
_BD_radius = DZE_PlotPole select 0;
_BD_center = [_nearPlotPole] call FNC_getPos;

_markerCount = (((2 * _BD_radius) * pi) / 3);

_start = (360 / _markerCount);
_end = (360 - (360 / _markerCount));
_step = (360 / _markerCount);

diag_log text "First line.";

// circle
for "_i" from 0 to 360 step _step do {
	_location = [((_BD_center select 0) + (cos (_i) * _BD_radius)), ((_BD_center select 1) + (sin (_i) * _BD_radius)), ((_BD_center select 2) - 0.18)];
	_object = "Sign_Sphere100cm_EP1" createVehiclelocal _location;
	_object setVariable ["Inventory", ["PPMarker"],false];
	uisleep 0.005;
};

for "_i" from _start to _end step _step do {
	_x_coord = (_BD_center select 0) + (cos(_i) * _BD_radius);
	_y_coord = (_BD_center select 1);
	_z_coord = (_BD_center select 2) + (sin (_i) * _BD_radius);
	_location = [_x_coord, _y_coord, _z_coord];
	if ((_location select 2) > 0) then{
		_object = "Sign_Sphere100cm_EP1" createVehiclelocal _location;
		_object setpos _location;
		_object setVariable ["Inventory", ["PPMarker"],false];
		uisleep 0.005;
	};
};

for "_i" from _start to _end step _step do {
	_x_coord = (_BD_center select 0);
	_y_coord = (_BD_center select 1) + (cos(_i) * _BD_radius);
	_z_coord = (_BD_center select 2) + (sin(_i) * _BD_radius);
	_location = [_x_coord, _y_coord, _z_coord];
	if ((_location select 2) > 0) then{
		_object = "Sign_Sphere100cm_EP1" createVehiclelocal _location;
		_object setpos _location;
		_object setVariable ["Inventory", ["PPMarker"],false];
		uisleep 0.005;
	};
};
