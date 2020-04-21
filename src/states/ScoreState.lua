
ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('LOSE', 0, 64, VWIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VWIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VWIDTH, 'center')
end