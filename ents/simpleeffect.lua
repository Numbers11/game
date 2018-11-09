require("libs.lclass")
class "SimpleEffect"("Entity")

function SimpleEffect:SimpleEffect(animation, posx, posy, duration, flip, scale, rotate)
    Entity.Entity(self, "Simple Effect", posx, posy)

    --    mixin(self, collider3d)
    --    self:c3dInit(posx, posy, 32, 80, 16)

    self.duration = duration
    self.animation = animation
    self.flip = flip or 1
    self.scale = scale or 1
    self.rotate = rotate or 0
    self.timer = 0

    if self.duration == 0 then
        animation.onFinish = function()
            self:kill()
        end
        animation:start(false)
    else
        animation:start()
    end
end

function SimpleEffect:update(dt)
    self.timer = self.timer + dt
    if (self.duration > 0) and (self.timer >= self.duration) then
        self:kill()
        return
    end
    self.animation:update(dt)
end

function SimpleEffect:draw()
    self.animation:draw(self.position.x, self.position.y, self.flip, self.scale, self.rotate)
    if DEBUG then
    --        self:c3dDraw()
    end
end

function SimpleEffect:getType()
    return "SimpleEffect"
end

function SimpleEffect:kill()
    Entity.kill(self)
    --    self:c3dRemove()
end
