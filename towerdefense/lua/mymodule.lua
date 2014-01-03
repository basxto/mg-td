local print = print -- the new env will prevent you from seeing global variables

local M = {}
if setfenv then
	setfenv(1, M) -- for 5.1
else
	_ENV = M -- for 5.2
end

--local is private




















return M
