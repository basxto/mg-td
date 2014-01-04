-- will be only executed once, practical for initializing variables that will be stored in a savegame later!

scenarioVersion="0.2"

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

--(is this saved and restored)
--I want to control the units, furthermore I use consumable resources as a timer
for i = 1, 8 do
	disableAi(i-1);
	disableConsume(i-1);
end
setAttackWarningsEnabled(0);



--register path triggers
for player = 1, humans do
	pathtrigger[player] = {};
	for i = 2, #path[player] do
		pathtrigger[player][i] = registerCellAreaTriggerEvent({path[player][i][1]-1,path[player][i][2]-1,path[player][i][1]+1,path[player][i][2]+1});
	end
	--add worker to group 1, no other units have build command
	addUnitToGroupSelection(getUnitsForFaction(player - 1, "build", 0)[1], 1);
end


--give initial gold
giveResourceEveryone("gold", 20);


--start the wavetimer
resetWavetimer();

addConsoleLangText("welcome",scenarioVersion);
showMessage("manual"," ");
