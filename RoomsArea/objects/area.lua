Area = Object:extend()

function Area:new(room)
    self.room = room
    self.gameObjects = {}
end

function Area:update(dt)
    for i = #self.gameObjects, 1, -1 do
        local go = self.gameObjects[i]
        go:update(dt)
        if go.dead then table.remove(self.gameObjects, i) end
    end
end

function Area:draw()
    for _, go in ipairs(self.gameObjects) do go:draw() end
end

function Area:addGameObject(gameObject, x, y, opts)
    local opts = opts or {}
    local go = _G[gameObject](self, x or 0, y or 0, opts)
    table.insert(self.gameObjects, go)
    return go
end