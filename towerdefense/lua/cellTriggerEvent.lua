

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
	destroyUnit(triggeredEventAreaEntryUnitId());
end


if unitFaction(triggeredEventAreaEntryUnitId()) == 4 then
	for player = 1, humans do
		for i = 2, #path[player] do
			--print(triggeredCellEventId().." == "..pathtrigger[player][i]);
			if triggeredCellEventId() == pathtrigger[player][i] then --this is the right trigger!!!
				if i == #path[player] then--could be last checkpoint
					lastCheckpoint(player);
				else--or not
					givePositionCommand(triggeredEventAreaEntryUnitId(), "move", path[player][i+1]);
				end
			end
		end
	end
end
