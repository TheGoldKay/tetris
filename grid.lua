local Grid = {}

function Grid:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self 
  self.c = 14 -- grid's columns
  self.r = 28 -- grid's rows 
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  self.size = width / self.c  
  -- making grid's boxes
  self.boxes = {}
  for i = 0, self.r do 
    local line = {}
    for j = 0, self.c do 
      -- column and row index (position) // val == 0 means empty, if 1 it's a box to be drawn
      table.insert(line, {c = j, r = i, val = 0}) 
    end 
    table.insert(self.boxes, line)
  end 
  return o 
end 

function Grid:set(row, col)
  self.boxes[row][col+1].val = 1 
end 

function Grid:filled(x, y)
  if x < self.c and y < self.r then 
    return self.boxes[y][x].val == 1
  end 
  return false 
end 

function Grid:draw()
  for _, line in ipairs(self.boxes) do 
    for _, box in ipairs(line) do 
      local x = box.c * self.size 
      local y = box.r * self.size 
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