Pet = {}

class('Pet').extends(NobleSprite) 

-- Specific functionality for pet sub-types
-- Animation assets for each sub-type are retrieved from "assets/images/pets/<petName>"
-- -- e.g. "assets/images/pets/adventurer"
local PetConstructors = {
    adventurer = function(self)
        self.animation:addState("idle", 1, 4, nil, true, nil, 3)
        self.animation:addState("run", 9, 14, nil, true, nil, 3)
    end
}

function Pet:init(petSaveData)
    local type = petSaveData.type;
    if (PetConstructors[type] == nil) then
        error(tostring(type) .. " is not a valid pet type :(")
    end

    Pet.super.init(
        self, 
        "assets/images/pets/" .. (type),
        true
    )

    PetConstructors[type](self);
end

function Pet:draw(__x, __y)
    Pet.super.draw(
        self,
        __x or self.x,
        __y or self.y
    )

    if DEBUG_MODE then
        Noble.Text.draw(self.animation.currentName, 2, 15);
    end
end

Pet.xBounceSpeed = 1;
Pet.yBounceSpeed = 1;
function Pet:bounce()
    print(self.xBounceSpeed, self.yBounceSpeed, self.x, self.y, self.width, self.height)
    self:moveTo(self.x + self.xBounceSpeed, self.y + self.yBounceSpeed);

    if self.x + 50 == playdate.display.getWidth() or self.x <= 0 then
        self.xBounceSpeed = -self.xBounceSpeed;
    end 

    if self.y + 37 == playdate.display.getHeight() or self.y <= 0 then
        self.yBounceSpeed = -self.yBounceSpeed;
    end 
end