Sprite = {}

function Sprite:_new(name)
  local s = setmetatable({}, { __index = Sprite })
  s._name = name
  s._frame = 0
  s._x = 0
  s._width = 0
  s._y = 0
  s._height = 0
  s._heading = "n"
  s._visible = true
  s._moving = false
  s._on = false
  return s
end

function Sprite:new_simple(name)
  local s = Sprite:_new(name)
  s._is_simple = true
  s._is_toggle = false
  s._is_cardinal = false
  s._north = Soot:get_sprites(name)
  s._north_count = #s._north
  return s
end

function Sprite:new_toggle(name)
  local s = Sprite:_new(name)
  s._is_simple = false
  s._is_toggle = true
  s._is_cardinal = false
  s._north = Soot:get_sprites(name)
  s._north_count = #s._north
  return s
end

function Sprite:new_cardinal(name)
  local s = Sprite:_new(name)
  s._is_simple = false
  s._is_toggle = false
  s._is_cardinal = true
  s._north = Soot:get_sprites(name, "n")
  s._east  = Soot:get_sprites(name, "e")
  s._south = Soot:get_sprites(name, "s")
  s._west  = Soot:get_sprites(name, "w")
  s._north_count = #s._north
  s._east_count  = #s._east
  s._south_count = #s._south
  s._west_count  = #s._west
  return s
end

function Sprite:new_simple(name)
  local s = Sprite:_new(name)
  s._is_cardinal = false
  s._is_simple = true
  s._north = Soot:get_sprites(name)
  s._north_count = #s._north
  return s
end

function Sprite:next()
  self._frame = util.wrap(self._frame + 1, 0, self:count() - 1)
  return self:current()
end

function Sprite:current()
  local heading = ""
  if (self._is_cardinal) then
    heading = self._heading .. "/"
  end
  return Soot._sprites_directory
    .. self._name
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
-- "toggle" and "simple" sprites are considered "north"
function Sprite:count()
  if self._heading == "n" then return self._north_count end
  if self._heading == "e" then return self._east_count end
  if self._heading == "s" then return self._south_count end
  if self._heading == "w" then return self._west_count end
end

-- SETTERS
-- SETTERS
-- SETTERS
-- SETTERS
-- SETTERS

-- setters each "return self" to allow method chaining

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

-- GETTERS
-- GETTERS
-- GETTERS
-- GETTERS
-- GETTERS

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