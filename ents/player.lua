require("libs.lclass")

require "ents.playerstates.playerstates"
require "fsm.state_machine"
require "ents.character"

vec = require "libs.hump.vector"

class "Player"("Character")

function Player:Player(name, posx, posy)
    Character.Character(self, name, posx, posy)

    self.control = true
    self.state = nil
    self.sm = FSM()
    self.states = {}
    self.movdelta = vec(0, 0)

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

    ----------set starting state
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

    Character.update(self, dt)
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

function Player:draw()
    Character.draw(self)

    --[[ 
    --love.graphics.setBlendMode("screen")
    --love.graphics.setColor(0.2, 0.2, 1, 1)
    self.animation:draw(self.position.x, self.position.y, (self.facing == "right" and true or false), 1.5)
    --love.graphics.setColor(1, 1, 1, 1)
    --love.graphics.setBlendMode("alpha")
]]
    --debug info
    if DEBUG then
        love.graphics.print(trunc(self.movdelta.x, 2) .. ":" .. trunc(self.movdelta.y, 2), 100, 1)
        love.graphics.print(trunc(self.velocity.x, 2) .. ":" .. trunc(self.velocity.y, 2) .. " - " .. trunc(self.velocity:len(), 2), 200, 1)
        love.graphics.print(trunc(self.position.x, 2) .. ":" .. trunc(self.position.y, 2) .. " -- " .. self.facing, 600, 1)
    end
end
