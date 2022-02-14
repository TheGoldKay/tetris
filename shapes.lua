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
  self.timer = 0.7
  -- select a shape at random
  math.randomseed(os.time())
  self.sp = rot[math.random(#rot)]
  self.face = 1 -- first rotation
  -- assign the pivot (center / origin) the initial position
  self.sp[self.face][1] = {self.c / 2, self.r / 2}
  return o 
end 

function Shape:draw()
  local x = self.sp[self.face][1][1]
  local y = self.sp[self.face][1][2]
  local x1 = x + self.sp[self.face][2][1]
  local y1 = y + self.sp[self.face][2][2]
  local x2 = x + self.sp[self.face][3][1]
  local y2 = y + self.sp[self.face][3][2]
  local x3 = x + self.sp[self.face][4][1]
  local y3 = y + self.sp[self.face][4][2]
  love.graphics.setColor(0, 0.5, 0.5)
  love.graphics.rectangle('fill', x * self.size, y * self.size, self.size, self.size)
  love.graphics.rectangle('fill', x1 * self.size, y1 * self.size, self.size, self.size)
  love.graphics.rectangle('fill', x2 * self.size, y2 * self.size, self.size, self.size)
  love.graphics.rectangle('fill', x3 * self.size, y3 * self.size, self.size, self.size)
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle('line', x * self.size, y * self.size, self.size, self.size)
  love.graphics.rectangle('line', x1 * self.size, y1 * self.size, self.size, self.size)
  love.graphics.rectangle('line', x2 * self.size, y2 * self.size, self.size, self.size)
  love.graphics.rectangle('line', x3 * self.size, y3 * self.size, self.size, self.size)
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