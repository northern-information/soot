Soot = {}




-- GLOBALS
-- GLOBALS
-- GLOBALS
-- GLOBALS

-- the arrow of time only goes one way, pairs well with modulo:
Soot._frame = 0

-- Soot uses a this convention for getters/setters and _variable names:
function Soot:frame()
  return self._frame
end

-- this is the directory where all the sprites live
Soot._dir = ""

function Soot:set_sprite_directory(dir)
  self._dir = dir
end

function Soot:dir()
  return self._dir
end


-- utility method
function Soot:scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "' .. directory .. '"')
  for filename in pfile:lines() do
    if filename ~= "." and filename ~= ".." then
      i = i + 1
      t[i] = filename
    end
  end
  pfile:close()
  return t
end




-- SCREEN
-- SCREEN
-- SCREEN
-- SCREEN

function Soot:redraw()
  screen.clear()
  screen.ping()
  screen.level(15)
  screen.move(16, 16)
  screen.text("the fall of math")
  screen.blend_mode('add')
  screen.display_png(mycelium:sprite_directory()  .. Soot:frame() % mycelium:png_count()  .. '.png',  mycelium._x,  mycelium._y)
  screen.display_png(dusty:sprite_directory()     .. Soot:frame() % dusty:png_count()     .. '.png',  dusty._x,     dusty._y)
  screen.display_png(quadrants:sprite_directory() .. Soot:frame() % quadrants:png_count() .. '.png',  quadrants._x, quadrants._y)
  screen.update()
end





-- BOILER GEEZER
-- BOILER GEEZER
-- BOILER GEEZER
-- BOILER GEEZER

-- call this before any tomfoolery with soot sprites begin!
function Soot:init()
  -- we do not want our sprites tied to norns' idea of bpm, so auto = false
  soot_lattice = lattice:new{ auto = false }
  -- this is the core sprocket that drives all the sprite animations
  sprocket_of_celestial_benevolence = soot_lattice:new_sprocket{
    action = function()
      self._frame = self._frame + 1
    end,
    -- division is now frames per second (in theory)
    division = 1 / 15,
  }
  soot_lattice:start()
  -- todo: how to call Soot:boiler_geezer_clock or self:boiler_geezer_clock?
  Soot_boiler_geezer_clock_id = clock.run(Soot_boiler_geezer_clock)
end

-- hopefully this very common function name doesn't pollute your project (see todo above):
function Soot_boiler_geezer_clock()
  while true do
    -- latice is built on 96 ppqn and Soot wants to think in fps
    clock.sleep(1/(96*4))
    -- manually pulse because auto is set to false
    soot_lattice:pulse()
    -- drive the core redraw function
    redraw()
  end
end

function Soot:cleanup()
  soot_lattice:destroy()
  clock.cancel(Soot_boiler_geezer_clock_id)
end




-- SPRITE
-- SPRITE
-- SPRITE
-- SPRITE

function Soot:sprite(name)
  local s = setmetatable({}, { __index = Soot })
  s.name = name
  s._x = 0
  s._y = 0
  s._loop = false
  s._pngs = self:scandir(self:dir() .. name)
  s._png_count = #s._pngs
  return s
end

function Soot:png_count()
  return self._png_count
end

-- returns the absolute path of this directory with trailing slash
function Soot:sprite_directory()
  return self._dir .. self.name .. "/"
end

function Soot:x(x)
  self._x = x
  return self
end

function Soot:y(y)
  self._y = y
  return self
end

-- function Soot:loop()
--   self._loop = true
--   return self
-- end

-- function Soot:stop_loop()
--   self._loop = false
--   return self
-- end

return Soot