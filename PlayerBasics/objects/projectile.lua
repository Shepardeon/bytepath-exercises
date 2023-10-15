Projectile = GameObject:extend()

local projectileFilter = function()
    return nil
end

function Projectile:new(area, x, y, opts)
    self.super.new(self, area, x, y, opts)

    self.radius = opts.radius or 2.5
    self.vel = opts.vel or 200

    self.area.world:add(self, self.x, self.y, self.radius, self.radius)
    self.hasCollider = true
end

function Projectile:update(dt)
    self.super.update(self, dt)
    local goalX, goalY = self.x + self.vel * math.cos(self.ang) * dt, self.y + self.vel * math.sin(self.ang) * dt
    self.x, self.y = self.area.world:move(self, goalX, goalY, projectileFilter)
end

function Projectile:draw()
    love.graphics.setColor(Game.defaultColor)
    love.graphics.circle("line", self.x, self.y, self.radius)
end

function Projectile:destroy()
    self.super.destroy(self)
end