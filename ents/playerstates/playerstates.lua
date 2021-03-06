require "fsm.state"
require "fsm.state_machine"

class "StateIdle"("State")

function StateIdle:StateIdle(entity)
    State.State(self, entity)
end

function StateIdle:onEnter(from)
    local player = self.ent
    print("| " .. player.name .. ": state idle entered from " .. from)
    player.animation = self.ent.anims["idle"]
    player.animation:start()
end

function StateIdle:onUpdate(dt)
    local player = self.ent
    --check key presses and transform accordingly

    if love.keyboard.isDown("f") then   --attack
        self.fsm:setState("attack")
    elseif love.keyboard.isDown("space") then -- jump
        self.fsm:setState("jump")
    elseif player.movdelta.x ~= 0 or player.movdelta.y ~= 0 then --move
        self.fsm:setState("walk")
    end
end

function StateIdle:onLeave()
    local player = self.ent
    print("| " .. player.name .. ": state idle left")
end

----------

class "StateWalk"("State")

function StateWalk:StateWalk(entity)
    State.State(self, entity)
    self.timer = 0
end

local function turnCheck(player)
    return (player.movdelta.x < 0 and player.facing == 1) or (player.movdelta.x > 0 and player.facing == -1)
end

function StateWalk:onEnter(from)
    local player = self.ent
    print("| " .. player.name .. ": state walk entered from " .. from)

    --check if we need to turn it around
    if turnCheck(player) then
        self.fsm:setState("turn")
        return
    end

    player.animation = player.anims["walk"]
    player.animation:start()

    --create run start dust particle effect
    fx("fxRun", player.position.x, player.position.y, 0, -player.facing)
    --create after image effect
    self._th =
        timer.every(
        0.1,
        function()
            --pic(image, quad, posx, posy, duration, axisX, axisY, flip, scale, rotate, blendmode)
            EM:add(
                AfterImage(
                    player.animation.image,
                    player.animation.currentFrame.quad,
                    player.position.x,
                    player.position.y,
                    0.4,
                    player.animation.currentFrame.axisX,
                    player.animation.currentFrame.axisY,
                    player.facing,
                    1.5,
                    nil,
                    nil,
                    {0.4, 0.4, 1, 1}
                )
            )
        end
    )
end

function StateWalk:onUpdate(dt)
    self.timer = self.timer + dt
    local player = self.ent

    --check if we need to turn it around
    if turnCheck(player) then
        self.fsm:setState("turn")
        return
    end

    --attack out of walk, its fine
    if love.keyboard.isDown("f") then
        self.fsm:setState("attack")
        return
    elseif love.keyboard.isDown("space") then -- jump
        self.fsm:setState("jump")
        return
    end

    --no state change
    --smaller dust fx run
    if self.timer > 0.18 then
        fx("fxRun", player.position.x, player.position.y, 0, -player.facing, 0.4)
        self.timer = 0
    end

    --no longer moving, going back to idle
    if player.movdelta.x == 0 and player.movdelta.y == 0 then
        print("nomovetest")
        self.fsm:setState("idle")
        return
    end

    --still pressed, so we move
    player:setVelocity(player.movdelta * player.speed) --*dt  -- player.velocity +
end

function StateWalk:onLeave()
    local player = self.ent
    print("| " .. player.name .. ": state walk left")
    if self._th then
        timer.cancel(self._th)
    end
    self.timer = 0
end

----------

class "StateTurn"("State")

function StateTurn:StateTurn(entity)
    State.State(self, entity)
end

function StateTurn:onEnter(from)
    local player = self.ent
    print("| " .. player.name .. ": state turn entered from" .. from)
    self.ent.animation = self.ent.anims["turn"]
    self.ent.animation.onFinish = function()
        self:onAnimationFinished()
    end
    self.ent.animation:start(false)
end

function StateTurn:onUpdate(dt)
    --do nothing lol
end

function StateTurn:onLeave()
    local player = self.ent
    print("| " .. player.name .. ": state turn left")
end

function StateTurn:onAnimationFinished()
    local player = self.ent
    player.facing = player.facing * -1 --now that we are done turning, actually flip the character
    player.animation.onFinish = nil
    self.fsm:setState("idle")
