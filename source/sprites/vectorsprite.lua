import 'CoreLibs/sprites'

local gfx = playdate.graphics
local geom = playdate.geometry

class('VectorSprite').extends(NobleSprite)

function hypot(x, y)
	return math.sqrt(x * x + y * y)
end

function VectorSprite:init()
	VectorSprite.super.init(self)
	local points = {}

	self.polygon = geom.polygon.new(0, 0, 8, 0, 9, 1, 9, 4, 8, 5, 0, 5, 1, 4, 1, 1, 0, 0)
	self.drawnpolygon = polygon

	self._x = 0
	self._y = 0
	self.dx = 0
	self.dy = 0
	self.angle = 0
	self.da = 0
	self.scale = 1
	self.xscale = 1
	self.yscale = 1
	self.strokeWidth = 1
	self:setCollideRect(0, 0, 1, 1)
end

function VectorSprite:updateBounds()

	local t = geom.affineTransform.new()
	t:rotate(self.angle, 5, 10)
	t:scale(self.xscale, self.yscale)

	local p = self.polygon * t
	local bx, by, bw, bh = p:getBounds()

	t:translate(-bx + self.strokeWidth / 2, -by + self.strokeWidth / 2)
	self.drawnpolygon = self.polygon * t

	self:setSize(bw + self.strokeWidth + 1, bh + self.strokeWidth + 1)
	self:setCenter(-bx / bw, -by / bh)

	if self.collision ~= nil then
		self:setCollideRect(2, 2, bw - 4, bh - 4)
	end
end

function VectorSprite:setScale(xscale, yscale)
	self.xscale = xscale

	if yscale then
		self.yscale = yscale
	else
		self.yscale = xscale
	end

	self:updateBounds()
end

function VectorSprite:setVelocity(dx, dy, da)
	self.dx = dx
	self.dy = dy

	if da then self.da = da end
end

function VectorSprite:updatePosition()
	if self.da ~= 0 then
		self.angle = self.angle + (self.da or 0)
	end

	if self.wraps then
		local x, y, w, h = self:getBounds()

		if y > 240 then
			self:moveTo(self.x, self.y - (240 + h))
			return
		elseif y + h < 0 then
			self:moveTo(self.x, self.y + (240 + h))
			return
		elseif x > 400 then
			self:moveTo(self.x - (400 + w), self.y)
			return
		elseif x + w < 0 then
			self:moveTo(self.x + (400 + w), self.y)
			return
		end
	end

	if self.dx ~= 0 or self.dy ~= 0 then
		if self.collision ~= nil then
			local x, y, c, n = self:moveWithCollisions(self.x + self.dx, self.y + self.dy)

			for i = 1, n do
				self:collision(c[i].other)
			end
		else
			self:moveTo(self.x + self.dx, self.y + self.dy)
		end
	end

	if self.da ~= 0 then
		self:updateBounds()
	end
end

function VectorSprite:update()
	self:updatePosition()
end

function VectorSprite:setFillPattern(p)
	self.fillColor = nil
	self.fillPattern = p
end

function VectorSprite:setFillColor(c)
	self.fillPattern = nil
	self.fillColor = c
end

function VectorSprite:setStrokePattern(p)
	self.strokeColor = nil
	self.strokePattern = p
end

function VectorSprite:setStrokeColor(c)
	self.strokePattern = nil
	self.strokeColor = c
end

function VectorSprite:setStrokeWidth(w)
	self.strokeWidth = w
end

function VectorSprite:draw()
	if self.fillPattern then
		gfx.setPattern(self.fillPattern)
		gfx.fillPolygon(self.drawnpolygon)
	elseif self.fillColor then
		gfx.setColor(self.fillColor)
		gfx.fillPolygon(self.drawnpolygon)
	end

	if self.strokePattern then
		gfx.setPattern(self.strokePattern)
		gfx.drawPolygon(self.drawnpolygon, self.strokeWidth or 0)
	elseif self.strokeColor == gfx.kColorClear then
		-- don't
	else
		gfx.setColor(self.strokeColor or gfx.kColorWhite)
		gfx.drawPolygon(self.drawnpolygon, self.strokeWidth or 0)
	end
end

function VectorSprite:collisionResponse(other)
	return "overlap"
end
