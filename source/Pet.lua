import 'utilities/Utilities'

Pet = {}

class('Pet').extends(NobleSprite) 

-- Specific functionality for pet sub-types
-- Animation assets for each sub-type are retrieved from "assets/images/pets/<petName>/"
-- -- e.g. "assets/images/pets/microbe1/"
local PetConstructors = {
    microbe1 = function(self)
        
        -- #frames
        -- 1
        self.animation:addState("idle", 1, 1, nil, true, nil, 3)
        -- 8
        self.animation:addState("disturbed", 1, 8, nil, true, nil, 3)
        -- 9
        self.animation:addState("dizzy", 9, 17, nil, true, nil, 3)
        -- 20
        self.animation:addState("eating", 18, 37, nil, true, nil, 3)
        -- 16
        self.animation:addState("excited", 38, 53, nil, true, nil, 3)
        -- 14
        self.animation:addState("needy", 54, 67, nil, true, nil, 3)
        -- 11
        self.animation:addState("sad", 68, 78, nil, true, nil, 3)
        -- 4
        self.animation:addState("sleeping", 79, 82, nil, true, nil, 3)
        -- 9
        self.animation:addState("tired", 83, 91, nil, true, nil, 3)
        -- 5
        self.animation:addState("walking", 92, 96, nil, true, nil, 3)
    end
}

function Pet:init(petSaveData)
    local type = petSaveData.type;
    if (PetConstructors[type] == nil) then
        error(tostring(type) .. " is not a valid pet type :(")
    end

    Pet.super.init(
        self, 
        "assets/images/pets/" .. (type) .. "/" .. (type),
        true
    )

    PetConstructors[type](self);

    self.isBouncing = false;
end

function Pet:draw(__x, __y)
    Pet.super.draw(
        self,
        __x or self.x,
        __y or self.y
    )

    if self.isBouncing then
        self:bounce();
    end

    if DEBUG_MODE then
        Noble.Text.draw(self.animation.currentName, 2, 15);
    end
end

Pet.xBounceSpeed = 1.5;
Pet.yBounceSpeed = 1.5;
function Pet:bounce()
    self.animation:setState("walking");

    if (self.xBounceSpeed < 0) then
        self.animation.direction = Noble.Animation.DIRECTION_LEFT
    else
        self.animation.direction = Noble.Animation.DIRECTION_RIGHT
    end

    self:moveTo(self.x + self.xBounceSpeed, self.y + self.yBounceSpeed);

    if (self.x + 92 >= playdate.display.getWidth()) or self.x <= 0 then
        self.xBounceSpeed = -self.xBounceSpeed;
    end 

    if (self.y + 101 >= playdate.display.getHeight()) or self.y <= 0 then
        self.yBounceSpeed = -self.yBounceSpeed;
    end 

end

-- This is bad, look into pathfinding as an alternative
function Pet:walkToOrigin()
    local slope = Utilities.slope(self.x, self.y, (playdate.display.getWidth()/2) - (92/2), (playdate.display.getHeight()/2) - (101/2))
        
    if (math.abs(slope[1]) < 10 and math.abs(slope[2]) < 10) then
        self.xBounceSpeed = 0;
        self.yBounceSpeed = 0;
        return;
    end
    
    self.xBounceSpeed = slope[2]/30;
    self.yBounceSpeed = slope[1]/30;

    self:moveTo(self.x + self.xBounceSpeed, self.y + self.yBounceSpeed);
end