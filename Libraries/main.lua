if arg[#arg] == "vsc_debug" then require("lldebugger").start() end

Object = require("libs/classic")
Input  = require("libs/boypushy")()
Timer  = require("libs/humpTimerExtension")
M = require("libs/moses")

local circle

function love.load()
    local objectFiles = {}
    recursiveEnumerate("objects", objectFiles)
    requireFiles(objectFiles)

    -- circle = Circle(400, 300, 50)
    -- hCircle = HyperCircle(400, 300, 50, 10, 120)
    -- --Input:bind('mouse1', function() print(love.math.random()) end)
    
    -- Input:bind("a", "test")
    -- Input:bind("d", "right")
    -- Input:bind("kp+", "sum")
    -- sum = 0

    -- -- Exemple avec un joystick

    -- -- Les boutons A,B,X,Y
    -- Input:bind('fleft', 'left')
    -- Input:bind('fright', 'right')
    -- Input:bind('fup', 'up')
    -- Input:bind('fdown', 'down')

    -- -- Les trigger et joysticks
    -- Input:bind('l2', 'trigger')
    -- Input:bind('leftx', 'left_horizontal')
    -- Input:bind('lefty', 'left_vertical')
    -- Input:bind('rightx', 'right_horizontal')
    -- Input:bind('righty', 'right_vertical')

    timer = Timer()
    -- -- timer:after(2, function() 
    -- --     print('Timer end')
    -- --     timer:after(1, function()
    -- --         print('One more second')
    -- --         timer:after(1, function()
    -- --             print("K BOOM")
    -- --         end)
    -- --     end)
    -- -- end)
    -- --
    -- -- équivalant à :
    -- -- timer:script(function(wait) 
    -- --     wait(2)
    -- --     print('Timer end')
    -- --     wait(1)
    -- --     print('One more second')
    -- --     wait(1)
    -- --     print("K BOOM")
    -- -- end)

    -- circle = { x = 400, y = 300, radius = 24 }
    -- timer:after(2, function()
    --     timer:tween(6, circle, { radius = 150 }, "in-out-cubic", function()
    --         timer:tween(6, circle, { radius = 24})
    --     end)
    -- end)

    -- for i = 1, 10 do
    --     timer:after(0.5*i, function()
    --         print(love.math.random())
    --     end)
    -- end

    -- rect_1 = {x = 400, y = 300, w = 50, h = 200}
    -- rect_2 = {x = 400, y = 300, w = 200, h = 50}

    -- timer:tween(1, rect_1, { w = 0 }, 'in-out-cubic', function()
    --     timer:tween(1, rect_2, { h = 0 }, 'in-out-cubic', function()
    --         timer:tween(1, rect_1, { w = 50 }, 'in-out-cubic')
    --         timer:tween(1, rect_2, { h = 50 }, 'in-out-cubic')
    --     end)
    -- end)

    rect_1 = {x = 300, y = 300, w = 200, h = 50}
    rect_2 = {x = 300, y = 300, w = 200, h = 50}
    Input:bind("d", "hurt")

    a = {1, 2, '3', 4, '5', 6, 7, true, 9, 10, 11, a = 1, b = 2, c = 3, {1, 2, 3}}
    b = {1, 1, 3, 4, 5, 6, 7, false}
    c = {'1', '2', '3', 4, 5, 6}
    d = {1, 4, 3, 4, 5, 6}

    M.each(a, print)
    print(M.count(b, 1))
    M.each(M.map(d, function(v) return v+1 end), print)

    a = M.map(a, function(v)
        if type(v) == "number" then return v*2
        elseif type(v) == "string" then return v.."xD"
        elseif type(v) == "boolean" then return not v
        else return v end
    end)

    M.each(a, print)

    print(M.sum(d))

    if M.include(b, 9) then
        print('table contains the value 9')
    end
end

function love.update(dt)
    -- hCircle:update(dt)

    -- if Input:pressed("test") then print("pressed") end
    -- if Input:released("test") then print("released") end
    -- if Input:down("test", 0.5) then print("down") end

    -- if Input:sequence("right", 0.5, "right") then
    --     print("dash!")
    -- end

    -- if Input:down("sum", 0.25) then
    --     sum = sum + 1
    --     print(sum)
    -- end

    -- if Input:pressed('left') then print('left') end
    -- if Input:pressed('right') then print('right') end
    -- if Input:pressed('up') then print('up') end
    -- if Input:pressed('down') then print('down') end

    -- local left_trigger_value = Input:down('trigger')
    -- --print(left_trigger_value)

    -- local left_stick_horizontal = Input:down('left_horizontal')
    -- local left_stick_vertical = Input:down('left_vertical')
    -- local right_stick_horizontal = Input:down('right_horizontal')
    -- local right_stick_vertical = Input:down('right_vertical')
    -- --print(left_stick_horizontal, left_stick_vertical)
    -- --print(right_stick_horizontal, right_stick_vertical)

    if Input:pressed("hurt") then
        timer:tween("t_hurt1", 0.25, rect_2, { w = math.max(rect_2.w - 25, 0) })
        timer:tween("t_hurt2", 1, rect_1, { w = math.max(rect_2.w - 25, 0) })
    end

    Input:update()
    timer:update(dt)
end

function love.draw()
    --hCircle:draw()
    --love.graphics.circle("fill", circle.x, circle.y, circle.radius)
    love.graphics.setColor(0.96, 0.73, 0.29)
    love.graphics.rectangle('fill', rect_1.x, rect_1.y - rect_1.h/2, rect_1.w, rect_1.h)
    love.graphics.setColor(0.96, 0.29, 0.29)
    love.graphics.rectangle('fill', rect_2.x, rect_2.y - rect_2.h/2, rect_2.w, rect_2.h)
    love.graphics.setColor(1, 1, 1)
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