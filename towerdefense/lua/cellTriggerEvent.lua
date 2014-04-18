

function lastCheckpoint(player)
	if stillalive[player] then
		giveResource("lives", player-1, -1);
		if 0 >= resourceAmount("lives",player-1) then --player lost
			stillalive[player] = false;
			local lastplayer = true;
			for i = 1, humans do
				if stillalive[i] then
					lastplayer = false;
				end
			end
			if lastplayer then--winner
				addConsoleLangText("won",getPlayerName(player-1));
				showMessage("won", "won");
				setPlayerAsWinner(player-1);
				endGame();
			else--loser
				addConsoleLangText("lost",getPlayerName(player-1));
				showMessage("lost", "lost");
			end
			--vanish player
			enableConsume(player-1);
		end
	end
	creepsonlane[player] = creepsonlane[player] - 1;
	if teleportUnits then
		nextPlayer = player;
		firtsTry = true;
		while firstTry or not(stillalive[nextPlayer]) do
			nextPlayer = nextPlayer+1
			if nextPlayer == humans+1 then
				nextPlayer = 1;
			end
			firstTry = false;
		end
		givePositionCommand(triggeredEventAreaEntryUnitId(), "move", path[nextPlayer][2]);
		setUnitPosition(triggeredEventAreaEntryUnitId(), path[nextPlayer][1]);
		creepsonlane[nextPlayer] = creepsonlane[nextPlayer] + 1;
	else
		destroyUnit(triggeredEventAreaEntryUnitId());
	end
end


if unitFaction(triggeredEventAreaEntryUnitId()) == 4 then
	for player = 1, humans do
		for i = 2, #path[player] do
			--print(triggeredCellEventId().." == "..pathtrigger[player][i]);
			if triggeredCellEventId() == pathtrigger[player][i] then --this is the right trigger!!!
				--print("reached ");
				addConsoleLangText("reached",i);
				if i == #path[player] then--could be last checkpoint
					lastCheckpoint(player);
				else--or not
					--print("update move command");
					--addConsoleLangText("movedate");
					givePositionCommand(triggeredEventAreaEntryUnitId(), "move", path[player][i+1]);
				end
			end
		end
	end
end
