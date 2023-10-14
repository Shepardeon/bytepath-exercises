Circle = Object:extend()

function Circle:new(x, y, radius)
    self.x = x
    self.y = y
    self.radius = radius
    self.creationTime = love.timer.getTime()
end

function Circle:update(dt)

end

function Circle:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius)
end