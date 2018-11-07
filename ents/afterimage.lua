local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin = math.asin

-- For all easing functions:
-- t = elapsed time
-- b = begin
-- c = change == ending - beginning
-- d = duration (total time)

local function linear(t, b, c, d)
    return c * t / d + b
end

local function inQuad(t, b, c, d)
    t = t / d
    return c * pow(t, 2) + b
end

local function outQuad(t, b, c, d)
    t = t / d
    return -c * t * (t - 2) + b
end

require("libs.lclass")
require "ents.simplesprite"

class "AfterImage"("SimpleSprite")

function AfterImage:AfterImage(image, quad, posx, posy, duration, axisX, axisY, flip, scale, rotate, blendmode, color)
    SimpleSprite.SimpleSprite(self, image, quad, posx, posy, duration, axisX, axisY, flip, scale, rotate, blendmode, color)
    self._update = SimpleSprite.update
    self._draw = SimpleSprite.draw
end

function AfterImage:update(dt)
    self.color[4] = outQuad(self.timer, 1.0, -1, self.duration)
    self:_update(dt)
end

function AfterImage:draw()
    --self.animation:draw(self.position.x, self.position.y, self.flip, self.scale, self.rotate)
    self:_draw()
end

function AfterImage:getType()
    return "AfterImage"
end
