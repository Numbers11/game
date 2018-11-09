-- ToDo: Hitboxes & Hurtboxes
-- figuring out jumps /3rd dimentions 2.5d
-- new Entity NPC, maybe with a common "actor" class for player and npc (x)
-- also a camera
-- and a map
DEBUG = true

local Map = require "map"
timer = require "libs.hump.timer"

require "util"
require "anim.animation"
require "ents.player"
require "ents.entity"
require "ents.simplesprite"
require "ents.afterimage"
EM = require "entitymanager"
animations = {}

function love.load()
    love.window.setMode(1280, 720)

    --load animation data to a global table where they can get cloned from for individual usage. Useless? Deffo refactor to somewhere tho
    local animdata = require "data.animationdata"
    for name, data in pairs(animdata) do
        animations[name] = Animation(name, data.image, data.frameW, data.frameH, data.blendmode, data.default)
        animations[name]:loadFrameData(data.frames)
    end

    local imgWall = love.graphics.newImage("assets/wall.png")

    timer.every(
        0.6,
        function()
            fx("fxSwirl2", math.random(200, 600), math.random(200, 600), 0, nil, nil, math.rad(math.random(1, 360)))
            --                  image, posx, posy, duration, axisX, axisY, flip, scale, rotate, blendmode
            --pic(imgWall, nil, math.random(200, 600), math.random(200, 600), 3, 0,0, nil, math.random(0.5, 1.5), math.rad(math.random(1, 360)))
        end
    )

    Map.load()

    -- to be refactored to a "game.lua" gamestate file in the future
    local aPlayer = Player("Heinz", 500, 600)
    local ff = Player("Adolf", 100, 600)
    EM:add(aPlayer)
    EM:add(ff)
    local char = Character("Fred", 200, 600)
    char.scale = 1.1
    char.animation = animations["sasoriSlide"]:clone()
    char.animation:start()
    char.friction = 1
    char:setVelocity(vec(200,0))
    EM:add(char)
end

function love.keypressed(key, unicode)
    if key == "f1" then
        DEBUG = not DEBUG
    end
end

function love.update(dt)
    timer.update(dt)

    --our game handlers
    Map.update(dt)
    EM:update(dt)
end

function love.draw()
    Map.draw()
    EM:draw()
    --[[ 	love.graphics.setBlendMode("alpha") --Default blend mode
	love.graphics.setColor(0.9, 0.01, 0.5)
    love.graphics.rectangle("fill", 50, 50, 100, 100)

	love.graphics.setColor(0.01, 0.03, 0.9)
	love.graphics.setBlendMode("screen", "premultiplied")
    love.graphics.rectangle("fill", 75, 75, 125, 125)
    love.graphics.setBlendMode("alpha") --Default blend mode
    love.graphics.setColor(1,1,1) ]]
    --debug info
    if DEBUG then
        love.graphics.print(love.timer.getFPS() .. "\n" .. collectgarbage("count") .. "\n" .. EM.count, 1, 1)
    end
end
