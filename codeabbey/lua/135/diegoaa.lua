--[[
$ luacheck  diegoaa.lua #linting
Checking diegoaa.lua                              OK

Total= 0 warnings / 0 errors in 1 file
]]

require "io"
local t = {
[" "] = "11"           ,  ["e"] = "101",
["t"] = "1001"         ,  ["o"] = "10001",
["n"] = "10000"        ,  ["a"] = "011",
["s"] = "0101"         ,  ["i"] = "01001",
["r"] = "01000"        ,  ["h"] = "0011",
["d"] = "00101"        ,  ["l"] = "001001",
["!"] = "001000"       ,  ["u"] = "00011",
["c"] = "000101"       ,  ["f"] = "000100",
["m"] = "000011"       ,  ["p"] = "0000101",
["g"] = "0000100"      ,  ["w"] = "0000011",
["b"] = "0000010"      ,  ["y"] = "0000001",
["v"] = "00000001"     ,  ["j"] = "000000001",
["k"] = "0000000001"   ,  ["x"] = "00000000001",
["q"] = "000000000001" ,  ["z"] = "000000000000"
}
local binValues = {
  ["0000"] = "0",
  ["0001"] = "1",
  ["0010"] = "2",
  ["0011"] = "3",
  ["0100"] = "4",
  ["0101"] = "5",
  ["0110"] = "6",
  ["0111"] = "7",
  ["1000"] = "8",
  ["1001"] = "9",
  ["1010"] = "A",
  ["1011"] = "B",
  ["1100"] = "C",
  ["1101"] = "D",
  ["1110"] = "E",
  ["1111"] = "F"
}

local data = {}
local result = {}
for line in io.lines("DATA.lst") do
    table.insert(data, (line))
end
local function toHex(bin)
    local h = ""
    local b = ""
    for i = 1, #bin, 4 do
        b = string.sub(bin, i, i+3)
        h = h..binValues[b]
    end
    return h
end
local bits = {}
for c in data[1]:gmatch(".") do
    table.insert(result, tostring(t[c]))
end
for c in table.concat(result):gmatch(".") do
   table.insert(bits, c)
end
local byte = ""
for i = 1, #bits, 1
do
    byte = byte..bits[i]
    if #byte == 8 then
        io.write(toHex(byte), " ")
        byte = ""
    end
    if i == #bits and #byte < 8 then
        local binaryCount = 8 - #byte
        for j = 1, binaryCount do byte = byte.."0" end
        print(toHex(byte), " ")
    end
end

--[[
$ lua diegoaa.lua
2D 14 96 8B C9 DC 56 35 AB 83 34 8A 7A 43 0B 49 E4 E8 7C C7 93 BA D0 AD 0E 53
18 64 03 B9 C4 92 F2 75 6E 41 DC DA EC 11 52 2B 9A 5C 80 91 01 A8 80 76 13 9D
45 C1 01 CB 45 25 A1 30 09 8D 78 8E 78 89 9A 57 20 2A 23 34 59 4C 61 B8 17 22
4E E3 83 82 43 88 D7 20 B4 52 5A 1C A6 30 E2 27 27 79 34 A2 6D 86 40 E0 99 A5
C8 59 73 57 88 99 0C 3A 84 8A C0
]]
