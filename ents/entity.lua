require("libs.lclass")

class "Entity"

function Entity:Entity(name, posx, posy, posz)
    self.id = 0
    self.name = name or ""
    self.position = vec(posx, posy, posz)
    self.following = nil
    self.offset = vec()
    self.destroyed = false
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

function Entity:setFollowing(ent, offsetx, offsety, offsetz)
    if ent == nil then
        self.following = nil
        self.offset = vec()
        return
    end
    self.following = ent
    self.offset = vec(offsetx, offsety, offsetz)
end

function Entity:update(dt)
    if self.following ~= nil then
        self.position = self.following:getPos() + self.offset
    end
end

function Entity:draw()
    print("This should be overridden!!")
end

function Entity:kill()
    self.destroyed = true
    self._em:remove(self.id)
end

function Entity:__tostring()
    return self:getType() .. ":" .. self:getName()
end
