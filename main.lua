Shape = require 'shapes'
Grid = require 'grid'

function love.load()
  grid = Grid:new()
  shape = Shape:new(grid.c, grid.r, grid.size)
end 

function love.keypressed(key)
  if key == 'escape' then 
    love.window.close()
    os.exit()
  elseif key == 'space' then 
    shape:rotate()
  end 
end 

function love.draw()
  grid:draw()
  shape:draw()
end 

function love.update(dt)
  --shape:update(dt)
end 
