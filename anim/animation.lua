require("libs.lclass")

class "Animation"

--Missing: Clone & Flip
function Animation:Animation(name, image, frameW, frameH, blendmode, default)
    --print("ANIM INIT - " .. name, image, frameW, frameH, blendmode, default)
    self.name = name or ""
    self.image = image or nil
    self.frames = {}
    self.frameCount = 0
    self.flipped = false --currently unused, flip is provided to draw function

    self.frameW = frameW
    self.frameH = frameH

    self.currentFrame = nil
    self.currentFrameNumber = 1
    self.currentFrameTime = 0

    self.running = false
    self.loop = true

    self.blendmode = blendmode or nil

    self.default =
        default or
        {
            x = 0,
            y = 0,
            axisX = 0,
            axisY = 0
        }
end

function Animation:loadFrameData(framedata)
    -- table of frames with duration and index
    for _, data in ipairs(framedata) do
        --print(i, data)
        self:createNewFrame(
            data.duration or self.default.duration,
            self.frameW,
            self.frameH,
            data.x or self.default.x,
            data.y or self.default.y,
            data.axisX or self.default.axisX,
            data.axisY or self.default.axisY
        )
    end
    self.frameCount = #self.frames
end

function Animation:createNewFrame(duration, frameW, frameH, frameX, frameY, axisX, axisY)
    --print("CREATE - " .. duration, frameW, frameH, frameX, frameY, axisX, axisY)
    local frame = {}
    frame.duration = duration
    frame.quad = love.graphics.newQuad((frameX - 1) * frameW, (frameY - 1) * frameH, frameW, frameH, self.image:getWidth(), self.image:getHeight())
    frame.axisX = axisX
    frame.axisY = axisY
    frame.x = frameX
    frame.y = frameY
    table.insert(self.frames, frame)
end

function Animation:update(dt)
    if not self.running then
        return
    end
    self.currentFrameTime = self.currentFrameTime + dt
    if (self.currentFrameTime >= self.currentFrame.duration) then
        --print("frame switch", self.currentFrameNumber)
        self.currentFrameTime = 0
        self.currentFrameNumber = self.currentFrameNumber + 1
        if (self.currentFrameNumber > self.frameCount) then
            if self.onFinish ~= nil then
                self:onFinish()
            end

            if self.loop == false then
                self.running = false
                return
            end
            self.currentFrameNumber = 1
        end

        self.currentFrame = self.frames[self.currentFrameNumber]
    end
end

function Animation:setFlip()
    self.flipped = not self.flipped
end

function Animation:getFlip()
    return self.flipped
end

function Animation:draw(positionX, positionY, flipped, scale, rotation)
    --TODO: Refactor this shit
    if not self.currentFrame then
        return
    end
    self:drawSingleFrame(self.currentFrame, positionX, positionY, flipped, scale, rotation)
end

function Animation:drawSingleFrame(frame, positionX, positionY, flipped, scale, rotation)
    local scale = scale or 1
    local axisX = frame.axisX or 0
    local axisY = frame.axisY or 0
    local scalex = scale * flipped

    if self.blendmode ~= nil then
        local mode, _ = love.graphics.getBlendMode()
        love.graphics.setBlendMode(self.blendmode)
        love.graphics.draw(self.image, frame.quad, positionX, positionY, rotation, scalex, scale, axisX, axisY)
        love.graphics.setBlendMode(mode)
    else
        love.graphics.draw(self.image, frame.quad, positionX, positionY, rotation, scalex, scale, axisX, axisY)
    end
end

function Animation:flip()
    self.flipped = not self.fipped
end

function Animation:start(loop)
    self.currentFrameNumber = 1
    self.currentFrame = self.frames[self.currentFrameNumber]

    self.running = true
    self.loop = loop
    --self.onFinish = onFinish or nil
end

function Animation:stop(frameNumber)
    self.running = false

    if (frameNumber) then
        self.currentFrameNumber = frameNumber
        self.currentFrame = self.frames[self.currentFrameNumber]
    end
end

function Animation:flip()
end

function Animation:clone()
    --this works I guess
    local clone = Animation(self.name, self.image, self.frameW, self.frameH, self.blendmode, self.default)
    for i = 1, self.frameCount do
        local frame = self.frames[i]
        clone:createNewFrame(frame.duration, self.frameW, self.frameH, frame.x or self.default.x, frame.y or self.default.y, frame.axisX or self.default.axisX, frame.axisY or self.default.axisY)
    end
    clone.frameCount = self.frameCount
    return clone
end
