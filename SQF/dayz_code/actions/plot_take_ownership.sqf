// Plot Take Ownership by RimBlock (http://epochmod.com/forum/index.php?/user/12612-rimblock/)
//
// This script allows sends the call for the server to run the take ownership script to take ownership of all allowed buildables on their plot except lockable storage and tents.
//
// Note:
// This code calls Take_Plot_Ownership.sqf on the server via PVS.

private ["_distance","_plotpole","_playerUID","_isowner"];

_distance = (DZE_PlotPole select 0) + 1;
_plotpole = nearestobject [(vehicle player),"Plastic_Pole_EP1_DZ"];

_playerUID = [player] call FNC_GetPlayerUID;

// Check is owner of the plot pole.
_isowner = [player, _plotpole, _distance] call FNC_check_owner;

if ((_isowner select 0 )) then {
	PVDZE_TakePlotOwnership = [player, _plotpole, _distance];
	publicVariableServer "PVDZE_TakePlotOwnership";
};
