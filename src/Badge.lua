Badge = Class{}

local badge1 = love.graphics.newImage('sprites/badge1.png')
local badge2 = love.graphics.newImage('sprites/badge2.png')
local badge3 = love.graphics.newImage('sprites/badge3.png')


function Badge:init(badge)
    if badge == 'bronze' then
        self.image = love.graphics.newImage('sprites/badge1.png')
        self.width = self.image:getWidth()
        self.height = self.image:getHeight()

        self.x = 10
        self.y = 40
    elseif badge == 'silver' then
        self.image = love.graphics.newImage('sprites/badge2.png')
        self.width = self.image:getWidth()
        self.height = self.image:getHeight()

        self.x = 40
        self.y = 40
    elseif badge == 'gold' then
        self.image = love.graphics.newImage('sprites/badge3.png')
        self.width = self.image:getWidth()
        self.height = self.image:getHeight()

        self.x = 70
        self.y = 40
    end
end

function Badge:render()
    love.graphics.draw(self.image, self.x, self.y)
end