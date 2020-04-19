Bird = Class{}

local GRAVITY = 4

function Bird:init()
    self.image = love.graphics.newImage('sprites/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VWIDTH / 2 - (self.width / 2)
    self.y = VHEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Bird:collides(pipe)
    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end
    return false
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if love.keyboard.wasPressed('space') then
        count = count + 1
        self.dy = -1
    end

    self.y = self.y + self.dy
end
count = 0
function Bird:render()
    love.graphics.printf(count, 0, 64, VWIDTH, 'center')
    love.graphics.draw(self.image, self.x, self.y)
end