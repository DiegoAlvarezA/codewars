--[[
$ luacheck  diegoaa.lua #linting
Checking diegoaa.lua                              OK

Total: 0 warnings / 0 errors in 1 file
]]

require 'io'
local suits = {"Clubs", "Spades", "Diamonds", "Hearts"}
local ranks = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen",                   "King", "Ace"}
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
for i = 1, data[1], 1
do
    local suit_value = tonumber(newData[i]) // 13
    local rank_value = tonumber(newData[i]) % 13

    local suit = suits[suit_value + 1]
    local rank = ranks[rank_value + 1]
    table.insert(result, (rank.."-of-"..suit))
end

for i = 1, data[1], 1
do
    io.write(result[i], " ")
end

--[[
$ lua diegoaa.lua
King-of-Hearts King-of-Clubs 4-of-Spades
4-of-Clubs Queen-of-Clubs Jack-of-Diamonds
Ace-of-Clubs 9-of-Diamonds 7-of-Clubs Queen-of-Hearts
Queen-of-Diamonds 7-of-Hearts 7-of-Diamonds
Queen-of-Spades 6-of-Hearts 3-of-Hearts 9-of-Clubs
10-of-Diamonds 6-of-Diamonds 2-of-Clubs
King-of-Spades 2-of-Hearts Ace-of-Diamonds
Jack-of-Hearts 10-of-Clubs 5-of-Diamonds
]]
