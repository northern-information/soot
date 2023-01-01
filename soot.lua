-- demo
tabutil = require("tabutil")
lattice = require("lattice")
keyboard_controller = include "lib/keyboard_controller"

-- Soot
Soot = include "lib/Soot"


-- todo
-- sprite:pin_here_on_the_map()
-- sprite:some_way_to_control_speed(.5)
-- map.init() cartographies...

function init()
  -- demo controller, not actually part of the soot library
  keyboard_controller.init()

  -- always initialize with the aboslute path to your sprites
  Soot.init("/home/we/dust/code/soot/sprites/")

  -- "simple sprites" are either moving or not moving
  -- the new_*() methods accept a string which match the sprite sub-directory
  dusty = Soot:new_sprite("dusty"):x(0):y(0):width(16):height(16):start()
  mycelium = Soot:new_sprite("mycelium"):x(112):y(0):width(16):height(16):start()
  quadrants = Soot:new_sprite("quadrants"):x(0):y(48):width(16):height(16):start()

  -- "toggle sprites" have two and only two states
  -- 0.png maps to "off", 1.png to "on"
  arrow_north = Soot:new_toggle_sprite("arrow_north"):x(112):y(48):width(8):height(8)
  arrow_east  = Soot:new_toggle_sprite("arrow_east"):x(120):y(56):width(8):height(8)
  arrow_west  = Soot:new_toggle_sprite("arrow_west"):x(104):y(56):width(8):height(8)
  arrow_south = Soot:new_toggle_sprite("arrow_south"):x(112):y(56):width(8):height(8)

  -- "cardinal sprites" face north, east, south, or west and are either moving or not moving
  -- cardinal sprites must have a n, e, s, and w directory in the sprite sub-directory
  cci = Soot:new_cardinal_sprite("cci"):x(56):y(24):width(16):height(16)
end

function keyboard.code(code, value)
  keyboard_controller:handle_code(code, value)
end

function redraw()
  Soot:redraw()
end

function cleanup()
  Soot:cleanup()
  keyboard_controller:cleanup()
end