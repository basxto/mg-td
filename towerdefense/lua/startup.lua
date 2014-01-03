-- will be only executed once, practical for initializing variables that will be stored in a savegame later!

--workers resources should be the same
wave = 1;				--the wave which is spawned at the moment or the next one which will be spawned
maxwaves = 5;
wavetimer = 10;

repeatwaves = 0;		--0 is infinit
wavemultiplyer = 0.3;
interest = 0.01;

--a unit countdown for a wave
--because I do not want to send all creeps at once, this should also improve pathfinding
creepqueue = getWave(wave)[2];

--!!!!!!!!!!!!!!!is this saved and restored?
--I want to control the units, furthermore I use consumable resources as a timer
local i = 0
while 8 > i do
	disableAi(i);
	disableConsume(i);
	i = i + 1;
end
setAttackWarningsEnabled(0);



--register path triggers
player = 1;
while humans >= player do
	pathtrigger[player] = {};
	local i = 2;
	local length = #path[player];
	while length >= i do
		pathtrigger[player][i] = registerCellAreaTriggerEvent({path[player][i][1]-1,path[player][i][2]-1,path[player][i][1]+1,path[player][i][2]+1});
		i = i + 1;
	end
	player = player + 1;
end




--give initial gold
giveResourceEveryone("gold", 20);


--start the wavetimer
resetWavetimer()

addConsoleLangText("welcome","0.2")
