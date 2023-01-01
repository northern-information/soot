include "lib/Sprite"

Soot = {}

function Soot.init(sprites_directory)
  -- example: "/home/we/dust/code/my_script/sprites/"
  Soot._sprites_directory = sprites_directory
  -- the arrow of time only goes one way, pairs well with modulo:
  Soot._frame = 0
  -- container for all our sprites
  Soot._sprites = {}
  -- we do not want our sprites tied to norns' idea of bpm, so auto = false
  Soot._lattice = lattice:new{ auto = false }
  -- this is the core sprocket that drives all the sprite animations
  sprocket_of_celestial_benevolence = Soot._lattice:new_sprocket{
    action = function()
      Soot._frame = Soot._frame + 1
    end,
    -- division is now frames per second (in theory)
    division = 1 / 15,
  }
  Soot._lattice:start()
  Soot._clock_id = clock.run(soot_clock)
end

-- simple sprites only have the default heading of "north"
function Soot:new_sprite(name)
  local sprite = Sprite:new_simple(name)
  self._sprites[name] = sprite
  return sprite
end

-- toggle sprites have two states (0, 1) and the default heading of "north"
function Soot:new_toggle_sprite(name)
  local sprite = Sprite:new_toggle(name)
  self._sprites[name] = sprite
  return sprite
end

-- cardinal sprites have different views for north, east, south, and west
function Soot:new_cardinal_sprite(name)
  local sprite = Sprite:new_cardinal(name)
  self._sprites[name] = sprite
  return sprite
end

-- get all the sprites in a named + heading
function Soot:get_sprites(name, heading)
  local heading = heading and heading or ""
  local absolute_path = self._sprites_directory .. name .. "/" .. heading
  local i, t, popen = 0, {}, io.popen
  local pfile = popen("ls -a " .. absolute_path)
  for filename in pfile:lines() do
    if filename ~= "." and filename ~= ".." then
      i = i + 1
      t[i] = filename
    end
  end
  pfile:close()
  return t
end

-- call this from your scripts standard redraw function
function Soot:redraw()
  screen.clear()
  screen.ping()
  screen.level(15)
  -- "add" stacks lighter pixels but ignores darker
  screen.blend_mode('add')
  -- loop through each sprite and render them accordingly
  for name, sprite in pairs(self._sprites) do
    self:draw_sprite(sprite)
  end
  screen.update()
end

-- handle each type of sprite & completely skip not visible ones
function Soot:draw_sprite(sprite)
  if (not sprite:is_visible())  then return end
  if (sprite:is_toggle())       then self:draw_toggle(sprite)   end
  if (sprite:is_cardinal())     then self:draw_cardinal(sprite) end
  if (sprite:is_simple())       then self:draw_simple(sprite)   end
end

function Soot:draw_toggle(sprite)
  if (sprite:is_on()) then
    screen.display_png(sprite:on(), sprite:get_x(), sprite:get_y())
  else
    screen.display_png(sprite:off(), sprite:get_x(), sprite:get_y())
  end
end

function Soot:draw_cardinal(sprite)
  self:draw_simple(sprite)
end

function Soot:draw_simple(sprite)
  if (sprite:is_moving()) then
    screen.display_png(sprite:next(), sprite:get_x(), sprite:get_y())
  else
    screen.display_png(sprite:current(), sprite:get_x(), sprite:get_y())
  end
end

-- simple clock to drive the lattice
function soot_clock()
  while true do
    -- lattice is built on 96 ppqn and Soot wants to think in fps
    -- clock.sleep(1/(96*4))
    clock.sleep(1/15)
    -- manually pulse because auto is set to false
    Soot._lattice:pulse()
    -- drive the core redraw function
    redraw()
  end
end

-- cleanup
function Soot:cleanup()
  Soot._lattice:destroy()
  clock.cancel(self._clock_id)
end

return Soot