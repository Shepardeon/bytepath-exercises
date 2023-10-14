if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

require("utils")
Object = require("libs/classic")
Input  = require("libs/boypushy")()
Timer  = require("libs/humpTimerExtension")

function love.load()
    local classFiles = {}
    recursiveEnumerate("objects", classFiles)
    requireFiles(classFiles)

    love.math.setRandomSeed(os.time())

    currRoom = nil
    Input:bind("f1", "goto1")
    Input:bind("f2", "goto2")
    Input:bind("f3", "goto3")

    goToRoom("StageRoom")
end

function love.update(dt)
    if currRoom then currRoom:update(dt) end

    if Input:pressed("goto1") then goToRoom("CircleRoom") end
    if Input:pressed("goto2") then goToRoom("RectangleRoom") end
    if Input:pressed("goto3") then goToRoom("PolygonRoom") end
end

function love.draw()
    if currRoom then currRoom:draw() end
end

-- HELPER FUNCTIONS

function goToRoom(room, ...)
    currRoom = _G[room](...)
end

function recursiveEnumerate(folder, fileList)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, item in pairs(items) do
        local file = folder .. "/" .. item
        local fileType = love.filesystem.getInfo(file).type
        if fileType == "file" then
            table.insert(fileList, file)
        elseif fileType == "directory" then
            recursiveEnumerate(file, fileList)
        end
    end
end

function requireFiles(files)
    for _, file in pairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end