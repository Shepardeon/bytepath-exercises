Player = GameObject:extend()

local playerFilter = function()
    return nil
end

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

    self.attackSpeed = 1
    self.timer:every(5, function() self.attackSpeed = Random(1, 4) end)
    self.timer:after(0.24/self.attackSpeed, function(f)
        self:shoot()
        self.timer:after(0.24/self.attackSpeed, f)
    end)
end

function Player:update(dt)
    Player.super.update(self, dt)

    if Input:down("left") then self.ang = self.ang - self.angVel * dt end
    if Input:down("right") then self.ang = self.ang + self.angVel * dt end

    self.vel = math.min(self.vel + self.accel * dt, self.maxVel)
    local goalX, goalY = self.x + self.vel * math.cos(self.ang) * dt, self.y + self.vel * math.sin(self.ang) * dt
    self.x, self.y = self.area.world:move(self, goalX, goalY, playerFilter)
end

function Player:draw()
    love.graphics.circle('line', self.x, self.y, self.w)
    love.graphics.line(self.x, self.y, self.x + 2*self.w*math.cos(self.ang), self.y + 2*self.w*math.sin(self.ang))
end

function Player:destroy()
    self.super.destroy(self)
end

local function spawnProjectile(ply, dist, opts)
    local opts = opts or { }
    opts.ang  = opts.ang or ply.ang
    opts.offX = opts.offX or 0
    opts.offY = opts.offY or 0

    ply.area:addGameObject(
        "Projectile",
        ply.x + opts.offX + dist*math.cos(opts.ang),
        ply.y + opts.offY + dist*math.sin(opts.ang),
        { ang = opts.ang, vel = opts.vel, radius = opts.radius }
    )
end

function Player:shoot()
    local dist = 1.2*self.w
    self.area:addGameObject(
        "ShootEffect", 
        self.x + dist*math.cos(self.ang),
        self.y + dist*math.sin(self.ang),
        { player = self, dist = dist }
    )

    -- Spawns 3 projectiles in a line
    -- spawnProjectile(self, dist, { 
    --     offX = 8 * math.cos(self.ang + math.pi/2),
    --     offY = 8 * math.sin(self.ang + math.pi/2)
    -- })
    -- spawnProjectile(self, dist)
    -- spawnProjectile(self, dist, { 
    --     offX = -8 * math.cos(self.ang + math.pi/2),
    --     offY = -8 * math.sin(self.ang + math.pi/2)
    -- })

    -- Spawns 3 projectiles with an angle of +/-30 deg
    -- spawnProjectile(self, dist, { ang = self.ang + math.pi/6 })
    -- spawnProjectile(self, dist, { ang = self.ang - math.pi/6 })
    -- spawnProjectile(self, dist)

    spawnProjectile(self, dist)
end