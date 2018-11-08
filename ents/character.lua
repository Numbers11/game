require("libs.lclass")

require "fsm.state_machine"

vec = require "libs.hump.vector"

class "Character"("Entity")

function Character:Character(name, posx, posy)
    Entity.Entity(self, name, posx, posy)
    self.animation = {}
    self.facing = "right"

    --physics (maybe export to a mixin?)
    self.friction = 0.85
    self.maxvelocity = 999
    self.speed = 500
    self.velocity = vec(0, 0)
    self.scale = 1.5
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

    -- update position
    self.position = self.position + self.velocity * dt
end

function Character:setVelocity(vel)
    self.velocity = vel
end

function Character:addVelocity(vel)
    --check for max velocity here, to clamp
    self.velocity = self.velocity + vel
end

function Character:draw()
    --love.graphics.setBlendMode("screen")
    --love.graphics.setColor(0.2, 0.2, 1, 1)
    self.animation:draw(self.position.x, self.position.y, (self.facing == "right" and true or false), self.scale)
    --love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.setBlendMode("alpha")
end
