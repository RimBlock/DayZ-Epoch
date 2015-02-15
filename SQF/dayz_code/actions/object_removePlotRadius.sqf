// Remove preview build by RimBlock (http://epochmod.com/forum/index.php?/user/12612-rimblock/)

private ["_location","_object","_objects","_i","_dir","_nearPlotPole","_validMarkers","_findNearestMarkers","_poleinv","_IsNearPlot","_plotpole","_plotcheck"];

_validMarkers = [];
_isnearplot = 0;

// check for near plot
_plotcheck = [player, false] call FNC_find_plots;
_distance = (_plotcheck select 0) + 5;
_nearestPole = _plotcheck select 2;
_findNearestMarkers = (position _nearestPole) nearEntities ["Land_coneLight", _distance];

{
	_poleinv = _x getVariable ["inventory",[]];
	
	if (_poleinv select 0 == "PPMarker") then {
		_validMarkers set [count _validMarkers,_x];
	};
} count _findNearestMarkers;

_IsNearPlot = count _validMarkers;

// If no plot poles found with ppMarker in the inventory.
if (_IsNearPlot > 0) then{ 
	{
		//diag_log format["Object remove plot radius: [Destroying object: %1]",_x];
		deleteVehicle _x;
	} count _validMarkers;
};

