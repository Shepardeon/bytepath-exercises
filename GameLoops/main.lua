--require("fixedDelta")
--require("variableDelta")
--require("semiFixedDelta")
require("freePhysic")

local FPS = 0
local FPSCount = 0
local dtAcc = 0
local DT = 0

local Player = {
    x = 0,
    y = 300,
    dir = 1,
}

function love.load()
    --love.window.setMode(800, 600, {vsync = false})
end

function love.update(dt)
    dtAcc = dtAcc + 1 * dt
    FPSCount = FPSCount + 1
    DT = dt
    
    if dtAcc >= 1 then
        FPS = FPSCount
        dtAcc = 0
        FPSCount = 0
    end

    Player.x = Player.x + Player.dir * 500 * dt

    if Player.x > 800 then Player.dir = -1 end
    if Player.x < 0 then Player.dir = 1 end
end

function love.draw()
    love.graphics.print("FPS: "..FPS)
    love.graphics.print("dt: "..DT, 0, 20)
    love.graphics.circle("fill", Player.x, Player.y, 50)
end