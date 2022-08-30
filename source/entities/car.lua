local pd <const> = playdate
local gfx <const> = playdate.graphics

import './vectorsprite'

local maxspeed = 12
local turnspeed = 8
local thrustspeed = 0.6

class('Car').extends(gfx.sprite)

function Car:init()
    local self = VectorSprite:new({ 4, 0, -4, 3, -2, 0, -4, -3, 4, 0 })

    Car.super.init(self)

    local carImage = gfx.image.new(20, 50)

    self:moveTo(200, 120)
    self:setScale(3)
    self:setFillPattern({ 0xf0, 0xf0, 0xf0, 0xf0, 0x0f, 0x0f, 0x0f, 0x0f })
    self:setStrokeColor(gfx.kColorWhite)
    self.wraps = 1
    self:addSprite()


    -- gfx.pushContext(carImage)
    -- gfx.fillRect(0, 0, 30, 100)
    -- gfx.popContext()

    -- self:setImage(carImage)
    -- self:moveTo(200, 100)
    -- self:add()
end

function Car:turn(d)
    self.da = turnspeed * d
end


function Car:update()
    self:updatePosition()

    if self.thrusting == 1 
    then
        local dx = self.dx + thrustspeed * math.cos(math.rad(self.angle))
        local dy = self.dy + thrustspeed * math.sin(math.rad(self.angle))
        local m = hypot(dx, dy)
        
        if m > maxspeed then
            dx *= maxspeed / m
            dy *= maxspeed / m
        end
        
        self:setVelocity(dx, dy)
    end
end

function Car:startThrust()
    
    self.thrusting = 1
end

function Car:stopThrust()
  
    self.thrusting = 0
end

function Car:update()
    Car.super.update(self)

    if (pd.buttonIsPressed(pd.kButtonUp)) then
        self:moveTo(self.x, self.y - 3)
    elseif (pd.buttonIsPressed(pd.kButtonDown)) then
        self:moveTo(self.x, self.y + 3)
    end

    if (pd.buttonIsPressed(pd.kButtonLeft)) then
        self:moveTo(self.x - 3, self.y)
    elseif (pd.buttonIsPressed(pd.kButtonRight)) then
        self:moveTo(self.x + 3, self.y)
    end

    local crankTicks = pd.getCrankTicks(2)
    if crankTicks == 1 then

    elseif crankTicks == -1 then

    end
end
