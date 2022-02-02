local rot = {}

-- the frist coordinate is marked as the center or the origin of the piece
-- it'll the only coordinate that will update as it goes down
-- when drawing the piece the positions of the other boxes will be determined
-- by an offeset in relation to the center

rot =     {{{0, 0}, {-1, 1}, {0, -1}, {0, 1},
          {0, 0}, {-1, 1}, {-1, 0}, {1, 0},
          {0, 0}, {1, 1}, {0, 1}, {0, -1},
          {0, 0}, {-1, 0}, {1, 0}, {1, -1}},
          
          {{0, 0}, {-1, 1}, {-1, 0}, {0, -1},
          {0, 0}, {-1, 0}, {0, 1}, {1, 1},
          {0, 0}, {0, 1}, {1, 0}, {1, -1}, 
          {0, 0}, {-1, -1}, {0, -1}, {1, 0}}}

local Shape = {}
function Shape:new(columns, rows, size)
  local o = {}
  setmetatable(o, self)
  self.__index = self 
  self.c = columns 
  self.r = rows 
  self.size = size 
  self.clock = 0
  self.timer = 0.7
  -- select a shape at random
  self.s = {{0, 0}, {-1, 1}, {0, -1}, {0, 1}}--rot[math.random(#rot)][1]
  
  self.s[1] = {self.c / 1, 1}
  print(self.s[1], print(self.s[2]), print(self.s[3]), print(self.s[4]))
  return o 
end 

function Shape:draw()
  local x = self.s[1][1]
  local y = self.s[1][2]
  local x1 = x + self.s[2][1]
  local y1 = y + self.s[2][2]
  local x2 = x + self.s[3][1]
  local y2 = y + self.s[3][2]
  local x3 = x + self.s[4][1]
  local y3 = y + self.s[4][2]
  love.graphics.rectangle('fill', x * self.size, y * self.size, self.size, self.size)
  love.graphics.rectangle('fill', x1 * self.size, y1 * self.size, self.size, self.size)
  love.graphics.rectangle('fill', x2 * self.size, y2 * self.size, self.size, self.size)
  love.graphics.rectangle('fill', x3 * self.size, y3 * self.size, self.size, self.size)
end 

function Shape:update(dt)
  self.clock = self.clock + dt 
  if self.clock >= self.timer then 
    self.s[1][2] = self.s[1][2] + 1
    self.clock = 0
  end
  if self.s[1][2] > self.r then 
    self.s = rot[math.random(#rot)]
    self.s[1] = {self.c / 1, 1}
  end 
end 

return Shape 