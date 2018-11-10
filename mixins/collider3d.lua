c3d = {}

function c3d:c3dInit(x, y, w, h, d)
    self.collider3d = true
    self.w = w
    self.h = h
    self.d = d
    --adjust the box to properly cover our animations
    world:add(self, x - w / 2, y - h, 0, w, h, d)
end

function c3d:c3dRemove()
    world:remove(self)
end

function c3d:c3dMove(posx, posy)
    local actualX, actualY, actualZ, cols, len =
        world:move(
        self,
        posx - self.w / 2,
        posy - self.h,
        0,
        function(item, other)
            --print(item.id)
            return self:collisionFilter(item, other)
        end
    )
    for i = 1, len do
        print("collided with " .. tostring(cols[i].other))
        self:collisionResolution(cols[i])
    end
    return actualX + self.w / 2, actualY + self.h
end

local function drawItem(item)
    if item.invisible == true then
        return
    end

    local setAlpha = function(alpha)
        love.graphics.setColor(0.2 * alpha, 1 * alpha, 0.2 * alpha, alpha)
    end

    local x, y, z, w, h, d = world:getCube(item)
    --[[ 
    -- Front Side
    setAlpha(0.4)
    love.graphics.rectangle("fill", x, y + z + h, w, d)
    setAlpha(0.6)
    love.graphics.rectangle("line", x, y + z + h, w, d) ]]
    -- Top
    setAlpha(0.4)
    love.graphics.rectangle("fill", x, y + z, w, h)
    setAlpha(0.6)
    love.graphics.rectangle("line", x, y + z, w, h)
    love.graphics.setColor(1, 1, 1, 1)

    -- back side
    setAlpha(0.4)
    love.graphics.rectangle("fill", x - d, y - d, w, h)
    setAlpha(0.6)
    love.graphics.rectangle("line", x - d, y - d, w, h)
    love.graphics.setColor(1, 1, 1, 1)
end

function c3d:c3dDraw()
    drawItem(self)
end

return c3d
