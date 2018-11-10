require "ents.simpleeffect"

function trunc(num, digits)
    local mult = 10 ^ (digits)
    return math.modf(num * mult) / mult
end

function fx(animname, posx, posy, duration, flip, scale, rotate)
    assert(animations[animname], "This effect does not exist in the animation table")
    EM:add(SimpleEffect(animations[animname]:clone(), posx, posy, duration, flip, scale, rotate))
end

function pic(image, quad, posx, posy, duration, axisX, axisY, flip, scale, rotate, blendmode, color)
    --assert(animations[animname], "This effect does not exist in the animation table")
    EM:add(SimpleSprite(image, quad, posx, posy, duration, axisX, axisY, flip, scale, rotate, blendmode, color))
end

function mixin(class, mixin)
    for name, method in pairs(mixin) do
        class[name] = method
    end
end
