Pipe = Class {}

local PIPE_SPRITE = love.graphics.newImage('sprites/pipe.png')

PIPE_SPEED = 60

PIPE_HEIGHT = 288
PIPE_WIDTH = 70

function Pipe:init(orientation, y)
    self.x = VWIDTH
    self.y = y

    self.width = PIPE_SPRITE:getWidth()
    self.height = PIPE_HEIGHT

    self.orientation = orientation
end

function Pipe:update(dt)
end

function Pipe:render()
    love.graphics.draw(PIPE_SPRITE, self.x, 
    (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y),
    0,1, self.orientation == 'top' and -1 or 1)
end