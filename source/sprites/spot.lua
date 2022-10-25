class('Spot').extends(NobleSprite)

local SPOT_WIDTH = 50
local SPOT_HEIGHT = 30

function Spot:init()
    Spot.super.init(self)

    self.type = 'spot'
    self.xCoordinate = math.random(20, 380)
    self.yCoordinate = math.random(30, 220)

    local spotImage = Graphics.image.new(SPOT_WIDTH, SPOT_HEIGHT)
    Graphics.pushContext(spotImage)
    Graphics.setColor(Graphics.kColorBlack)
    Graphics.drawRoundRect(0, 0, SPOT_WIDTH, SPOT_HEIGHT, 5)
    Graphics.popContext()

    self:setCollideRect(SPOT_WIDTH / 4, SPOT_HEIGHT / 4, SPOT_WIDTH / 2, SPOT_HEIGHT / 2)

    self:setImage(spotImage)
    self:moveTo(self.xCoordinate, self.yCoordinate)
end

function Spot:update()
    Spot.super.update(self)

end

function Spot:collisionResponse(other)
    return "overlap"
end
