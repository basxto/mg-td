--earn gold for killed creeps
--TODO money and life tower
--addConsoleText(unitName(lastDeadUnit()));
if unitFaction(lastDeadUnit()) == 4 then
	local killerfaction = unitFaction(lastDeadUnitKiller());
	if lastDeadUnitKillerName() == "defense_tower" then
		giveResource("lives", killerfaction, 1);
		giveResource("gold", killerfaction, bounty[lastDeadUnitName()]);
	else
		giveResource("gold", killerfaction, bounty[lastDeadUnitName()]);
	end
	creepsonlane[killerfaction+1] = creepsonlane[killerfaction+1] - 1;
end
