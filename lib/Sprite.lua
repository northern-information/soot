Sprite = {}

function Sprite:_new(name, directory)
  local s = setmetatable({}, { __index = Sprite })
  s._name = name
  s._directory = directory and directory or name
  s._frame = 0
  s._x = 0
  s._width = 0
  s._y = 0
  s._height = 0
  s._heading = "n"
  s._visible = true
  s._moving = false
  s._on = false
  s._blend_mode = "add" -- i haven't experimented with anything other than add - tse
  s._speed = 1
  return s
end

function Sprite:new_simple(name, directory)
  local s = Sprite:_new(name, directory)
  s._is_simple = true
  s._is_toggle = false
  s._is_cardinal = false
  return s
end

function Sprite:new_toggle(name, directory)
  local s = Sprite:_new(name, directory)
  s._is_simple = false
  s._is_toggle = true
  s._is_cardinal = false
  return s
end

function Sprite:new_cardinal(name, directory)
  local s = Sprite:_new(name, directory)
  s._is_simple = false
  s._is_toggle = false
  s._is_cardinal = true
  return s
end


function Sprite:next()
  -- print(self._speed % Soot._fps)
  -- print((self._speed / 2) % Soot._fps)
  -- print((self._speed / 4) % Soot._fps)
  self._frame = util.wrap(self._frame + 1, 0, self:count() - 1)
  return self:current()
end

function Sprite:current()
  local heading = ""
  if (self._is_cardinal) then
    heading = self._heading .. "/"
  end
  return Soot._sprites_directory
    .. self._directory
    .. "/"
    .. heading
    .. self._frame
    .. ".png"
end

-- short circuit the frame to "on"
function Sprite:on()
  self._frame = 1
  return self:current()
end

-- short circuit the frame to "off"
function Sprite:off()
  self._frame = 0
  return self:current()
end

-- get the current sprite frame count
function Sprite:count()
  local heading = ""
  -- only cardinals use nested directories (for now...)
  if (self:is_cardinal()) then
    heading = self._heading
  end
  return #Soot:get_sprites(self._name, heading)
end

-- SETTERS
-- SETTERS
-- SETTERS
-- SETTERS
-- SETTERS

-- setters each "return self" to allow method chaining

function Sprite:named(name)
  self._name = name
  return self
end

function Sprite:show()
  self._visible = true
  return self
end

function Sprite:hide()
  self._visible = false
  return self
end

function Sprite:start()
  self._moving = true
  return self
end

function Sprite:stop()
  self._moving = false
  return self
end

-- used for "toggle sprites"
function Sprite:turn_on()
  self._on = true
  return self
end

-- used for "toggle sprites"
function Sprite:turn_off()
  self._on = false
  return self
end

-- used for "cardinal sprites"
function Sprite:heading(h)
  self._heading = h
  return self
end

function Sprite:x(x)
  self._x = x
  return self
end

function Sprite:width(w)
  self._width = w
  return self
end

function Sprite:y(y)
  self._y = y
  return self
end

function Sprite:height(h)
  self._height = h
  return self
end

function Sprite:blend_mode(mode)
  self._blend_mode = mode
  return self
end

function Sprite:speed(f)
  self._speed = f
  return f
end

-- GETTERS
-- GETTERS
-- GETTERS
-- GETTERS
-- GETTERS

function Sprite:get_directory()
  return self._directory
end

function Sprite:get_x()
  return self._x
end

function Sprite:get_y()
  return self._y
end

function Sprite:is_visible()
  return self._visible
end

function Sprite:is_moving()
  return self._moving
end

function Sprite:is_simple()
  return self._is_simple
end

function Sprite:is_toggle()
  return self._is_toggle
end

function Sprite:is_cardinal()
  return self._is_cardinal
end

-- used for "toggle sprites"
function Sprite:is_on()
  return self._on
end

function Sprite:get_blend_mode()
  return self._blend_mode
end

function Sprite:get_speed()
  return self._speed
end