
import 'vectorsprite'

local pd <const> = playdate


local maxspeed = 7
local minspeed = 0
local currentSpeed = 0
local turnspeed = 3
local thrustspeed = 0.4

class("Player").extends(VectorSprite)

function Player:init(verts)
	Player.super.init(self, verts)

	self.da = 0
	self.dx = 0
	self.dy = 0
	self.angle = 0
	self.thrusting = 0
	self.wraps = true
	self.turnValue = 0
end
	
function Player:collide(s)
	print(s)
end

function Player:turn(d)
	self.da = turnspeed * d
end

function Player:hit()
	print("hit!")
end

function Player:collision(other)
	-- if other.type == "asteroid" then
	-- 	self:hit(other)
	-- end
end

function Player:update()
	Player.super.update(self)

	-- if pd.buttonIsPressed(pd.kButtonLeft) then
	-- 	self.turnValue -= 1
	-- 	self:turn(self.turnValue)
	-- elseif pd.buttonIsPressed(pd.kButtonRight) then
	-- 	self.turnValue += 1
	-- 	self:turn(self.turnValue)
	-- end

	self:updatePosition()

	if self.thrusting == 1 and currentSpeed < maxspeed then
		currentSpeed += 1
	end
	
	-- Applying breaks
	if self.thrusting == -1 and currentSpeed > 0 then
		currentSpeed -= 0.25

	elseif self.thrusting == -1 and currentSpeed < 0 then
		currentSpeed += 0.25
	end

	if self.thrusting == -2 and currentSpeed > maxspeed * -1 then
		currentSpeed -= 1
	end

	local dx = self.dx + currentSpeed * math.cos(math.rad(self.angle))
	local dy = self.dy + currentSpeed * math.sin(math.rad(self.angle))
	local m = hypot(dx, dy)
	
	if m > maxspeed then
		dx *= maxspeed / m
		dy *= maxspeed / m
	end
	
	if self.thrusting == -1 and currentSpeed == 0 then
		dx = 0
		dy = 0
	end

	self:setVelocity(dx, dy)
end

function Player:startThrust()
	self.thrusting = 1
end

function Player:reverseThrust()
	self.thrusting = -2
end

function Player:slowThrust()
	self.thrusting = -1
end

function Player:stopThrust()
	self.thrusting = 0
end

