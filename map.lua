local Map = {}

Map.width = 4000
Map.bgheight = 500
Map.bgimage = "wall.png"


function Map.load()
    bg_image = love.graphics.newImage("assets/wall.png")
    bg_image:setWrap("repeat", "clamp")
    

    -- note how the Quad's width and height are larger than the image width and height.
    bg_quad = love.graphics.newQuad(0, 0, Map.width, Map.bgheight, bg_image:getWidth(), bg_image:getHeight())

end

function Map.update(dt)

end

function Map.draw()
    love.graphics.draw(bg_image, bg_quad, 0, 0)

end

return Map