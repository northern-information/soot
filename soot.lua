-- demo
tabutil = require("tabutil")
keyboard_controller = include "lib/keyboard_controller"

-- Soot
Soot = include "lib/Soot"


-- todo
-- sprite:some_way_to_control_speed(.5)

function init()
  -- demo controller, not actually part of the soot library
  keyboard_controller.init()

  -- always initialize with the aboslute path to your sprites
  -- second parameter is fps
  Soot.init("/home/we/dust/code/soot/sprites/", 15)

  -- "simple sprites" are either moving or not moving
  -- the name_*() methods accept a string which map to the name and directory by default
  Soot:name_sprite("dusty"):x(0):y(0):width(16):height(16):start()
  Soot:name_sprite("mycelium"):x(112):y(0):width(16):height(16):start()
  Soot:name_sprite("quadrants"):x(0):y(48):width(16):height(16):start()

  -- "toggle sprites" have two and only two states
  -- 0.png maps to "off", 1.png to "on"
  Soot:name_toggle_sprite("arrow_north")
    :x(112)
    :y(48)
    :width(8)
    :height(8)

  Soot:name_toggle_sprite("arrow_east")
    :x(120)
    :y(56)
    :width(8)
    :height(8)

  Soot:name_toggle_sprite("arrow_west")
    :x(104)
    :y(56)
    :width(8)
    :height(8)

  Soot:name_toggle_sprite("arrow_south")
    :x(112)
    :y(56)
    :width(8)
    :height(8)

  -- "cardinal sprites" face north, east, south, or west and are either moving or not moving
  -- cardinal sprites must have a n, e, s, and w directory in the sprite sub-directory
  Soot:name_cardinal_sprite("cci")
    :x(56)
    :y(24)
    :width(16)
    :height(16)

  -- newly-named sprites default to having a matching directory, but you can also set it explicity:
  Soot:name_cardinal_sprite("cci_half", "cci")
    :x(0)
    :y(24)
    :width(16)
    :height(16)
    :speed(.5)
end

function keyboard.code(code, value)
  keyboard_controller:handle_code(code, value)
end

function redraw()
  screen.clear()
  screen.ping()
  Soot:redraw()
  screen.update()
end

function cleanup()
  Soot:cleanup()
  keyboard_controller:cleanup()
end
