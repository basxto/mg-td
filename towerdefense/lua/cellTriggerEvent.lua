function cellTriggerEvent()

	function lastCheckpoint(player)
		if TD.stillalive[player] then
			giveResource("lives", player-1, -1);
			if 0 >= resourceAmount("lives",player-1) then --player lost
				TD.stillalive[player] = false;
				local lastplayer = true;
				for i = 1, TD.settings.humans do
					if TD.stillalive[i] then
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
		TD.waveManager.onlane[player] = TD.waveManager.onlane[player] - 1;
		if teleportUnits then
			nextPlayer = player;
			firtsTry = true;
			while firstTry or not(TD.stillalive[nextPlayer]) do
				nextPlayer = nextPlayer+1
				if nextPlayer == TD.settings.humans+1 then
					nextPlayer = 1;
				end
				firstTry = false;
			end
			givePositionCommand(triggeredEventAreaEntryUnitId(), "move", TD.settings.path[nextPlayer][2]);
			setUnitPosition(triggeredEventAreaEntryUnitId(), TD.settings.path[nextPlayer][1]);
			TD.waveManager.onlane[nextPlayer] = TD.waveManager.onlane[nextPlayer] + 1;
		else
			destroyUnit(triggeredEventAreaEntryUnitId());
		end
	end


	if unitFaction(triggeredEventAreaEntryUnitId()) == 4 then
		for player = 1, TD.settings.humans do
			for i = 2, #TD.settings.path[player] do
				--print(triggeredCellEventId().." == "..pathtrigger[player][i]);
				if triggeredCellEventId() == TD.pathtrigger[player][i] then --this is the right trigger!!!
					--print("reached ");
					addConsoleLangText("reached",i);
					if i == #TD.settings.path[player] then--could be last checkpoint
						lastCheckpoint(player);
					else--or not
						--print("update move command");
						--addConsoleLangText("movedate");
						givePositionCommand(triggeredEventAreaEntryUnitId(), "move", TD.settings.path[player][i+1]);
					end
				end
			end
		end
	end
end
return cellTriggerEvent;
