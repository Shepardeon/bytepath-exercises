Circle = GameObject:extend()

function Circle:new(area, x, y, opts)
    self.super:new(area, x, y, opts)
    self.timer:after(love.math.random(5) - 1, function()
        self.dead = true
    end)
end

function Circle:draw()
    love.graphics.circle("fill", self.x, self.y, 25)
end