// plot ownership count by RimBlock (http://epochmod.com/forum/index.php?/user/12612-rimblock/)
//
// This script reports the number of plot objects the player has taken ownership of.
//
// Note:
// This code calls is fired from a PVC call from the server with the number of objects as the parameter.

Private ["_changecount"];

_changecount = _this;

if (_changecount == 0) then {
	cutText ["Take Ownership: No objects requiring ownership change found.", "PLAIN DOWN"];
}else{
	cutText [format["Take Ownership: %1 objects ownership changed.",_changecount], "PLAIN DOWN"];
};
