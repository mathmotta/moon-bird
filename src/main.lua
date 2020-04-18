push = require 'push'
Class = require 'class'

require 'Bird'
require 'Pipe'

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

local BG_LOOPING_POINT = 415

local bird = Bird()

local pipes = {}

local spawnTimer = 0

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

    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then
        table.insert(pipes, Pipe())
        spawnTimer = 0
    end


    bird:update(dt)

    for k, pipe in pairs(pipes) do
        pipe:update(dt)

        if pipe.x < -pipe.width then
            table.remove(pipes, k)
        end
    end

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

    for k, pipe in pairs(pipes) do
        pipe:render()
    end

    love.graphics.draw(ground, -groundScroll, VHEIGHT - 16)
    bird:render()



    push:finish()
end