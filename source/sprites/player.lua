
import 'sprites/vectorsprite'

local pd <const> = playdate


local maxspeed = 5
local minspeed = 0
local turnspeed = 3
local thrustspeed = 0.4

class("Player").extends(VectorSprite)

function Player:init(game, verts)
	Player.super.init(self, verts)

	self.game = game
	self.da = 0
	self.dx = 0
	self.dy = 0
	self.angle = 0
	self.thrusting = 0
	self.wraps = true
	self.turnValue = 0
	self.currentSpeed = 0
end
	
function Player:collide(s)
	print(s)
end

function Player:turn(d)
	self.da = turnspeed * d
end

function Player:collision(other)
	-- if other.type == "spot" and self.currentSpeed == 0 then
		
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

	if self.thrusting == 1 and self.currentSpeed < maxspeed then
		self.currentSpeed += 1
	end

	if self.thrusting == -2 and self.currentSpeed > maxspeed * -1 then
		self.currentSpeed -= 1
	end

	local dx = self.dx + self.currentSpeed * math.cos(math.rad(self.angle))
	local dy = self.dy + self.currentSpeed * math.sin(math.rad(self.angle))
	local m = hypot(dx, dy)
	
	if m > maxspeed then
		dx *= maxspeed / m
		dy *= maxspeed / m
	end
	
	if  self.currentSpeed == 0 then
		dx = 0
		dy = 0
	end

	self:setVelocity(dx, dy)

	if self.currentSpeed == 0 then
		local collisions = self:overlappingSprites()
	
		if #collisions > 0 then
		 self.game:park()
		end
	end
end

function Player:startThrust()
	self.thrusting = 1
end

function Player:reverseThrust()
	self.thrusting = -2
end

function Player:applyBreaks()
	self.thrusting = 0

	self.currentSpeed = 0
end

function Player:stopThrust()
	self.thrusting = 0
end

