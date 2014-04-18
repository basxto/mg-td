--TODO: no wave-variable needed

if (repeatwaves ~= 0 and wave > #waves*repeatwaves) then
	--TODO:only do this once! and only if only one player
	--setPlayerAsWinner(0) 
	--endGame()

	--TODO: do this when the last unit got killed!!!!
else

--TODO: modify for multiplyer
for player = 1, humans do
	if stillalive[player] == true then
		givePositionCommand(createAndGetUnitNoSpacing(getWave(wave)[1], 4, path[player][1]), "move", path[player][2]);
		creepsonlane[player] = creepsonlane[player] + 1;
	end
end

--addConsoleLangText("cp",creepqueue)
print("remaining creeps: "..creepqueue)

if creepqueue == getWave(wave)[2] then
	--first creep of this wave
	addConsoleLangText("nextwave",wave)
	giveResourceEveryone("wave", 1);
	for player = 1, humans do
		goldinterest = math.floor(resourceAmount("gold", player-1) * interest + 0.5);
		if ( stillalive[player] == true and goldinterest > 0) then
			addConsoleLangText("interest",getPlayerName(player-1),goldinterest)
			giveResource("gold", player-1, goldinterest);
		end
	end
end

if creepqueue == 1 then
	--this is the last creep of this wave
	wave = wave + 1;
	if (repeatwaves == 0 or #waves*repeatwaves >= wave) then
		creepqueue = getWave(wave)[2];
		resetWavetimer();
	end
	else
		startEfficientTimerEvent(1);
		creepqueue = creepqueue - 1;
	end
end
