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
  elseif key == 'left' or key == 'a' then 
    shape:left_step()
  elseif key == 'right' or key == 'd' then 
    shape:right_step()
  end 
end 

function love.draw()
  grid:draw()
  shape:draw()
end 

function love.update(dt)
  grid = shape:update(dt, grid)
end 
