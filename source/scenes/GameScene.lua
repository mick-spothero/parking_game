import "sprites/player"
import "sprites/spot"
import "sprites/score"
import "sprites/time"

GameScene = {}
class("GameScene").extends(NobleScene)

GameScene.baseColor = Graphics.kColorWhite

local background
local player
local spot
local score
local timer

function GameScene:init()
	GameScene.super.init(self)

	background = Graphics.image.new("assets/images/logo")
    player = Player(self)
	player:moveTo(300, 120)
	player:setScale(3)
	player:setFillColor(Graphics.kColorBlack)
	player:setStrokeColor(Graphics.kColorBlack)
	player.wraps = 1

	spot = Spot()
	score = Score()
	timer = Time(function() Noble.transition(GameOverScene, 1, Noble.TransitionType.DIP_TO_BLACK) end)

    local turn = 0
	-- local crankTick = 0

	GameScene.inputHandler = {
		leftButtonUp = function()
			turn += 1; player:turn(turn)
		end,
		leftButtonDown = function()
			turn -= 1; player:turn(turn)
		end,
		rightButtonUp = function()
			turn -= 1; player:turn(turn)
		end,
		rightButtonDown = function()
			turn += 1; player:turn(turn)
		end,
		upButtonUp = function()
			player:stopThrust()
		end,
		upButtonDown = function()
			player:startThrust()
		end,
		downButtonUp = function()
			player:stopThrust()
		end,
		downButtonDown = function()
			player:reverseThrust()
		end,
		BButtonDown = function()
			player:slowThrust()
		end
		-- cranked = function(change, acceleratedChange)
		-- 	crankTick = crankTick + change
		-- 	if (crankTick > 30) then
		-- 		crankTick = 0
		-- 		menu:selectNext()
		-- 	elseif (crankTick < -30) then
		-- 		crankTick = 0
		-- 		menu:selectPrevious()
		-- 	end
		-- end,
	}

end

function GameScene:enter()
	GameScene.super.enter(self)

	SCORE = 0
end

function GameScene:start()
	GameScene.super.start(self)

    player:add()
	spot:add()
	score:add()
	timer:add()
end

function GameScene:park()
	spot:remove()
	SCORE = SCORE + 1
	score:addOne()
	spot = Spot()
	spot:add()
end

function GameScene:drawBackground()
	GameScene.super.drawBackground(self)

	background:draw(140, 80)
end

function GameScene:update()
	GameScene.super.update(self)
end

function GameScene:exit()
	GameScene.super.exit(self)
end

function GameScene:finish()
	GameScene.super.finish(self)
end