class('Time').extends(NobleSprite)


function Time:init(finishCallback)

    Time.super.init(self)

    self.time = 0
    self.finishCallback = finishCallback

    self:setZIndex(900)
    self:setIgnoresDrawOffset(true)
    self:setCenter(0, 0)
    self:moveTo(240, 40)
end

function Time:add()
    Time.super.add(self)
    self.time = playdate.timer.new(20000, self.finishCallback)
end

function Time:update()
    Time.super.update(self)
    local text = Graphics.image.new(200, 20)

    Graphics.pushContext(text)
    Noble.Text.draw("Time: " .. tostring(math.ceil(self.time.timeLeft / 1000)), 0, 0)
    Graphics.popContext()

    self:setImage(text)
end
