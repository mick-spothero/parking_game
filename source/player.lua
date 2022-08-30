
import 'vectorsprite'

Player = {}
Player.__index = Player

local maxspeed = 10
local minspeed = 0
local currentSpeed = 0
local turnspeed = 3
local thrustspeed = 0.4

function Player:new()
	local self = VectorSprite:new({0, 0, 8, 5})

	self.da = 0
	self.dx = 0
	self.dy = 0
	self.angle = 0
	self.thrusting = 0
	self.wraps = true
	
	function self:collide(s)
		print(s)
	end
	
	function self:turn(d)
		self.da = turnspeed * d
	end

	function self:hit()
		print("hit!")
	end

	function self.collision(other)
		-- if other.type == "asteroid" then
		-- 	self:hit(other)
		-- end
	end
	
	function self:update()
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

		print(m)
		
		if m > maxspeed then
			dx *= maxspeed / m
			dy *= maxspeed / m
		end
		
		if self.thrusting == -1 and currentSpeed == 0 then
			dx = 0
			dy = 0
		end

		self:setVelocity(dx, dy)

		-- if self.thrusting == -1 then
		-- 	local dx = self.dx - thrustspeed * math.cos(math.rad(self.angle))
		-- 	local dy = self.dy - thrustspeed * math.sin(math.rad(self.angle))
		-- 	local m = hypot(dx, dy)

		-- 	print(m)
			
		-- 	if m < minspeed then
		-- 		dx *= minspeed / m
		-- 		dy *= minspeed / m
		-- 	end
			
		-- 	self:setVelocity(dx, dy)
		-- end
	end
	
	function self:startThrust()
		self.thrusting = 1
	end

	function self:reverseThrust()
		self.thrusting = -2
	end

	function self:slowThrust()
		self.thrusting = -1
	end

	function self:stopThrust()
		self.thrusting = 0
	end

	return self
end
