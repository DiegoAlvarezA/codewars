--[[
$ luacheck  diegoaa.lua #linting
Checking diegoaa.lua                              OK

Total: 0 warnings / 0 errors in 1 file
]]

require 'io'
local swaps = 0
local data = nil
local source = io.lines("DATA.lst")
local function split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
for line in source do
    data = line
end
local newData = split(data," ")
for i = 1, #newData-1, 1
do
    if tonumber(newData[i]) > tonumber(newData[i + 1])
        and newData[i + 1] ~= newData[#newData] then
        swaps = swaps + 1
        local n = newData[i + 1]
        newData[i + 1] = newData[i]
        newData[i] = n
    end
end
local function checksum(limit, seed)
    local result = 0
    for i = 1, #newData-1 do
        result = (result + tonumber(newData[i])) * seed
        if result > limit then
            result = result % limit
        end
    end
     return result
end
local limit = 10000007
local seed = 113
io.write(swaps, " ", checksum(limit, seed))

--[[
$ lua diegoaa.lua
41 1962385
]]
