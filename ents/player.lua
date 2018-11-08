require("libs.lclass")

require "ents.playerstates.playerstates"
require "fsm.state_machine"

vec = require "libs.hump.vector"

class "Player"("Entity")

function Player:Player(name, posx, posy)
    Entity.Entity(self, name, posx, posy)
    self.facing = "right"
    self.control = true
    self.speed = 500
    self.velocity = vec(0, 0)
    self.acceleration = 600
    self.state = nil
    self.sm = FSM()
    self.states = {}
    self.movdelta = vec(0, 0)
    self.animation = {}
    self.friction = 0.85
    self.maxvelocity = 999

    -----------Clone the animations this character uses
    self.anims = {}
    self.anims["walk"] = animations["saberRun"]:clone()
    self.anims["turn"] = animations["saberTurn"]:clone()
    self.anims["attack1"] = animations["saberAttack1"]:clone()
    self.anims["idle"] = animations["saberIdle"]:clone()

    ----------Create the states this character can be in
    self.sm:addState("idle", StateIdle(self))
    self.sm:addState("walk", StateWalk(self))
    self.sm:addState("turn", StateTurn(self))
    self.sm:addState("attack", StateAttack(self))

    ----------
    self.sm:setState("idle")
end

function Player:getType()
    return "Player"
end

function Player:update(dt)
    --Get user input
    self:input()

    --update our state
    self.sm:getState():onUpdate(dt)

    --update our current player sprite (set by the state). maybe this can be changed to be done inside the state, if we want
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

function Player:setVelocity(vel)
    self.velocity = vel
end

function Player:addVelocity(vel)
    --check for max velocity here, to clamp
    self.velocity = self.velocity + vel
end

function Player:input()
    local delta = vec(0, 0)
    if love.keyboard.isDown("left") then
        delta.x = -1
    elseif love.keyboard.isDown("right") then
        delta.x = 1
    end
    if love.keyboard.isDown("up") then
        delta.y = -1
    elseif love.keyboard.isDown("down") then
        delta.y = 1
    end
    delta:normalizeInplace()
    self.movdelta = delta
end

function Player:move()
end

function Player:draw()
    --love.graphics.setBlendMode("screen")
    --love.graphics.setColor(0.2, 0.2, 1, 1)
    self.animation:draw(self.position.x, self.position.y, (self.facing == "right" and true or false), 1.5)
    --love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.setBlendMode("alpha")

    --debug info
    if DEBUG then
        love.graphics.print(trunc(self.movdelta.x, 2) .. ":" .. trunc(self.movdelta.y, 2), 100, 1)
        love.graphics.print(trunc(self.velocity.x, 2) .. ":" .. trunc(self.velocity.y, 2) .. " - " .. trunc(self.velocity:len(), 2), 200, 1)
        love.graphics.print(trunc(self.position.x, 2) .. ":" .. trunc(self.position.y, 2), 600, 1)
    end
end
