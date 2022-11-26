# Soot

*"The soot sprites are hard at work..."*

Soot is a [sprite](https://en.wikipedia.org/wiki/Sprite_(computer_graphics)) and graphics library for [norns](https://monome.org).

Soot makes animating and positioning your illustrated collection of .pngs easy.

Soot is only a demo. It is neither production ready nor feature complete.

## Requirements

Whichever version of norns has [lattice 2.0](https://github.com/monome/norns/pull/1616) (as of November 2022, it hasn't been released yet.) 

Alternatively, you can replace your local copy at `/home/we/norns/lua/lib/lattice.lua` with this file: [https://raw.githubusercontent.com/ryleelyman/norns/15b814aeb42ae1f3bf31e19ebe01f28945c7a8c8/lua/lib/lattice.lua](https://raw.githubusercontent.com/ryleelyman/norns/15b814aeb42ae1f3bf31e19ebe01f28945c7a8c8/lua/lib/lattice.lua)

## Setup & Teardown

Save `Soot.lua` somewhere in your project and include it:

```lua
Soot = include "lib/Soot"
```

Soot runs on an abstracted [lattice 2.0](https://monome.org/docs/norns/reference/lib/lattice), so fire up the boilerworks and set your sprite's absolute directory with:

```lua
Soot:init()
Soot:set_sprite_directory("/home/we/dust/code/yourscript/sprites/")
```

This will wake up Kamaji and the the celestial machinery needed to keep all the soot sprites in order.

Let Soot take care of the redrawing:

```lua
function redraw()
  Soot:redraw()
end
```

And once the day's work is done, be sure to make this call in your usual `cleanup()` function:

```lua
function cleanup()
  Soot:cleanup()
end
```

## Usage


## Meta

Soot is the successor to the Northern Information Graphics Library. It was developed for [Coral Carrier Incarnadine](https://cci.dev).

Special thanks to [@ryleelyman](https://github.com/ryleelyman)!