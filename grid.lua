Conf = require "conf"
local Grid = {}

function Grid:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self 
  self.c = Conf.columns -- grid's columns
  self.r = Conf.rows -- grid's rows 
  local width = Conf.width
  local height = Conf.height
  self.size = width / self.c  
  -- making grid's boxes
  self.boxes = {}
  for i = 0, self.r do 
    local line = {}
    for j = 0, self.c do 
      -- column and row index (position) // val == 0 means empty, if 1 it's a box to be drawn
      table.insert(line, {x = j, y = i, val = 0}) 
    end 
    table.insert(self.boxes, line)
  end 
  for _, line in ipairs(self.boxes) do 
    for _, box in ipairs(line) do 
      print(box.x, box.y, box.val)
    end 
  end 
  return o 
end 

function Grid:set(row, col)
  self.boxes[row][col+1].val = 1 
end 

function Grid:draw()
  for _, line in ipairs(self.boxes) do 
    for _, box in ipairs(line) do 
      local x = box.x * self.size 
      local y = box.y * self.size 
      if box.val == 1 then 
        love.graphics.setColor(0, 0.5, 0.5)
        love.graphics.rectangle('fill', x, y, self.size, self.size)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('line', x, y, self.size, self.size)
        love.graphics.setColor(0.3, 0.2, 0)
      else 
        love.graphics.rectangle('line', x, y, self.size, self.size)
      end 
    end 
  end 
end 

return Grid 