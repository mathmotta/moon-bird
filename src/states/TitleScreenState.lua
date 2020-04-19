TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Fifty Bird', 0, 64, VWIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 100, VWIDTH, 'center')
end