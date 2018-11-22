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

-- Lua Table View by Elertan
table.print = function(t, exclusions)
    local nests = 0
    if not exclusions then exclusions = {} end
    local recurse = function(t, recurse, exclusions)
        indent = function()
            for i = 1, nests do
                io.write("    ")
            end
        end
        local excluded = function(key)
            for k,v in pairs(exclusions) do
                if v == key then
                    return true
                end
            end
            return false
        end
        local isFirst = true
        for k,v in pairs(t) do
            if isFirst then
                indent()
                print("|")
                isFirst = false
            end
            if type(v) == "table" and not excluded(k) then
                indent()
                print("|-> "..k..": "..type(v))
                nests = nests + 1
                recurse(v, recurse, exclusions)
            elseif excluded(k) then
                indent()
                print("|-> "..k..": "..type(v))
            elseif type(v) == "userdata" or type(v) == "function" then
                indent()
                print("|-> "..k..": "..type(v))
            elseif type(v) == "string" then
                indent()
                print("|-> "..k..": ".."\""..v.."\"")
            else
                indent()
                print("|-> "..k..": "..v)
            end
        end
        nests = nests - 1
    end

    nests = 0
    print("### START TABLE ###")
    for k,v in pairs(t) do
        print("root")
        if type(v) == "table" then
            print("|-> "..k..": "..type(v))
            nests = nests + 1
            recurse(v, recurse, exclusions)
        elseif type(v) == "userdata" or type(v) == "function" then
            print("|-> "..k..": "..type(v))
        elseif type(v) == "string" then
            print("|-> "..k..": ".."\""..v.."\"")
        else
            print("|-> "..k..": "..v)
        end
    end
    print("### END TABLE ###")
end