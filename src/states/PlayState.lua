
PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

local MIN_INTERVAL = 2
local MAX_INTERVAL = 4
local INTERVAL = 0.1

function PlayState:enter(reset)
    if reset then
        self.bird = Bird()
        self.pipePairs = {}
        self.badges = {}
        self.timer = 0
    
        self.score = 0
    
        self.lastY = -PIPE_HEIGHT + math.random(80) + 20
        hasInit = true 
    end
end

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.badges = {}
    self.timer = 0

    self.score = 0

    self.lastY = -PIPE_HEIGHT + math.random(80) + 20
    hasInit = true
end

function PlayState:update(dt)
    self.timer = self.timer + dt

    if self.timer > INTERVAL then
        local y = math.max(-PIPE_HEIGHT + 10, 
            math.min(self.lastY + math.random(-20, 20), VHEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y

        table.insert(self.pipePairs, PipePair(y))

        self.timer = 0
        INTERVAL = math.random(MIN_INTERVAL,MAX_INTERVAL)
    end

    for k, pair in pairs(self.pipePairs) do

        if not pair.scored then
            if pair.x + PIPE_WIDTH < self.bird.x then
                self.score = self.score +1
                pair.scored = true

                if self.score == 4 then
                    table.insert(self.badges, Badge('bronze'))
                    sounds['badge']:play()
                elseif self.score == 9 then
                    table.insert(self.badges, Badge('silver'))
                    sounds['badge']:play()
                elseif self.score == 16 then
                    table.insert(self.badges, Badge('gold'))
                    sounds['badge']:play()
                end
                sounds['score']:play()
            end
        end 

        pair:update(dt)
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    self.bird:update(dt)

    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                sounds['explosion']:play()
                sounds['death']:play()
                gStateMachine:change('score', {
                    score = self.score
                })
            end
        end
    end

    if self.bird.y > VHEIGHT - 15 then
        sounds['explosion']:play()
        sounds['death']:play()
        gStateMachine:change('score', {
            score = self.score
        })
    end
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    for b, badge in pairs(self.badges) do
        badge:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:render()
end