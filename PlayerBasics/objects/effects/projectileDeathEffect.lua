ProjectileDeathEffect = GameObject:extend()

function ProjectileDeathEffect:new(area, x, y, opts)
    self.super.new(self, area, x, y, opts)

    self.color = opts.color or Game.hpColor
    self.currColor = Game.defaultColor
    self.w = opts.w or 8
    self.timer:after(0.1, function()
        self.currColor = self.color
        self.timer:after(0.15, function()
            self.second = false
            self.dead = true
        end)
    end)
end

function ProjectileDeathEffect:update(dt)
    self.super.update(self, dt)
end

function ProjectileDeathEffect:draw()
    love.graphics.setColor(self.currColor)
    love.graphics.rectangle("fill", self.x - self.w/2, self.y - self.w/2, self.w, self.w)
end

function ProjectileDeathEffect:destroy()
    self.super.destroy(self)
end