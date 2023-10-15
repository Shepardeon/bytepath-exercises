Stage = Object:extend()

function Stage:new()
    self.area = Area(self)
    self.area:addPhysicsWorld()
    self.mainCanvas = love.graphics.newCanvas(Game.w, Game.h)
    self.player = self.area:addGameObject("Player", Game.w/2, Game.h/2)
end

function Stage:update(dt)
    GameCamera.smoother = Camera.smooth.damped(5)
    GameCamera:lockPosition(dt, Game.w/2, Game.h/2)

    self.area:update(dt)
end

function Stage:draw()
    love.graphics.setCanvas(self.mainCanvas)
    love.graphics.clear()
        GameCamera:attach(0, 0, Game.w, Game.h)
        self.area:draw()
        GameCamera:detach()
    love.graphics.setCanvas()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(self.mainCanvas, 0, 0, 0, Game.sX, Game.sY)
    love.graphics.setBlendMode("alpha")
end

function Stage:destroy()
    self.area:destroy()
    self.area = nil
end