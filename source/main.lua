
import 'player'

local gfx = playdate.graphics

function hypot(x,y)
	return math.sqrt(x*x+y*y)
end


function setup()
end

local carImage = gfx.image.new('img/logo')
local logoSprite = gfx.sprite.new(carImage)
logoSprite:moveTo(200, 120)
logoSprite:add()

player = Player:new()
player:moveTo(300, 120)
player:setScale(3)
player:setFillColor(gfx.kColorBlack)
player:setStrokeColor(gfx.kColorBlack)
player.wraps = 1
player:addSprite()

setup()

gfx.setColor(gfx.kColorWhite)
gfx.fillRect(0, 0, 400, 240)
gfx.setBackgroundColor(gfx.kColorWhite)

gfx.setColor(gfx.kColorWhite)

function playdate.update()
	gfx.sprite.update()
end

local turn = 0

function playdate.leftButtonDown()	turn -= 1; player:turn(turn)	end
function playdate.leftButtonUp()	turn += 1; player:turn(turn)	end
function playdate.rightButtonDown()	turn += 1; player:turn(turn)	end
function playdate.rightButtonUp()	turn -= 1; player:turn(turn)	end

function playdate.upButtonDown()	player:startThrust()	end
function playdate.upButtonUp()		player:stopThrust()	end
function playdate.downButtonDown()	player:reverseThrust()	end
function playdate.downButtonUp()	player:stopThrust()	end
function playdate.BButtonDown()		player:slowThrust()	end
function playdate.BButtonUp()		player:stopThrust()	end

function levelCleared() setup() end
