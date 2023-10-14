RectangleRoom = Object:extend()

function RectangleRoom:new()
    
end

function RectangleRoom:update(dt)

end

function RectangleRoom:draw()
    love.graphics.rectangle("fill", 300, 300 - 25, 200, 50)
end