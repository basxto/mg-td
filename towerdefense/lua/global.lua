--these functions and variables will always be loaded
--practical for functions and arrays





--:::these variables are needed for table calculation, restored variables are available _after_ execution of this section

--how many human players do we have? need to detect, which slots are really used, please use them in a continous order!
humans=1;

--mapsize
height = 256;
width = 256;


--:::functions (can't be saved)
--TODO special wave-units
function isHuman(player)
	local name = string.upper(getPlayerName(player));
	print(name)
	return (name~="CPU" and name~="NET")
end

function getWave(wave)
	--return next unit to send,amount of units in this wave
	local realwave = wave%#waves;
	if realwave == 0 then
		realwave = #waves;
	end
	local unit = waves[realwave][1];
	local amount = math.floor(waves[realwave][2]*( math.pow( 1 + wavemultiplyer , ( (wave-realwave) / #waves) )));
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
stillalive = {
	isHuman(0),
	isHuman(1),
	isHuman(2),
	isHuman(3)
}

--defindes the wave and if it will be repeated
--TODO being able to send them!!!
waves2 = {--for testing
	{{"pig",3}},
	{{"sheep",4}},
	{{"mummy",4}},
	{{"behemoth",1}},
	{{"mummy",3},{"behemoth",2}}--is that even possible?
}
_waves = {
	{"pig",3},
	{"sheep",4},
	{"mummy",5},
	{"behemoth",1}
}

waves = {--for testing
	{"pig",1}
}


--creep bounty
bounty = {
	pig=1,
	sheep=2,
	mummy=3,
	behemoth=30
}




--the path the units shall use in the upper left square
path = {{
	{89,19},
	{89,40},
	{32,40},
	{32,56},
	{89,56},
	{89,92},
	{17,92},
	{17,23}
}}

--the map always consists of 4 similar, but mirrored fields
--the other player fields are just mirrored and the path automatically calculated
for player = 2, humans do
	--first copy the path
	path[player] = {};
	--then do the mirroring stuff
	for i = 1, #path[1] do
		path[player][i] = {};
		if (player == 2 or player ==4) then
			path[player][i][1] = width - path[1][i][1];
		else
			path[player][i][1] = path[1][i][1];
		end
		
		if (player == 3 or player == 4) then
			path[player][i][2] = height - path[1][i][2];
		else
			path[player][i][2] = path[1][i][2];
		end
		print("after: "..path[player][i][1]..","..path[player][i][2])
	end
end


pathtrigger = {};


