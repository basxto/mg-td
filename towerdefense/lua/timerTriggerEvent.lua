--TODO: no wave-variable needed

if (TD.settings.repeatwaves ~= 0 and TD.settings.wave > (#TD.settings.waves)*TD.settings.repeatwaves) then
	--TODO:only do this once! and only if only one player
	--setPlayerAsWinner(0)
	--endGame()

	--TODO: do this when the last unit got killed!!!!
else

	--TODO: modify for multiplyer
	for player = 1, TD.settings.humans do
		if TD.stillalive[player] == true then
			givePositionCommand(TD.helper:createAndGetUnitNoSpacing(TD.waveManager:getWave(wave)[1], 4, TD.settings.path[player][1]), "move", TD.settings.path[player][2]);
			TD.waveManager.onlane[player] = TD.waveManager.onlane[player] + 1;
		end
	end

	--addConsoleLangText("cp",creepqueue)
	print("remaining creeps: "..TD.waveManager.creepqueue);

	if TD.waveManager.creepqueue == TD.waveManager:getWave(TD.settings.wave)[2] then
		--first creep of this wave
		addConsoleLangText("nextwave",TD.settings.wave)
		TD.helper:giveResourceEveryone("wave", 1);
		for player = 1, TD.settings.humans do
			goldinterest = math.floor(resourceAmount("gold", player-1) * TD.settings.interest + 0.5);
			if ( TD.stillalive[player] == true and goldinterest > 0) then
				addConsoleLangText("interest",getPlayerName(player-1),goldinterest)
				giveResource("gold", player-1, goldinterest);
			end
		end
	end

	if TD.waveManager.creepqueue == 1 then
		--this is the last creep of this wave
		TD.settings.wave = TD.settings.wave + 1;
		if (TD.settings.repeatwaves == 0 or (#TD.settings.waves)*TD.settings.repeatwaves >= TD.settings.wave) then
			TD.waveManager.creepqueue = TD.waveManager:getWave(TD.settings.wave)[2];
			TD.waveManager:resetWavetimer();
		end
	else
		startEfficientTimerEvent(1);
		TD.waveManager.creepqueue = TD.waveManager.creepqueue - 1;
	end
end
