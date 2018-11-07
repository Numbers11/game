require("libs.lclass")

vec = require "libs.hump.vector"

class "Entity"

function Entity:Entity(name, posx, posy)
    self.id = 0
    self.name = name or ""
    self.position = vec(posx, posy)
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

function Entity:setPos(posx, posy)
    self.position.x = posx
    self.position.y = posy
end

function Entity:update(dt)
    print("This should be overridden!!")
end

function Entity:draw()
    print("This should be overridden!!")
end

function Entity:kill()
    self._em:remove(self.id) --refactor this to remove the EM global variable and instead make a self.EM field in the EM add funciton
end
