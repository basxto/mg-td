function isHuman(player)
	local name = string.upper(getPlayerName(player));
	print(name)
	return (name~="CPU" and name~="NET")
end
