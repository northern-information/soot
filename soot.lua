-- demo

tabutil = require("tabutil")
lattice = require("lattice")
Soot = include "lib/Soot"

function init()
  Soot:init()
  Soot:set_sprite_directory("/home/we/dust/code/soot/sprites/")
  dusty = Soot:sprite("dusty"):y(0):x(0)
  mycelium = Soot:sprite("mycelium"):y(16):x(0)
  quadrants = Soot:sprite("quadrants"):y(0):x(16)
end

function redraw()
  Soot:redraw()
end

function cleanup()
  Soot:cleanup()
end