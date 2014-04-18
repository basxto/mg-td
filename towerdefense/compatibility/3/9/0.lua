--if isHuman == nil then
--	function isHuman(faction)
--		return isAI(faction)==0;
--	end
--end
function isAI(faction)
        --print(getPlayerName(faction))
        local result = 0
        --addConsoleLangText('test',getPlayerName(faction),string.upper(string.sub(getPlayerName(faction), 2, 4)))
        if string.upper(string.sub(getPlayerName(faction), 1, 3)) == 'CPU' then
                result = 1
        elseif string.upper(string.sub(getPlayerName(faction), 1, 4)) == '*AI*' then
                result = 1
        elseif string.upper(string.sub(getPlayerName(faction), 1, 3)) == '???' then
                result = 2
        elseif string.upper(string.sub(getPlayerName(faction), 2, 4)) == '???' then
                result = 2
        elseif string.upper(string.sub(getPlayerName(faction), 1, 7)) == 'NETWORK' or string.upper(string.sub(getPlayerName(faction), 1, 7)) == 'NETWERK' or string.upper(string.sub(getPlayerName(faction), 1, 8)) == 'NETZWERK' then
                result = 3
        end
        return result
end


if isHuman == nil then
	function isHuman(faction)
		return getFactionPlayerType(faction) == MgEnums.ctHuman;
	end
end
