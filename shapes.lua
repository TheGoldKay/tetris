local rot = {}

-- the frist coordinate is marked as the center or the origin of the piece
-- it'll the only coordinate that will update as it goes down
-- when drawing the piece the positions of the other boxes will be determined
-- by an offeset in relation to the center

local s = {
  {{0, 0}, {-1, 1}, {-1, 0}, {0, -1}},
  {{0, 0}, {-1, -1}, {0, -1}, {1, 0}}
}

table.insert(rot, s)

local z = {
  {{0, 0}, {-1, -1}, {-1, 0}, {0, 1}},
  {{0, 0}, {-1, 0}, {0, -1}, {1, -1}}
}

table.insert(rot, z)

local t = {
  {{0, 0}, {-1, 0}, {1, 0}, {0, 1}},
  {{0, 0}, {-1, 0}, {1, 0}, {0, -1}},
  {{0, 0}, {0, -1}, {0, 1}, {1, 0}},
  {{0, 0}, {0, -1}, {0, 1}, {-1, 0}}
}

table.insert(rot, t)

local l = {
  {{0, 0}, {1, 0}, {-1, 0}, {-2, 0}},
  {{0, 0}, {0, 1}, {0, -1}, {0, -2}}
}

table.insert(rot, l)

local o = {
  {{0, 0}, {-1, 0}, {-1, -1}, {0, -1}}
}

table.insert(rot, o)

local Shape = {}
function Shape:new(columns, rows, size)
  local o = {}
  setmetatable(o, self)
  self.__index = self 
  self.c = columns 
  self.r = rows 
  self.size = size 
  self.clock = 0
  self.timer = 0.1--0.7
  -- select a shape at random
  math.randomseed(os.time())
  self:new_shape()
  return o 
end 

function Shape:new_shape()
  self.sp = rot[math.random(#rot)]
  self.face = 1 -- first rotation
  -- assign the pivot (center / origin) the initial position
  self.sp[self.face][1] = {self.c / 2, 1}
end 


function Shape:pos()
  local x = self.sp[self.face][1][1]
  local y = self.sp[self.face][1][2]
  local x1 = x + self.sp[self.face][2][1]
  local y1 = y + self.sp[self.face][2][2]
  local x2 = x + self.sp[self.face][3][1]
  local y2 = y + self.sp[self.face][3][2]
  local x3 = x + self.sp[self.face][4][1]
  local y3 = y + self.sp[self.face][4][2]
  return {{x, y}, {x1, y1}, {x2, y2}, {x3, y3}}
end 

function Shape:left_step()
  self.sp[self.face][1][1] = self.sp[self.face][1][1] - 1
end 

function Shape:right_step()
  self.sp[self.face][1][1] = self.sp[self.face][1][1] + 1
end 

function Shape:draw()
  local p = self:pos()
  love.graphics.setColor(0, 0.5, 0.5)
  love.graphics.rectangle('fill', p[1][1] * self.size, p[1][2] * self.size, self.size, self.size)
  love.graphics.rectangle('fill', p[2][1] * self.size, p[2][2] * self.size, self.size, self.size)
  love.graphics.rectangle('fill', p[3][1] * self.size, p[3][2] * self.size, self.size, self.size)
  love.graphics.rectangle('fill', p[4][1] * self.size, p[4][2] * self.size, self.size, self.size)
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle('line', p[1][1] * self.size, p[1][2] * self.size, self.size, self.size)
  love.graphics.rectangle('line', p[2][1] * self.size, p[2][2] * self.size, self.size, self.size)
  love.graphics.rectangle('line', p[3][1] * self.size, p[3][2] * self.size, self.size, self.size)
  love.graphics.rectangle('line', p[4][1] * self.size, p[4][2] * self.size, self.size, self.size)
  love.graphics.setColor(0.3, 0.2, 0)
end 

function Shape:rotate()
  local old_pos = self.sp[self.face][1]
  self.face = self.face + 1
  if self.face > #self.sp then 
    self.face = 1 
  end 
  self.sp[self.face][1] = old_pos
end 

function Shape:get_shape_bottom()
  local pos = self:pos()
  local y = -3
  for _, p in ipairs(pos) do 
    if p[2] > y then 
      y = p[2]
    end 
  end
  return y + 1 -- +1 for the square/box length (because y is the upper left corner position)
end 

function Shape:add(grid)
  local pos = self:pos()
  for _, p in ipairs(pos) do 
    grid:set(p[2], p[1])
  end 
  return grid 
end 

function Shape:collide(grid)
  local pos = self:pos()
  for _, line in ipairs(grid.boxes) do 
    for _, box in ipairs(line) do 
      local x, y, val = box.x, box.y, box.val
      for _, coo in ipairs(pos) do 
        if coo[1] == x and coo[2] == y and val == 1 then 
          return true 
        end  
      end 
    end 
  end 
  return false 
end 


function Shape:update(dt, grid)
  self.clock = self.clock + dt 
  if self.clock >= self.timer then 
    self.sp[self.face][1][2] = self.sp[self.face][1][2] + 1
    self.clock = 0
  end
  local y = self:get_shape_bottom()
  if y  > self.r or self:collide(grid) then 
    grid = self:add(grid)
    self:new_shape()
  end
  return grid 
end 

return Shape 