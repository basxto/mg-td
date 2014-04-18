--these functions and variables will always be loaded
--practical for functions and arrays





--:::these variables are needed for table calculation, restored variables are available _after_ execution of this section

--how many human players do we have? need to detect, which slots are really used, please use them in a continous order!
humans=4;

--mapsize --needs to be twice as big as the map editor size
height = 127;
width = 127;

debug = false;

maptype = "rotated";-- "rotated", "mirrored"
teleportUnits = true;-- teleport units to next player instead of killing them


--:::functions (can't be saved)
--TODO special wave-units

function createAndGetUnitNoSpacing(unit, faction, position)
	createUnitNoSpacing(unit, faction, position);
	return lastCreatedUnit();
end

function getWave(wave)
	--return next unit to send,amount of units in this wave
	local realwave = wave%#waves;
	if realwave == 0 then
		realwave = #waves;
	end
	local thisWave = waves[realwave][1];
	local unit = thisWave[1];
	local amount = math.floor(thisWave[2]*( math.pow( 1 + wavemultiplyer , ( (wave-realwave) / #waves) )));
	return {unit,amount};
end

--- give resource to all human players
-- @param recource The resource the players get.
-- @param value The amount the players get.
function giveResourceEveryone(resource, value)
	local player = 0;
	while humans > player do
		giveResource(resource, player, value);
		player = player + 1;
	end
end

--reset wavetimer for a new wave
function resetWavetimer()
	giveResourceEveryone("time", wavetimer);
	startEfficientTimerEvent(wavetimer);
end

--:::tables (can't be saved)

creepsonlane = {0,0,0,0};
stillalive = {true,true,true,true};
_stillalive = {
	isHuman(0),
	isHuman(1),
	isHuman(2),
	isHuman(3)
}
print(stillalive[1]);
print(stillalive[2]);
print(stillalive[3]);
print(stillalive[4]);

--defindes the wave and if it will be repeated
--TODO being able to send them!!!
waves2 = {--for testing
	{{"pig",3}},
	{{"sheep",4}},
	{{"mummy",4}},
	{{"behemoth",1}},
	{{"mummy",3},{"behemoth",2}}--is that even possible?
}
__waves = {
	{"pig",3},
	{"sheep",4},
	{"mummy",5},
	{"behemoth",1}
}

waves_old = {--for testing
	{"pig",3}
}

waves = {--for testing
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

_waves = {--for testing
	{"behemoth",1}
}



--creep bounty
bounty = {
	pig=1,
	sheep=2,
	mummy=3,
	behemoth=30
}




--the path the units shall use in the upper left square
_path = {{
	{50,14},--1
	{14,14},--2
	{14,30},--3
	{50,50},--4
	{50,46},--5
	{14,46},--6
	{14,50}--7
}}

path = {{
	{14,50},--1
	{14,14},--2
	{30,14},--3
	{30,50},--4
	{46,50},--5
	{46,14},--6
	{56,14}--7
}}


--mirrored: the map always consists of 4 similar, but mirrored fields
--rotated: 4 similar fields, but every field is rotated by a half pi
--the other player fields are just mirrored and the path automatically calculated
for player = 2, humans do
	--first copy the path
	path[player] = {};
	--then do the mirroring stuff
	for i = 1, #path[1] do
		local x = path[1][i][1];
		local y = path[1][i][2];
		if maptype == "rotated" and (player == 2 or player == 4) then
			x, y = y, x;
		end
		path[player][i] = {};
		if (player == 2 or player == 3) then
			path[player][i][1] = width - x;
		else
			path[player][i][1] = x;
		end
		
		if (player == 3 or player == 4) then
			path[player][i][2] = height - y;
		else
			path[player][i][2] = y;
		end
		print("after: "..path[player][i][1]..","..path[player][i][2])
	end
end


pathtrigger = {};


