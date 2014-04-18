local print = print -- the new env will prevent you from seeing global variables

local M = {}
if setfenv then
	setfenv(1, M) -- for 5.1
else
	_ENV = M -- for 5.2
end

--local is private


-- for getFactionPlayerType
ctClosed = 0;
ctCpuEasy = 1;
ctCpu = 2;
ctCpuUltra = 3;
ctCpuMega = 4;
ctNetwork = 5;
ctNetworkUnassigned = 6;
ctHuman = 7;

return M
