class('Score').extends(NobleSprite)


function Score:init()

    Score.super.init(self)

    self.score = 0

    self:setZIndex(900)
    self:setIgnoresDrawOffset(true)
    self:setCenter(0, 0)
    self:setSize(200, 20)
    self:moveTo(240, 10)
end

function Score:addOne()
    self.score = self.score + 1
    self:markDirty()
end

function Score:draw()
    Noble.Text.draw("Successful Parks: " .. tostring(self.score), 0, 0)
end
