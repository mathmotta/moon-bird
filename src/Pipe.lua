Pipe = Class {}

local PIPE_SPRITE = love.graphics.newImage('sprites/pipe.png')

local PIPE_SCROLL = -60

function Pipe:init()
    self.x = VWIDTH
    self.y = math.random(VHEIGHT / 4, VHEIGHT - 10)

    self.width = PIPE_SPRITE:getWidth()
end

function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end

function Pipe:render()
    love.graphics.draw(PIPE_SPRITE, self.x, self.y)
end