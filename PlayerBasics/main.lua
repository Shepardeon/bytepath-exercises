function GCDump() print("Run in debug to get GC infos") end

if arg[#arg] == "vsc_debug" then 
    require("lldebugger").start() 
    require("gc")
end

require("utils")
Physics = require("libs.bump")
Object  = require("libs.classic")
Input   = require("libs.boypushy")()
Timer   = require("libs.humpTimerExtension")
Camera  = require("libs.hump.camera")
M = require("libs.moses")

function love.load()
    local classFiles = {}
    RecursiveEnumerate("objects", classFiles)
    RequireFiles(classFiles)
    
    GameCamera = Camera()
    Game.globalTimer = Timer()
    love.math.setRandomSeed(os.time())
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setLineStyle("rough")
    love.graphics.setBackgroundColor(Game.backgroundColor)
    Resize(3)

    -- GC infos
    Input:bind("f1", GCDump)
    Input:bind("f2", function() GoToRoom('Stage') end)
    Input:bind("f3", function() 
        if CurrRoom then
            CurrRoom:destroy()
            CurrRoom = nil
        end
    end)
    -- end GC infos

    Input:bind("q", "left")
    Input:bind("d", "right")
    
    CurrRoom = nil
    GoToRoom("Stage")
end

function love.update(dt)
    Game.globalTimer:update(dt*Game.timeScale)
    GameCamera:update(dt*Game.timeScale)
    if CurrRoom then CurrRoom:update(dt*Game.timeScale) end
    Input:update(dt)

    if Game.flashFrames then
        Game.flashFrames = Game.flashFrames - 1
        if Game.flashFrames < 0 then Game.flashFrames = nil end
    end
end

function love.draw()
    if CurrRoom then CurrRoom:draw() end

    if Game.flashFrames then
        love.graphics.setColor(Game.backgroundColor)
        love.graphics.rectangle('fill', 0, 0, Game.sX*Game.w, Game.sY*Game.h)
        love.graphics.setColor(1, 1, 1)
    end
end

-- HELPER FUNCTIONS

function GoToRoom(room, ...)
    if CurrRoom and CurrRoom.destroy then CurrRoom:destroy() end
    CurrRoom = _G[room](...)
end

function RecursiveEnumerate(folder, fileList)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in pairs(items) do
        local file = folder .. "/" .. item
        local fileType = love.filesystem.getInfo(file).type
        if fileType == "file" then
            table.insert(fileList, file)
        elseif fileType == "directory" then
            RecursiveEnumerate(file, fileList)
        end
    end
end

function RequireFiles(files)
    for _, file in pairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end