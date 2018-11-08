require("libs.lclass")
class "EntityManager"

function EntityManager:EntityManager()
    self.entities = {}
    self._i = 1
    self.count = 0

    self.drawobj = {}
end

function EntityManager:add(entity)
    self.entities[self._i] = entity
    entity.id = self._i
    entity._em = self

    self._i = self._i + 1
    self.count = self.count + 1
    return entity
end

function EntityManager:remove(entID)
    self.entities[entID] = nil
    self.count = self.count - 1
end

local function sortByY(o1, o2)
    return o1.position.y < o2.position.y --<
end

function EntityManager:update(dt)
    for _, e in pairs(self.entities) do
        e:update(dt)
    end

    self.drawobj = {}
    for _, v in pairs(self.entities) do
        table.insert(self.drawobj, v)
    end
    table.sort(self.drawobj, sortByY)
end

function EntityManager:draw()
    --we need Y ordering and z ordering here
    for _, e in ipairs(self.drawobj) do
        e:draw()
        if DEBUG then
            local oldColor = {love.graphics.getColor()}
            love.graphics.setColor(1, 0, 0)
            love.graphics.circle("fill", e.position.x, e.position.y, 5)
            love.graphics.setColor(unpack(oldColor))
        end
    end
    --for _, e in pairs(self.entities) do
    --    e:draw()
    --end
    --draw some debug info maybe?
end

return EntityManager()
