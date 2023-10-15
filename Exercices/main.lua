if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

require("utils")
Object = require("libs.classic")
Input  = require("libs.boypushy")()
Timer  = require("libs.humpTimerExtension")
M = require("libs.moses")

function love.load()
    local classFiles = {}
    RecursiveEnumerate("objects", classFiles)
    RequireFiles(classFiles)
    love.math.setRandomSeed(os.time())

    CurrRoom = nil
end

function love.update(dt)
    if CurrRoom then CurrRoom:update(dt) end
end

function love.draw()
    if CurrRoom then CurrRoom:draw() end
end

-- HELPER FUNCTIONS

function GoToRoom(room, ...)
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