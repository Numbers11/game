require("libs.lclass")

require "fsm.state_machine"

vec = require "libs.hump.vector"

class "Character"("Entity")

function Character:Character(name, posx, posy)
    Entity.Entity(self, name, posx, posy)

    --Adds a collider to our Class
    mixin(self, collider3d)
    self:c3dInit(posx, posy, 32, 80, 16)

    --physics (maybe export to a mixin?)
    self.friction = 0.85
    self.maxvelocity = 999
    self.speed = 500
    self.velocity = vec(0, 0)
    self.scale = 1.5

    --a character faces a direction and has a certain animation sprite
    self.animation = {}
    self.facing = 1 --1 = right, -1 = left
end

function Character:getType()
    return "Character"
end

function Character:update(dt)
    --update our current character sprite (set by the state). maybe this can be changed to be done inside the state, if we want
    --or maybe do it before the state? No? because then we would be playing an animation for 1 frame before we could judge its actually changing again (in onenter)
    self.animation:update(dt)

    --apply friction & gravity (later)
    self.velocity = (self.velocity * self.friction)

    --cutoff value & max value
    self.velocity:trimInplace(self.maxvelocity)
    if self.velocity:len() < 50 then
        --self.velocity = vec(0,0)
        self.velocity.x = 0
        self.velocity.y = 0
    --maybe faster than creating a new table
    end

    local newPos = self:getPos() + self.velocity * dt


    -- update position v--- but only after checking for collisions
    self:setPos(self:c3dMove(self.position.x + self.velocity.x * dt, self.position.y + self.velocity.y * dt))
end

function Character:move(dt)

end

function Character:setVelocity(vel)
    self.velocity = vel
end

function Character:addVelocity(vel)
    --check for max velocity here, to clamp
    self.velocity = self.velocity + vel
end

function Character:getVelocity()
    --check for max velocity here, to clamp
    return self.velocity:clone()
end

function Character:draw()
    --TODO: make these shadows not suck
    love.graphics.setColor(0,0,0,0.4)
    local shadowShear =  -(self.position.x - love.graphics.getWidth() / 2) * (35 * 0.00001)
    love.graphics.draw(self.animation.image, self.animation.currentFrame.quad, self.position.x, self.position.y, -50, 1.5 * self.facing, 1.5, self.animation.currentFrame.axisX, self.animation.currentFrame.axisY, shadowShear * self.facing,0)
    love.graphics.setColor(1,1,1,1)

    --love.graphics.setBlendMode("screen")
    --love.graphics.setColor(0.2, 0.2, 1, 1)
    self.animation:draw(self.position.x, self.position.y, self.facing, self.scale)
    --love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.setBlendMode("alpha")
    --EM:add(AfterImage(player.animation.image, player.animation.currentFrame.quad, player.position.x, player.position.y, 0.4, player.animation.currentFrame.axisX, player.animation.currentFrame.axisY, (player.facing == "right" and true or false), 1.5, nil, nil, {0.4,0.4,1,1}))
    if DEBUG then
        self:c3dDraw()
    end
end

--this here sets the reaction mode to collissions. might need to be placed elsewhere
function Character:collisionFilter(item, other)
    --print(item)
    return "touch"
end

function Character:kill()
    self:c3dRemove() --dont forget to remove the collider!!!
    Entity.kill(self)
end
