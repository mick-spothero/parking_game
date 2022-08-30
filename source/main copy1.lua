import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"

import "./entities/car"

local pd <const> = playdate
local gfx <const> = playdate.graphics

local car = Car()

-- local function initialize()
    
-- end

-- initialize()

function pd.update()
    gfx.sprite.update()
end

local turn = 0

function playdate.leftButtonDown()	turn -= 1; car:turn(turn)	end
function playdate.leftButtonUp()	turn += 1; car:turn(turn)	end
function playdate.rightButtonDown()	turn += 1; car:turn(turn)	end
function playdate.rightButtonUp()	turn -= 1; car:turn(turn)	end

function playdate.upButtonDown()	car:startThrust()	end
function playdate.upButtonUp()		car:stopThrust()	end