end

----------

class "StateAttack"("State")

function StateAttack:StateAttack(entity)
    State.State(self, entity)
end

function StateAttack:onEnter(from)
    local player = self.ent
    print("state attack entered from " .. from)
    player.animation = player.anims["attack1"]
    player.animation:start(false)
    player.animation.onFinish = function()
        self:onAnimationFinished()
    end
    timer.after(
        7 / 60,
        function()
            fx("fxSlash1", player.position.x + 15 * player.facing, player.position.y - 30, 0, -player.facing, 0.6, math.rad(40 * -player.facing))
        end
    )

    player:addVelocity(vec(player.facing * 600, 0, 0))
end

function StateAttack:onUpdate(dt)
    local player = self.ent
    --this here could be a reason to put the animation update in the state! if we update afterwards, we might be one frame late with the hitbox check (for example
    -- or do we even want to check for hitboxes here?
    -- could be good to also do invincible stuff or smth
end

function StateAttack:onLeave()
    print("state attack left")
end

function StateAttack:onAnimationFinished()
    local player = self.ent
    player.animation.onFinish = nil
    self.fsm:setState("idle")
end


----------

class "StateJumpStart"("State")

function StateJumpStart:StateJumpStart(entity)
    State.State(self, entity)
end

function StateJumpStart:onEnter(from)
    local player = self.ent
    print("| " .. player.name .. ": state jump entered from " .. from)
    player.animation = player.anims["jumpStart"]
    player.animation:start(false)
    player.animation.onFinish = function()
        self:onAnimationFinished()
    end
    player.inAir = true
    player.friction = player.airFriction
end

function StateJumpStart:onUpdate(dt)
    print(self.ent.velocity)
    --self.timer = self.timer + dt
    --local player = self.ent
    --if player.position.z <= 0 then
    --    self.fsm:setState("idle")
    --end
    -- react to other inputs here i guess whatever dunno
end

function StateJumpStart:onLeave()
    local player = self.ent
    print("| " .. player.name .. ": state jump left")
    player.velocity.z = 900
end

function StateJumpStart:onAnimationFinished()
    local player = self.ent
    player.animation.onFinish = nil
    self.fsm:setState("jumpAscending")
end

----------

class "StateJumpAscending"("State")

function StateJumpAscending:StateJumpAscending(entity)
    State.State(self, entity)
end

function StateJumpAscending:onEnter(from)
    local player = self.ent
    print("| " .. player.name .. ": state jumpAscending entered from " .. from)
    player.animation = player.anims["jumpAscending"]
    player.animation:start(false)
end

function StateJumpAscending:onUpdate(dt)
    --self.timer = self.timer + dt
    local player = self.ent
    if player.position.z <= 0 then
        self.fsm:setState("jumpLanding")
    end
    --attack out of air (guess thats a specific state too)

    --air jump / double jump

    --move in air (probably no other state)
    -- react to other inputs here i guess whatever dunno
end

function StateJumpAscending:onLeave()
    local player = self.ent
    print("| " .. player.name .. ": state jumpAscending left")
    fx("fxLand", player.position.x, player.position.y, 0)
    player.friction = player.groundFriction
end

----------

class "StateJumpLanding"("State")

function StateJumpLanding:StateJumpLanding(entity)
    State.State(self, entity)
end

function StateJumpLanding:onEnter(from)
    local player = self.ent
    print("| " .. player.name .. ": state jumpLanding entered from " .. from)
    player.animation = player.anims["jumpLanding"]
    player.animation:start(false)
    player.animation.onFinish = function()
        self:onAnimationFinished()
    end
end

function StateJumpLanding:onUpdate(dt)
end

function StateJumpLanding:onLeave()
    local player = self.ent
    print("| " .. player.name .. ": state jumpLanding left")
    player.friction = player.groundFriction
    --fx("fxLand", player.position.x, player.position.y, 0)
end

function StateJumpLanding:onAnimationFinished()
    local player = self.ent
    player.animation.onFinish = nil
    self.fsm:setState("idle")
end

----------