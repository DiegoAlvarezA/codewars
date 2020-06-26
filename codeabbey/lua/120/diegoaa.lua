--[[
$ luacheck  diegoaa.lua #linting
Checking diegoaa.lua                              OK

Total: 0 warnings / 0 errors in 1 file
]]

require 'io'
local data = {}
local result = {}
local function split(s, delimiter)
    local splitted = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(splitted, match);
    end
    return splitted;
end
for line in io.lines("DATA.lst") do
    table.insert(data, (line))
end
local newData = split(data[2]," ")

for j = #newData, 2, -1
do
    local max = {
        value = tonumber(newData[1]),
        position = 1
    }
    for i = 1, j, 1
    do
        if tonumber(newData[i]) > max["value"] then
            max["value"] = tonumber(newData[i])
            max["position"] = i
        end
    end
    newData[max["position"]] = newData[j]
    newData[j] = max["value"]
    table.insert(result, max["position"]-1);
end
for i = 1, #result, 1
do
    io.write(result[i], " ")
end

--[[
$ lua diegoaa.lua
111 119 19 31 39 58 52 51 89 11 85 38 69 92 28 61 32 4 4 12 94 49 92 21 42
74 15 62 79 85 38 68 28 40 77 50 16 36 5 79 22 48 75 2 9 6 5 34 51 14 33 48 27
2 66 42 6 55 43 19 27 20 21 18 34 27 31 15 19 39 7 27 13 17 7 32 41 5 40 11 3
25 21 23 12 35 12 10 12 29 11 21 16 17 26 10 4 17 3 20 15 17 1 10 3 8 4 2 10 10
0 5 2 7 0 1 2 4 2 0 1
]]
