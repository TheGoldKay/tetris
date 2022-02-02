Shapes = require 'shapes'
Grid = require 'grid'

function love.load()
  grid = Grid:new()
end 

function love.keypressed(key)
  if key == 'escape' then 
    love.window.close()
  end 
end 

function love.draw()
  grid:draw()
end 