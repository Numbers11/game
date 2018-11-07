require("libs.lclass")
class "SimpleSprite"("Entity")

function SimpleSprite:SimpleSprite(image, quad, posx, posy, duration, axisX, axisY, flip, scale, rotate, blendmode, color)
    Entity.Entity(self, "Simple Sprite", posx, posy)
    self.duration = duration
    self.quad = quad
    self.image = image
    self.flip = flip
    self.scale = scale or 1
    self.rotate = rotate or 0
    self.axisX = axisX or 0
    self.axisY = axisY or 0
    self.blendmode = blendmode or "alpha"
    self.scalex = (flip and self.scale or -self.scale)
    self.timer = 0
    self.color = color or {1,1,1,1}
end

function SimpleSprite:update(dt)
    self.timer = self.timer + dt
    if (self.duration > 0) and (self.timer >= self.duration) then
        self:kill()
        return
    end
end

function SimpleSprite:draw()
    --self.animation:draw(self.position.x, self.position.y, self.flip, self.scale, self.rotate)
    local oldBM = { love.graphics.getBlendMode() }
    local oldCL = { love.graphics.getColor() }
    love.graphics.setBlendMode(self.blendmode)
    love.graphics.setColor(unpack(self.color))
    if self.quad == nil then
        love.graphics.draw(self.image, self.position.x, self.position.y, self.rotate, self.scalex, self.scale, self.axisX, self.axisY)
    else
        love.graphics.draw(self.image, self.quad, self.position.x, self.position.y, self.rotate, self.scalex, self.scale, self.axisX, self.axisY)
    end
    love.graphics.setBlendMode(unpack(oldBM))
    love.graphics.setColor(unpack(oldCL))
end

function SimpleSprite:getType()
    return "SimpleSprite"
end