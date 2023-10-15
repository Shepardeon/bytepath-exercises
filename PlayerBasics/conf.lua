Game = {
    w = 480,
    h = 270,
    sX = 1,
    sy = 1,
    defaultColor = { 1, 1, 1, 1 }
}

function love.conf(t)
    t.window.title = "BYTEPATH"
    t.window.width = Game.w
    t.window.height = Game.h
    t.window.msaa = 0
end