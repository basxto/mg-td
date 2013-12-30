if unitFaction(triggeredEventAreaEntryUnitId()) == 4 then
	local player = 1;
	local exists = false;
	while humans >= player do
		local i = 2;--first one has no triggers
		local length = table.getn(path[1]);
		--loop through the path
		while length >= i do
			--check if this checkpoint is reached
			if triggeredCellEventId() == pathtrigger[player][i] then
				exists = true;--if the game got loaded some triggers won't be in that table
				if i == length then
					--unit reached last checkpoint
					--destroy unit and loose one life
					if stillalive[player] == true then
						giveResource("lives", player-1, -1);
						if 0 >= resourceAmount("lives", player-1) then
							local lastplayer = true;
							local i = 1;
							while humans > i do
								if i ~= player then
									lastplayer = lastplayer and not(stillalive[i]==true);
								end
								i = i + 1;
							end
							if lastplayer then
								addConsoleLangText("won",getPlayerName(player-1))
								showMessage("won", "won")
								setPlayerAsWinner(player-1);
								endGame();
							else
								addConsoleLangText("lost",getPlayerName(player-1))
								showMessage("lost", "lost")
							end
							stillalive[player] = false;
							--[[while resourceAmount("gold", player-1) > 0 do
								giveResource("gold", player-1, -1);
							end]]--
							if unitCount(player-1) > 1 then
								local towers = getUnitsForFaction(player-1, "attack", 0)
								for i,v in pairs(towers) do 
									print(i..": "..v.." ("..unitName(v)..")");
									unitDestroy(v);
								end
							end
							local workers = getUnitsForFaction(player-1, "build", 0)
							for i,v in pairs(workers) do 
								print(i..": "..v.." ("..unitName(v)..")");
								morphToUnit(v,"goldworker",1);
							end
						end
						--TODO kill all towers set gold to 0
					end
					creepsonlane[player] = creepsonlane[player] - 1;
					destroyUnit(triggeredEventAreaEntryUnitId());
				else 
					--send unit to next checkpoint
					givePositionCommand(triggeredEventAreaEntryUnitId(), "move", path[player][i+1]);
					--BUG: worker also gets this command
				end
			end
			i = i + 1;
		end
		player = player + 1;
	end
	if exists == false then --delete this trigger
		unregisterCellTriggerEvent(triggeredCellEventUnitId());
		print("a trigger from an older session got deleted");
	end
end
