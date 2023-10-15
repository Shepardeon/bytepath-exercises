Player = GameObject:extend()

function Player:new(area, x, y, opts)
    Player.super.new(self, area, x, y, opts)

    self.w, self.h = 12, 12
    self.area.world:add(self, self.x, self.y, self.w, self.h)
    self.hasCollider = true

    self.ang = -math.pi/2
    self.angVel = 1.66*math.pi
    self.vel = 0
    self.maxVel = 100
    self.accel = 100
end

function Player:update(dt)
    Player.super.update(self, dt)

    if Input:down("left") then self.ang = self.ang - self.angVel * dt end
    if Input:down("right") then self.ang = self.ang + self.angVel * dt end

    self.vel = math.min(self.vel + self.accel * dt, self.maxVel)
    local goalX, goalY = self.x + self.vel * math.cos(self.ang) * dt, self.y + self.vel * math.sin(self.ang) * dt
    self.x, self.y = self.area.world:move(self, goalX, goalY)
end

function Player:draw()
    love.graphics.circle('line', self.x, self.y, self.w)
    love.graphics.line(self.x, self.y, self.x + 2*self.w*math.cos(self.ang), self.y + 2*self.w*math.sin(self.ang))
end

function Player:destroy()
    self.super.destroy(self)
end