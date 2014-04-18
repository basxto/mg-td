-- will be only executed once, practical for initializing variables that will be stored in a savegame later!

--~ scenarioVersion="0.2"
--~
--~ --workers resources should be the same
--~ wave = 1;				--the wave which is spawned at the moment or the next one which will be spawned
--~ maxwaves = 5;
--~ wavetimer = 40;
--~ spawndelayed = false;
--~
--~ repeatwaves = 0;		--0 is infinit
--~ wavemultiplyer = 0.3;
--~ interest = 0.01;
--~
--~ --a unit countdown for a wave
--~ --because I do not want to send all creeps at once, this should also improve pathfinding
--~ creepqueue = TD.waveManager:getWave(wave)[2];

--(is this saved and restored)
--I want to control the units, furthermore I use consumable resources as a timer
for i = 1, 8 do
	disableAi(i-1);
	disableConsume(i-1);
end
setAttackWarningsEnabled(0);



--register path triggers
for player = 1, TD.settings.humans do
	TD.pathtrigger[player] = {};
	for i = 2, #TD.settings.path[player] do
		TD.pathtrigger[player][i] = registerCellAreaTriggerEvent({TD.settings.path[player][i][1]-1,TD.settings.path[player][i][2]-1,TD.settings.path[player][i][1]+1,TD.settings.path[player][i][2]+1});
		if TD.settings.debug then
			showMarker(1000000, player-1, "trigger", "group.png", {TD.settings.path[player][i][1],TD.settings.path[player][i][2]});
		end
	end
	--add worker to group 1, no other units have build command
	local worker = getUnitsForFaction(player - 1, "build", 0)[1];
	addUnitToGroupSelection(worker, 1);
	selectUnit(worker);
end

--give initial gold
TD.helper:giveResourceEveryone("gold", 20);

if TD.settings.debug then
	givePositionCommand(createAndGetUnitNoSpacing("pig", 4, TD.settings.path[1][1]), "move", path[1][2]);
else
	--start the wavetimer
	--resetWavetimer();
	TD.helper:giveResourceEveryone("time", 1);
	startEfficientTimerEvent(1);
end


addConsoleLangText("welcome",TD.settings.scenarioVersion);
showMessage("manual"," ");
