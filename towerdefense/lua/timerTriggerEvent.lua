--TODO: no wave-variable needed

if (repeatwaves ~= 0 and wave > #waves*repeatwaves) then
	--TODO:only do this once! and only if only one player
	--setPlayerAsWinner(0) 
	--endGame()

	--TODO: do this when the last unit got killed!!!!
else

local player = 1;
--TODO: modify for multiplyer
while humans >= player do
	if stillalive[player] == true then
		createUnitNoSpacing(getWave(wave)[1], 4, path[player][1]);
		givePositionCommand(lastCreatedUnit(), "move", path[player][2]);
		creepsonlane[player] = creepsonlane[player] + 1;
	end
	player = player + 1;
end

--addConsoleLangText("cp",creepqueue)
print("remaining creeps: "..creepqueue)

if creepqueue == getWave(wave)[2] then
	--first creep of this wave
	addConsoleLangText("nextwave",wave)
	giveResourceEveryone("wave", 1);
	player = 0;
	while humans > player do
		goldinterest = math.floor(resourceAmount("gold", player) * interest + 0.5);
		if ( stillalive[player+1] == true and goldinterest > 0) then
			addConsoleLangText("interest",getPlayerName(player),goldinterest)
			giveResource("gold", player, goldinterest);
		end
		player = player + 1;
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
