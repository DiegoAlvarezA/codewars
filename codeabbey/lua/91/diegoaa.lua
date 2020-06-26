--[[
$ luacheck  diegoaa.lua #linting
Checking diegoaa.lua                              OK

Total: 0 warnings / 0 errors in 1 file
]]

require 'io'
local grid = {}
local movements = {}
local result = {[1] = 0, [2] = 0, [3] = 0, [4] = 0}
local i = 1
local function split(s, delimiter)
  local splitted = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(splitted, match);
  end
  return splitted;
end
for line in io.lines("DATA.lst") do
  grid[i] = {}
  local newLine = split(line," ")
  for j = 1, 4, 1 do
    grid[i][j] = tonumber(newLine[j])
  end
  if i == 5 then movements = newLine end
  i = i + 1
end
local action = {
  ["D"] = function (position, column)
  for j = position, 1, -1 do
    if j == 1 or grid[j-1][column] == nil then
      grid[j][column] = nil
      return
    end
    grid[j][column] = grid[j-1][column]
  end
  end,
  ["R"] = function (position, row)
  for j = position, 1, -1 do
    if j == 1 or grid[row][j-1] == nil then
      grid[row][j] = nil
      return
    end
    grid[row][j] = grid[row][j-1]
  end
  end,
  ["L"] = function (position, row)
  for j = position, 4, -1 do
    if j == 4 or grid[row][j+1] == nil then
      grid[row][j] = nil
      return
    end
    grid[row][j] = grid[row][j+1]
  end
  end,
  ["U"] = function (position, row)
  for j = position, 4, 1 do
    if j == 4 or grid[j+1][row] == nil then
      grid[j][row] = nil
      return
    end
    grid[j][row] = grid[j+1][row]
  end
  end,
}
local formatter = function(type, from, to, step)
  local value
  for k = 1, 4 do
    local new = {}
    for j = from, to, step do
      if type == "DU" then value = grid[j][k]
      elseif type == "LR" then value = grid[k][j]
      end
      if value ~= nil then
      table.insert(new, value)
      end
  end
  if #new > 0 then
    local iter = 1
    for j = from, to, step do
      if new[iter] ~= nil then
        if type == "DU" then grid[j][k] = new[iter]
        elseif type == "LR" then grid[k][j] = new[iter]
        end
      else
        if type == "DU" then grid[j][k] = nil
        elseif type == "LR" then grid[k][j] = nil
        end
      end
      iter = iter + 1
    end
  end
  end
end
local function up()
  for k = 1, 4 do
    for j = 1, 4 do
      if j ~= 4 and grid[j][k] ~= nil then
        if grid[j][k] == grid[j+1][k] then
          grid[j][k] = grid[j][k] + grid[j+1][k]
          action["U"](j+1, k)
        end
      end
    end
  end
  formatter("DU", 1, 4, 1)
end
local function down()
  for k = 1, 4 do
    for j = 4, 1, -1 do
      if j ~= 1 and grid[j][k] ~= nil then
        if grid[j][k] == grid[j-1][k] then
          grid[j][k] = grid[j][k] + grid[j-1][k]
          action["D"](j-1, k)
        end
      end
    end
  end
  formatter("DU", 4, 1, -1)
end
local function right()
  for k = 1, 4 do
    for j = 4, 1, -1 do
      if j ~= 1 and grid[k][j] ~= nil then
        if grid[k][j] == grid[k][j-1] then
          grid[k][j] = grid[k][j] + grid[k][j-1]
          action["R"](j-1, k)
        end
      end
    end
  end
  formatter("LR", 4, 1, -1)
end
local function left()
  for k = 1, 4 do
    for j = 1, 4 do
      if j ~= 1 and grid[k][j] ~= nil then
        if grid[k][j] == grid[k][j-1] then
          grid[k][j] = grid[k][j] + grid[k][j-1]
          action["R"](j-1, k)
        end
      end
    end
  end
  formatter("LR", 1, 4, 1)
end
for j = 1, #movements do
  if movements[j] == "D" then down()
  elseif movements[j] == "R" then right()
  elseif movements[j] == "L" then left()
  elseif movements[j] == "U" then up()
  end
end
for j = 1, 4 do
  for k = 1, 4 do
    if grid[j][k] ~= nil then
      if grid[j][k] == 2 then result[1] =  result[1] + 1
      elseif grid[j][k] == 4 then result[2] =  result[2] + 1
      elseif grid[j][k] == 8 then result[3] =  result[3] + 1
      elseif grid[j][k] == 16 then result[4] =  result[4] + 1
      end
    end
  end
end
for j = 1, 4 do
  io.write(result[j], " ")
end

--[[
$ lua diegoaa.lua
2 4 1 1
]]
