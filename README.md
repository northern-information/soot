# Soot

*"The soot sprites are hard at work..."*

Soot is a [sprite](https://en.wikipedia.org/wiki/Sprite_(computer_graphics)) and graphics library for [norns](https://monome.org).

Soot makes animating and positioning your illustrated collection of .pngs easy. It can be used for UI elements, characters, symbols, and animations.

Soot is only a demo. It is neither production ready nor feature complete.

## Requirements

Soot *should* work on all versions of norns. It was developed on `221214`.

## Usage

1. Create your sprites and save them to sequentially numbered `*.png` files. Each should be grayscale, have no transparency, and share the exact same dimensions. I've been using [Sprite Creator](https://apps.apple.com/us/app/sprite-creator/id1078225966) for iOS and Illustrator/Photoshop.
2. Install Soot.
3. Define your sprites somewhere during script startup.
4. Interact with the various methods from anywhere in your script.

## Install

Save `Soot.lua` & `Sprite.lua` as siblings in your project and include them (Soot `includes` Sprite for you):

```lua
Soot = include "lib/Soot"
```

Initialize Soot with the path of your sprite's absolute directory:

```lua
Soot.init("/home/we/dust/code/my_script/sprites/")
```

Within this directory, create a sub-directory for each sprite. "Simple sprites" can have any number of grayscale `*.pngs`. Start numbering at `0`. "Toggle sprites" need two images: `0.png` (off) and `1.png` (on). "Cardinal sprites" need four sub-directories - one for each cardinal direction. These directories can have any number of `*.pngs` inside.

```
home/we/dust/code/
  |
  |-my_script/
    |
    |-sprites/
      |
      |-arrow_east/
      | |-0.png
      | |-1.png
      |
      |-arrow_north/
      | |-0.png
      | |-1.png
      |
      |-arrow_south/
      | |-0.png
      | |-1.png
      |
      |-arrow_west/
      | |-0.png
      | |-1.png
      |
      |-cci/
      | |-e/
      | | |-0.png
      | | |-1.png
      | | |-2.png
      | | |-3.png
      | | |-4.png
      | |
      | |-n/
      | | |-0.png
      | | |-1.png
      | | |-2.png
      | | |-3.png
      | | |-4.png
      | |
      | |-s/
      | | |-0.png
      | | |-1.png
      | | |-2.png
      | | |-3.png
      | | |-4.png
      | |
      | |-w/
      |   |-0.png
      |   |-1.png
      |   |-2.png
      |   |-3.png
      |   |-4.png
      |
      |-dusty/
        |-0.png
        |-1.png          
        |-2.png          
        |-3.png          
        |-4.png          
        |-5.png          
        |-6.png          
        |-7.png          
        |-8.png          
```       

Soot has it's own clock which calls `redraw()` at the specified FPS for you:

```lua
function redraw()
  screen.clear()
  Soot:redraw()
  screen.level(15)
  screen.move(10, 10)
  screen.text("all the usual screen stuff works as normal")
  -- Soot:text(10, 10, "the northern information graphics library is in here, too!", 15)
  screan.update()
end
```

Be sure to make this call in the standard `cleanup()` function:

```lua
function cleanup()
  Soot:cleanup()
end
```

## Define

Soot sprite definitions look something like this:

```lua
Soot:name_sprite("dusty")
  :x(0)
  :y(0)
  :width(16)
  :height(16)
  :start()
```

This type of syntax is known as "method chaining." Each method returns `self` so you can mix and match them in any order. So the below is functionally identicle to the above:

```lua
Soot:name_sprite("dusty")
  :start()
  :width(16)
  :height(16)
  :x(0)
  :y(0)
```

Define them however is most comfortable for you!

## Interact

Once defined, used the various Sprite getters and setters to manipulate the graphics.

All sprites implement the following APIs:

```lua
local dusty = Soot:get("dusty") -- get a sprite by name

dusty:show() -- immediately show the sprite
dusty:hide() -- immediately hide the sprite
dusty:x(20) -- set dusty's x coords to 20
dusty:y(30) -- set dusty's y coords to 30
dusty:width(16) -- set dusty's width
dusty:height(16) -- set dusty's height
dusty:speed(.5) -- only tested with slower & clean divisions
dusty:blend_mode("add") -- abstraction for screen.blend_mode("add")

-- use the following boolean getters for control flow:
dusty:is_visible()
dusty:is_moving()
dusty:is_simple()
dusty:is_toggle()
dusty:is_cardinal()
dusty:is_on()

-- other handy getters:
dusty:get_directory()
dusty:get_x()
dusty:get_y()
dusty:get_blend_mode()
dusty:get_speed()
```

Only toggle sprites can use `turn_on` & `turn_off`:

```lua
arrow_up:turn_on()
arrow_up:turn_off()
```

Simple & cardinal sprites can use `start` & `stop`:

```lua
dusty:start() -- start the animation
dusty:stop() -- stop the animation
```

Only cardinal sprites have a `heading`. This refers to which cardinal direction the sprite is oriented. Only north, east, south, and west are supported.

```lua
cci:heading("n")
```

## Meta

Soot is the successor to the Northern Information Graphics Library. It was developed for [Coral Carrier Incarnadine](https://cci.dev).

Special thanks to [@ryleelyman](https://github.com/ryleelyman)!