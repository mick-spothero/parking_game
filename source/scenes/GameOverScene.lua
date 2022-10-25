GameOverScene = {}
class("GameOverScene").extends(NobleScene)

GameOverScene.baseColor = Graphics.kColorWhite

local background
local menu
local sequence


function GameOverScene:init()
    GameOverScene.super.init(self)

    background = Graphics.image.new("assets/images/background2")

    menu = Noble.Menu.new(false, Noble.Text.ALIGN_LEFT, false, Graphics.kColorWhite, 4, 6, 0, Noble.Text.FONT_LARGE)

    menu:addItem('Retry', function() Noble.transition(GameScene, 1, Noble.TransitionType.DIP_TO_BLACK) end)


    local crankTick = 0

    GameOverScene.inputHandler = {
        upButtonDown = function()
            menu:selectPrevious()
        end,
        downButtonDown = function()
            menu:selectNext()
        end,
        cranked = function(change, acceleratedChange)
            crankTick = crankTick + change
            if (crankTick > 30) then
                crankTick = 0
                menu:selectNext()
            elseif (crankTick < -30) then
                crankTick = 0
                menu:selectPrevious()
            end
        end,
        AButtonDown = function()
            menu:click()
        end
    }

end

function GameOverScene:enter()
    GameOverScene.super.enter(self)

    sequence = Sequence.new():from(0):to(100, 1.5, Ease.outBounce)
    sequence:start();

end

function GameOverScene:start()
    GameOverScene.super.start(self)

    menu:activate()
    Noble.Input.setCrankIndicatorStatus(true)

end

function GameScene:exit()
    GameScene.super.exit(self)
    SCORE = 0
end

function GameOverScene:drawBackground()
    GameOverScene.super.drawBackground(self)

    background:draw(0, 0)
end

function GameOverScene:update()
    GameOverScene.super.update(self)

    Graphics.setColor(Graphics.kColorBlack)
    Graphics.setDitherPattern(0.2, Graphics.image.kDitherTypeScreen)
    Graphics.fillRoundRect(15, (sequence:get() * 0.75) + 3, 185, 145, 15)
    menu:draw(30, sequence:get() - 15 or 100 - 15)

end

function GameOverScene:exit()
    GameOverScene.super.exit(self)

    Noble.Input.setCrankIndicatorStatus(false)
    sequence = Sequence.new():from(100):to(240, 0.25, Ease.inSine)
    sequence:start();

end

function GameOverScene:finish()
    GameOverScene.super.finish(self)
end