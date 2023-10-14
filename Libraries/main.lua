if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

Object = require("libs/classic")
Input  = require("libs/boypushy")()

local circle

function love.load()
    local objectFiles = {}
    recursiveEnumerate("objects", objectFiles)
    requireFiles(objectFiles)

    circle = Circle(400, 300, 50)
    hCircle = HyperCircle(400, 300, 50, 10, 120)
    --Input:bind('mouse1', function() print(love.math.random()) end)
    
    Input:bind("a", "test")
    Input:bind("d", "right")
    Input:bind("kp+", "sum")
    sum = 0

    -- Exemple avec un joystick

    -- Les boutons A,B,X,Y
    Input:bind('fleft', 'left')
    Input:bind('fright', 'right')
    Input:bind('fup', 'up')
    Input:bind('fdown', 'down')

    -- Les trigger et joysticks
    Input:bind('l2', 'trigger')
    Input:bind('leftx', 'left_horizontal')
    Input:bind('lefty', 'left_vertical')
    Input:bind('rightx', 'right_horizontal')
    Input:bind('righty', 'right_vertical')
end

function love.update(dt)
    hCircle:update(dt)

    if Input:pressed("test") then print("pressed") end
    if Input:released("test") then print("released") end
    if Input:down("test", 0.5) then print("down") end

    if Input:sequence("right", 0.5, "right") then
        print("dash!")
    end

    if Input:down("sum", 0.25) then
        sum = sum + 1
        print(sum)
    end

    if Input:pressed('left') then print('left') end
    if Input:pressed('right') then print('right') end
    if Input:pressed('up') then print('up') end
    if Input:pressed('down') then print('down') end

    local left_trigger_value = Input:down('trigger')
    --print(left_trigger_value)

    local left_stick_horizontal = Input:down('left_horizontal')
    local left_stick_vertical = Input:down('left_vertical')
    local right_stick_horizontal = Input:down('right_horizontal')
    local right_stick_vertical = Input:down('right_vertical')
    --print(left_stick_horizontal, left_stick_vertical)
    --print(right_stick_horizontal, right_stick_vertical)

    Input:update()
end

function love.draw()
    hCircle:draw()
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

function ex10()
    return {
        a = 1, b = 2, c = 3,
        sum = function(self)
            self.c = self.a + self.b + self.c
        end
    }
end

-- local t = ex10()
-- t:sum()
-- print(t.c)