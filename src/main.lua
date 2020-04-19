push = require 'push'
Class = require 'class'

require 'Bird'
require 'Pipe'
require 'PipePair'

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
local pipePairs = {}

local spawnTimer = 0
local lastY = -PIPE_HEIGHT + math.random(80)+20

local scrolling = true

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
    if not scrolling then 
        return
    end

    bgScroll = (bgScroll + BG_SCROLL_SPEED * dt) % BG_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VWIDTH

    spawnTimer = spawnTimer + dt

    if spawnTimer > 2 then

        local y = math.max(-PIPE_HEIGHT + 10, math.min(lastY + math.random(-20, 20), VHEIGHT -90 - PIPE_HEIGHT))
        lastY = y

        table.insert(pipePairs, PipePair(y))
        spawnTimer = 0
    end


    bird:update(dt)

    for k, pair in pairs(pipePairs) do
        pair:update(dt)

        for l, pipe in pairs(pair.pipes) do
            if bird:collides(pipe) then
                scrolling = false
            end
        end

        if pair.x < -PIPE_WIDTH then

        end
    end

    for k, pair in pairs(pipePairs) do
        if pair.remove then
            table.remove(pipePairs, k)
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

    for k, pair in pairs(pipePairs) do
        pair:render()
    end

    love.graphics.draw(ground, -groundScroll, VHEIGHT - 16)
    bird:render()



    push:finish()
end