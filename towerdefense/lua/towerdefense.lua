local print = print; -- the new env will prevent you from seeing global variables
local math = math;
local isHuman = isHuman;
local giveResource = giveResource;
local createUnitNoSpacing = createUnitNoSpacing;
local lastCreatedUnit = lastCreatedUnit;
local startEfficientTimerEvent = startEfficientTimerEvent;

local M = {};
if setfenv then
	setfenv(1, M); -- for 5.1
else
	_ENV = M; -- for 5.2
end

--local is private

--:::these variables are needed for table calculation, restored variables are available _after_ execution of this section

settings = {};
--how many human players do we have? need to detect, which slots are really used, please use them in a continous order!
settings.humans=4;

--mapsize --needs to be twice as big as the map editor size
settings.height = 127;
settings.width = 127;

settings.debug = false;

settings.maptype = "rotated";-- "rotated", "mirrored"
settings.teleportUnits = true;-- teleport units to next player instead of killing them

settings.scenarioVersion="0.2"

--workers resources should be the same
settings.wave = 1;				--the wave which is spawned at the moment or the next one which will be spawned
settings.maxwaves = 5;
settings.wavetimer = 40;
settings.spawndelayed = false;

settings.repeatwaves = 0;		--0 is infinit
settings.wavemultiplyer = 0.3;
settings.interest = 0.01;


--creep bounty
M.settings.bounty = {
	normal=1,
    healthier=1,
	defense=1,
	pig=1,
	sheep=2,
	mummy=3,
	behemoth=30
}

--the path the units shall use in the upper left square
M.settings.path = {{
	{14,50},--1
	{14,14},--2
	{30,14},--3
	{30,50},--4
	{46,50},--5
	{46,14},--6
	{56,14}--7
}}

--defines the wave and if it will be repeated
--TODO being able to send them!!!
--TODO send multiple types in one wave
M.settings.waves = {--for testing
	{{"normal",4}},
	{{"healthier",4}},
	{{"defense",4}},
	{{"pig",4}},

	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}},

	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}},
	{{"pig",4}}
}

M.settings = settings;

M.helper = {};

--:::functions (can't be saved)
--TODO special wave-units

function M.helper:createAndGetUnitNoSpacing(unit, faction, position)
	createUnitNoSpacing(unit, faction, position);
	return lastCreatedUnit();
end

--- give resource to all human players
-- @param recource The resource the players get.
-- @param value The amount the players get.
function M.helper:giveResourceEveryone(resource, value)
	local player = 0;
	while settings.humans > player do
		giveResource(resource, player, value);
		player = player + 1;
	end
end


M.stillalive = {
	isHuman(0),
	isHuman(1),
	isHuman(2),
	isHuman(3)
}


M.pathtrigger = {};

waveManager = {};

function waveManager:getWave(wave)
	--return next unit to send,amount of units in this wave
	local realwave = settings.wave%#settings.waves;
	if realwave == 0 then
		realwave = #settings.waves;
	end
	local thisWave = settings.waves[realwave][1];
	local unit = thisWave[1];
	local amount = math.floor(thisWave[2]*( math.pow( 1 + settings.wavemultiplyer , ( (settings.wave - realwave) / #settings.waves) )));
	return {unit,amount};
end



--reset wavetimer for a new wave
function waveManager:resetWavetimer()
	M.helper:giveResourceEveryone("time", settings.wavetimer);
	startEfficientTimerEvent(settings.wavetimer);
end


waveManager.onlane = {0,0,0,0};

--a unit countdown for a wave
--because I do not want to send all creeps at once, this should also improve pathfinding
waveManager.creepqueue = waveManager:getWave(settings.wave)[2];

M.waveManager = waveManager;


--M.startup = require(lua.startup);
--M.timerTriggerEvent = require(lua.timerTriggerEvent);
--M.cellTriggerEvent = require(lua.cellTriggerEvent);
--M.unitDied = require(lua.unitDied);


-------executed once

--mirrored: the map always consists of 4 similar, but mirrored fields
--rotated: 4 similar fields, but every field is rotated by a half pi
--the other player fields are just mirrored and the path automatically calculated
for player = 2, settings.humans do
	--first copy the path
	settings.path[player] = {};
	--then do the mirroring stuff
	for i = 1, #settings.path[1] do
		local x = settings.path[1][i][1];
		local y = settings.path[1][i][2];
		if settings.maptype == "rotated" and (player == 2 or player == 4) then
			x, y = y, x;
		end
		settings.path[player][i] = {};
		if (player == 2 or player == 3) then
			settings.path[player][i][1] = settings.width - x;
		else
			settings.path[player][i][1] = x;
		end

		if (player == 3 or player == 4) then
			settings.path[player][i][2] = settings.height - y;
		else
			settings.path[player][i][2] = y;
		end
		print("after: "..settings.path[player][i][1]..","..settings.path[player][i][2])
	end
end


return M;
