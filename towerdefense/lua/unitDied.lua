--earn gold for killed creeps
--TODO money and life tower
addConsoleText(unitName(lastDeadUnit()));
if unitFaction(lastDeadUnit()) == 4 then
	local killerfaction = unitFaction(lastDeadUnitKiller());
	giveResource("gold", killerfaction, bounty[unitName(lastDeadUnit())]);
	creepsonlane[killerfaction+1] = creepsonlane[killerfaction+1] - 1;
end
