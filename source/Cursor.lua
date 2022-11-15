Cursor = {}

class('Cursor').extends(NobleSprite)

-- Cursor is disabled by default. Enable by calling `Cursor:setActive(true)` in a scene
function Cursor:init()
    Cursor.super.init(
        self, 
        "assets/images/cursor/cursor",
        true
    )

    self.speed = 8;
    self.isActive = false;
    self:setVisible(false);

    -- You can add more states here; this is a small subset of the cursor sprite sheet
    self.animation:addState("default", 7, 7, nil, true, nil, 3);
    self.animation:addState("pointer", 27, 27, nil, true, nil, 3);
    self.animation:addState("click", 28, 28, nil, true, nil, 3);
    
    self:setSize(28, 28);
    self:setZIndex(32767); -- max possible value
    self:setCollideRect( 0, 0, self:getSize() );
end

function Cursor:update()
    if #self:overlappingSprites() > 0 then
        if self.isClicking then
            self.animation:setState("click")
        else
            self.animation:setState("pointer")
        end
        
    else
        self.animation:setState("default")
    end
end

function Cursor:clickDown()
    if (not self.isActive) then
        return;
    end

    self.isClicking = true;
    local sprites = self:overlappingSprites();
    if #sprites == 0 then
        return
    end

    if sprites[1].handleCursorClickDown ~= nil then
        sprites[1]:handleCursorClickDown();
    end
end

function Cursor:clickUp()
    if (not self.isActive) then
        return;
    end

	self.isClicking = false;
    local sprites = self:overlappingSprites();
    if #sprites == 0 then
        return
    end

    if sprites[1].handleCursorClickUp ~= nil then
        sprites[1]:handleCursorClickUp();
    end
end

---- Movement

-- bound :moveBy by the screen rect
function Cursor:moveByBounded(__x, __y)

    if (not self.isActive) then
        return;
    end

    -- x bounds
    if (self.x + (self.width/2) <= playdate.display.getWidth()) and __x > 0
    or (self.x - (self.width/2) >= 0) and __x < 0 then
        self:moveBy(__x, 0);
    end

    -- y bounds
    if (self.y + (self.height/2) <= playdate.display.getHeight()) and __y > 0
    or (self.y - (self.height/2) >= 0) and __y < 0 then
        self:moveBy(0, __y);
    end  
end

function Cursor:moveUp()
    self:moveByBounded(0, -self.speed);
end

function Cursor:moveRight()
    self:moveByBounded(self.speed, 0);
end

function Cursor:moveDown()
    self:moveByBounded(0, self.speed);
end

function Cursor:moveLeft()
    self:moveByBounded(-self.speed, 0);
end

function Cursor:setActive(bool)
    self:setVisible(bool);
    self.isActive = bool;
end