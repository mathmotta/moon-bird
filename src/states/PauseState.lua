
PauseState = Class{__includes = BaseState}

function PauseState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('PAUSED', 0, 64, VWIDTH, 'center')

    love.graphics.setFont(mediumFont)

    love.graphics.printf('Press P to unpause. ', 0, 160, VWIDTH, 'center')
end