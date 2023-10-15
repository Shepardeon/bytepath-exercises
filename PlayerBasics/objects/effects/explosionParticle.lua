ExplosionParticle = GameObject:extend()

function ExplosionParticle:new(area, x, y, opts)
    self.super.new(self, area, x, y, opts)

    self.color = opts.color or Game.defaultColor
    self.ang = Random(0, 2 * math.pi)
    self.size = opts.size or Random(2, 5)
    self.vel = opts.vel or Random(75, 150)
    self.width = 2
    self.timer:tween(opts.delay or Random(0.3, 0.5), self, { size = 0, vel = 0, width = 0 },
        "linear", function() self.dead = true end
    )
end

function ExplosionParticle:update(dt)
    self.super.update(self, dt)
    self.x, self.y = self.x + self.vel * math.cos(self.ang) * dt, self.y + self.vel * math.sin(self.ang) * dt
end

function ExplosionParticle:draw()
    PushRotate(self.x, self.y, self.ang)
    love.graphics.setLineWidth(self.width)
    love.graphics.setColor(self.color)
    love.graphics.line(self.x - self.size, self.y, self.x + self.size, self.y)
    love.graphics.setColor(255, 255, 255)
    love.graphics.setLineWidth(1)
    love.graphics.pop()
end

function ExplosionParticle:destroy()
    self.super.destroy(self)
end