ShootEffect = GameObject:extend()

function ShootEffect:new(area, x, y, opts)
    self.super.new(self, area, x, y, opts)
    self.w = 8
    self.timer:tween(0.1, self, { w = 0 }, 'in-out-cubic', function()
        self.dead = true
    end)
end

function ShootEffect:update(dt)
    if self.player then
        self.x = self.player.x + self.dist * math.cos(self.player.ang)
        self.y = self.player.y + self.dist * math.sin(self.player.ang)
    end
    self.super.update(self, dt)
end

function ShootEffect:draw()
    PushRotate(self.x, self.y, self.player.ang + math.pi/4)
    love.graphics.setColor(Game.defaultColor)
    love.graphics.rectangle("fill", self.x - self.w/2, self.y - self.w/2, self.w, self.w)
    love.graphics.pop()
end

function ShootEffect:destroy()
    self.super.destroy(self)
end