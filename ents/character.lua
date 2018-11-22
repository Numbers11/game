require("libs.lclass")

require "fsm.state_machine"

class "Character"("Entity")

function Character:Character(name, posx, posy, posz)
    Entity.Entity(self, name, posx, posy, posz or 0)

    self.scale = 1.5

    --Adds a collider to our Class
    mixin(self, collider3d)
    self:c3dInit(posx, posy, posz, 32, 50, 16)

    --physics (maybe export to a mixin?)
    self.groundFriction = 0.85
    self.airFriction = 1
    self.friction = 0.85
    self.maxvelocity = 999
    self.speed = 500
    self.velocity = vec()
    self.inAir = false

    --a character faces a direction and has a certain animation sprite
    self.animation = {}
    self.facing = 1 --1 = right, -1 = left
    self.gravity = 32
end

function Character:getType()
    return "Character"
end

function Character:update(dt)
    Entity.update(self, dt)
    --update our current character sprite (set by the state). maybe this can be changed to be done inside the state, if we want
    --or maybe do it before the state? No? because then we would be playing an animation for 1 frame before we could judge its actually changing again (in onenter)
    self.animation:update(dt)

    --apply friction
    self.velocity.x = self.velocity.x * self.friction
    self.velocity.y = self.velocity.y * self.friction

    --now gravity
    self.velocity.z = self.velocity.z - self.gravity

    --check if we are on the ground
    if self.position.z + self.velocity.z * dt <= 0 then
        self.velocity.z = 0
        self.position.z = 0
    --print("set inair false")
    end

    --[[   --cutoff value & max value
    v.trim(self.velocity, self.maxvelocity)
    if self.velocity:len() < 25 then
        --self.velocity = vec()
        self.velocity.x = 0
        self.velocity.y = 0
    --maybe faster than creating a new table
    end ]]
    local newPos = self:getPos() + self.velocity * dt

    -- update position v--- but only after checking for collisions
    --self:setPos(self:c3dMove(self.position.x + self.velocity.x * dt, self.position.y + self.velocity.y * dt, self.position.z + self.velocity.z * dt))
    self:setPos(self:c3dMove(v.unpack(newPos)))
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
    return self.velocity:clone()
end

function Character:draw()
    --TODO: make these shadows not suck
    love.graphics.setColor(0, 0, 0, 0.4)
    local shadowShear = -(self.position.x - love.graphics.getWidth() / 2) * (35 * 0.00001)
    love.graphics.draw(
        self.animation.image,
        self.animation.currentFrame.quad,
        self.position.x,
        self.position.y,
        -50,
        1.5 * self.facing,
        1.5,
        self.animation.currentFrame.axisX,
        self.animation.currentFrame.axisY,
        shadowShear * self.facing,
        0
    )
    love.graphics.setColor(1, 1, 1, 1)

    --love.graphics.setBlendMode("screen")
    --love.graphics.setColor(0.2, 0.2, 1, 1)
    self.animation:draw(self.position.x, self.position.y - self.position.z, self.facing, self.scale)
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

--this here sets the reaction mode to collissions. might need to be placed elsewhere
function Character:collisionResolution(col)
    col.other:addVelocity(self:getVelocity():normalize() * 700)
end

function Character:kill()
    self:c3dRemove() --dont forget to remove the collider!!!
    Entity.kill(self)
end
