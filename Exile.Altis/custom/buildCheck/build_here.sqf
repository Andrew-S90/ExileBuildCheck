/*
	Name: build_here.sqf
	By: Andrew_S90
	Description: Allows players to test the spot they are at to see if they can place their territory there.
	
	Notes: Spawntowns/Territories technically will allow you to place your flag 1001m away but then 2m closer
		  to the territory/spawntown you won't be able to build so if you want set 
		  [_position, (_minimumDistanceToTraderZones+150)] to allow full range building.. (UNTESTED!)

*/

private ["_minimumDistanceToTraderZones","_minimumDistanceToSpawnZones","_minimumDistanceToOtherTerritories","_canbuild","_position"];

_position = _this;
_minimumDistanceToTraderZones = getNumber (missionConfigFile >> "CfgTerritories" >> "minimumDistanceToTraderZones");
_minimumDistanceToSpawnZones = getNumber (missionConfigFile >> "CfgTerritories" >> "minimumDistanceToSpawnZones");
_minimumDistanceToOtherTerritories = getNumber (missionConfigFile >> "CfgTerritories" >> "minimumDistanceToOtherTerritories");

_canbuild = true;

if ([_position, _minimumDistanceToTraderZones] call ExileClient_util_world_isTraderZoneInRange) then
{
	private ["_text"];
	_text = "Too Close to a Trader!";
	["ErrorTitleAndText", ["Build Check", _text]] call ExileClient_gui_toaster_addTemplateToast;
	_canbuild = false;
};
if ([_position, _minimumDistanceToSpawnZones] call ExileClient_util_world_isSpawnZoneInRange) then
{	
	private ["_text"];
	_text = "Too Close to a Spawn Zone!";
	["ErrorTitleAndText", ["Build Check", _text]] call ExileClient_gui_toaster_addTemplateToast;
	_canbuild = false;
};
if ([_position, _minimumDistanceToOtherTerritories] call ExileClient_util_world_isTerritoryInRange) then
{
	private ["_text"];
	_text = "Too Close to an Enemy Territory!";
	["ErrorTitleAndText", ["Build Check", _text]] call ExileClient_gui_toaster_addTemplateToast;
	_canbuild = false;
};
if (_position call ExileClient_util_world_isInNonConstructionZone) then
{
	private ["_text"];
	_text = "In Block Zone!";
	["ErrorTitleAndText", ["Build Check", _text]] call ExileClient_gui_toaster_addTemplateToast;
	_canbuild = false;
};
if (_position call ExileClient_util_world_isInRadiatedZone) then
{
	private ["_text"];
	_text = "In Rad Zone!";
	["ErrorTitleAndText", ["Build Check", _text]] call ExileClient_gui_toaster_addTemplateToast;
	_canbuild = false;
};

if (_canbuild) then {
	private ["_text"];
	_text = "You can build here!!";
	["SuccessTitleAndText", ["Build Check", _text]] call ExileClient_gui_toaster_addTemplateToast;
};
_canbuild