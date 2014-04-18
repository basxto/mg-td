--earn gold for killed creeps
--TODO money and life tower
--addConsoleText(unitName(lastDeadUnit()));
if unitFaction(lastDeadUnit()) == 4 then
	local killerfaction = unitFaction(lastDeadUnitKiller());
	if lastDeadUnitKillerName() == "defense_tower" then
		giveResource("lives", killerfaction, 1);
		addConsoleLangText("interest",TD.settings.bounty[lastDeadUnitName()], lastDeadUnitName())
		giveResource("gold", killerfaction, TD.settings.bounty[lastDeadUnitName()]);
	else
		addConsoleLangText("interest",killerfaction, bounty[lastDeadUnitName()])
		giveResource("gold", killerfaction, TD.settings.bounty[lastDeadUnitName()]);
	end
	TD.waveManager.onlane[killerfaction+1] = TD.waveManager.onlane[killerfaction+1] - 1;
end
