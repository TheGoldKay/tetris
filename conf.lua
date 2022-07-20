local conf = {}

conf.width = 400
conf.height = 800
conf.columns = 20
conf.rows = 40

function love.conf(t)
  t.window.width = conf.width
  t.window.height = conf.height
  t.window.title = "Testris"
end 

return conf