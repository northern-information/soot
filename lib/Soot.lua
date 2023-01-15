include "lib/Sprite"

Soot = {}

function Soot.init(sprites_directory, fps)
  if (sprites_directory == nil or sprites_directory == "") then
    Soot:error("Sprite base directory required.")
  end
  -- example: "/home/we/dust/code/my_script/sprites/"
  Soot._sprites_directory = sprites_directory
    -- container for all our sprites
  Soot._sprites = {}
  -- the arrow of time only goes one way, pairs well with modulo:
  Soot._arrow_of_time = 0
  -- frames per second
  Soot._fps = fps and fps or 15
  Soot._clock_id = clock.run(soot_clock)
end

function soot_clock()
  while true do
    clock.sleep(1 / Soot._fps)
    Soot._arrow_of_time = Soot._arrow_of_time + 1
    redraw()
  end
end

-- cleanup
function Soot:cleanup()
  clock.cancel(self._clock_id)
end

function Soot:error(message)
  print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
  print("Soot Error: " .. message)
  print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
end

function Soot:warning(message)
  print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
  print("Soot Warning: " .. message)
  print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
end

-- get a sprite by name
function Soot:get(name)
  local sprite = self._sprites[name]
  if (sprite == nil) then
    self:error("No sprite named " .. name .. ".")
  else
    return sprite
  end
end

-- instantinate a new sprite
-- simple sprites have the default heading of "north"
function Soot:name_sprite(name, directory)
  local sprite = Sprite:new_simple(name, directory)
  self._sprites[name] = sprite
  return sprite
end

-- toggle sprites have two states (0, 1) and the default heading of "north"
function Soot:name_toggle_sprite(name, directory)
  local sprite = Sprite:new_toggle(name, directory)
  self._sprites[name] = sprite
  return sprite
end

-- cardinal sprites have different views for north, east, south, and west
function Soot:name_cardinal_sprite(name, directory)
  local sprite = Sprite:new_cardinal(name, directory)
  self._sprites[name] = sprite
  return sprite
end

-- get all the sprites in a named + heading
function Soot:get_sprites(name, heading)
  local sprite = self:get(name)
  local heading = heading and heading or ""
  local absolute_path = self._sprites_directory .. sprite:get_directory() .. "/" .. heading
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
  -- loop through each sprite and render them accordingly
  for name, sprite in pairs(self._sprites) do
    self:draw_sprite(sprite)
  end
end

-- handle each type of sprite & completely skip not visible ones
function Soot:draw_sprite(sprite)
  if (not sprite:is_visible())  then return end
  if (sprite:is_toggle())       then self:draw_toggle(sprite)   end
  if (sprite:is_cardinal())     then self:draw_cardinal(sprite) end
  if (sprite:is_simple())       then self:draw_simple(sprite)   end
end

-- screen abstractions should only live on draw_* methods
function Soot:draw_toggle(sprite)
  screen.blend_mode(sprite:get_blend_mode())
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
  screen.blend_mode(sprite:get_blend_mode())
  if (sprite:is_moving()) then
    screen.display_png(sprite:next(), sprite:get_x(), sprite:get_y())
  else
    screen.display_png(sprite:current(), sprite:get_x(), sprite:get_y())
  end
end

-- "move line rel stroke"
function Soot:mlrs(x1, y1, x2, y2, l)
  screen.level(l or 15)
  screen.move(x1, y1)
  screen.line_rel(x2, y2)
  screen.stroke()
end

-- "move line stroke"
function Soot:mls(x1, y1, x2, y2, l)
  screen.level(l or 15)
  screen.move(x1, y1)
  screen.line(x2, y2)
  screen.stroke()
end

-- rectangle
function Soot:rect(x, y, w, h, l)
  screen.level(l or 15)
  screen.rect(x, y, w, h)
  screen.fill()
end

-- o
function Soot:circle(x, y, r, l)
  screen.level(l or 15)
  screen.circle(x, y, r)
  screen.fill()
end

-- <<<
function Soot:text(x, y, s, l)
  screen.level(l or 15)
  screen.move(x, y)
  screen.text(s)
end

-- >>>
function Soot:text_right(x, y, s, l)
  screen.level(l or 15)
  screen.move(x, y)
  screen.text_right(s)
end

-- |||
function Soot:text_center(x, y, s, l)
  screen.level(l or 15)
  screen.move(x, y)
  screen.text_center(s)
end

return Soot