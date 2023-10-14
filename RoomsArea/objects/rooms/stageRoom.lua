StageRoom = Object:extend()

function StageRoom:new()
    self.area = Area(self)

    self.timer = Timer()
    self.timer:every(2, function()
        self.area:addGameObject("Circle", love.math.random(600) - 1, love.math.random(800) - 1)
    end)
end

function StageRoom:update(dt)
    self.area:update(dt)
    self.timer:update(dt)
end

function StageRoom:draw()
    self.area:draw()
end