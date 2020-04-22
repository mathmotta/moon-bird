push = require 'push'
Class = require 'class'

require 'Bird'
require 'Pipe'
require 'PipePair'
require 'Badge'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/CountdownState'
require 'states/PauseState'
require 'states/TitleScreenState'

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
local GROUND_LOOPING_POINT = 514

local scrolling = true

local playState = PlayState()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Moon Bird')

    smallFont = love.graphics.newFont('fonts/font.ttf', 8)
    mediumFont = love.graphics.newFont('fonts/flappy.ttf', 14)
    flappyFont = love.graphics.newFont('fonts/flappy.ttf', 28)
    hugeFont = love.graphics.newFont('fonts/flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    sounds = {
        ['jump'] = love.audio.newSource('sfx/jump.wav', 'static'),
        ['badge'] = love.audio.newSource('sfx/badge.wav', 'static'),
        ['explosion'] = love.audio.newSource('sfx/explosion.wav', 'static'),
        ['death'] = love.audio.newSource('sfx/death.wav', 'static'),
        ['score'] = love.audio.newSource('sfx/score.wav', 'static'),
    }

    push:setupScreen(VWIDTH,  VHEIGHT, WWIDTH, WHEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['pause'] = function() return PauseState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return playState end,
        ['score'] = function() return ScoreState() end,
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    if love.keyboard.wasPressed('p') then
        if scrolling then
            scrolling = false
            gStateMachine:change('pause')
        end
    end

    if love.keyboard.wasPressed('s') then
        if not scrolling then
            scrolling = true
            gStateMachine:change('play')
        end
    end

    if not scrolling then 
        gStateMachine:update(dt)
        return
    end

    bgScroll = (bgScroll + BG_SCROLL_SPEED * dt) % BG_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VWIDTH

    gStateMachine:update(dt)

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
    gStateMachine:render()

    love.graphics.draw(ground, -groundScroll, VHEIGHT - 16)

    push:finish()
end