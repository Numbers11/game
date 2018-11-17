require("libs.lclass")

class "Entity"

function Entity:Entity(name, posx, posy, posz)
    self.id = 0
    self.name = name or ""
    self.position = vec(posx, posy, posz)
end

function Entity:getType()
    return "Entity"
end

function Entity:getName()
    return self.name
end

function Entity:setName(name)
    self.name = name
end

function Entity:getPos()
    return self.position:clone()
end

function Entity:setPos(posx, posy, posz)
    self.position.x = posx
    self.position.y = posy
    self.position.z = posz
end

function Entity:update(dt)
    print("This should be overridden!!")
end

function Entity:draw()
    print("This should be overridden!!")
end

function Entity:kill()
    self._em:remove(self.id)
end

function Entity:__tostring()
    return self:getType() .. ":" .. self:getName()
end
