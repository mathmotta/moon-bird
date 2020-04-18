push = require 'push'
Class = require 'class'

require 'Bird'

WWIDTH = 1280
WHEIGHT = 720

VWIDTH = 512
VHEIGHT = 288

local bg = love.graphics.newImage('sprites/background.png')
local bgScroll = 0

local ground = love.graphics.newImage('sprites/ground.png')
local groundScroll = 0

local BG_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BG_LOOPING_POINT = 413

local bird = Bird()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Moon Bird')

    push:setupScreen(VWIDTH,  VHEIGHT, WWIDTH, WHEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    bgScroll = (bgScroll + BG_SCROLL_SPEED * dt) % BG_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VWIDTH

    bird:update(dt)
    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w,h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end 

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()
    push:start()
    love.graphics.draw(bg, -bgScroll, 0)

    love.graphics.draw(ground, -groundScroll, VHEIGHT - 16)
    bird:render()
    push:finish()
end