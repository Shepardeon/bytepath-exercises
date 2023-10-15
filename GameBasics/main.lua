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
    love.math.setRandomSeed(os.time())
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setLineStyle("rough")
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
    if CurrRoom then CurrRoom:update(dt) end
    GameCamera:update(dt)
    Input:update(dt)
end

function love.draw()
    if CurrRoom then CurrRoom:draw() end
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