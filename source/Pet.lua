Pet = {}

class('Pet').extends(NobleSprite) 

-- Specific functionality for pet sub-types
-- Animation assets for each sub-type are retrieved from "assets/images/pets/<petName>"
-- -- e.g. "assets/images/pets/ducky"
local PetConstructors = {
    ducky = function(self)
        self.animation:addState("idle", 1, 4, nil, true, nil, 30)
        self.animation:addState("angry", 5, 5)
    end
}

function Pet:init(petSaveData)
    local type = petSaveData.type;
    if (PetConstructors[type] == nil) then
        error(type .. "is not a valid pet type")
    end

    Pet.super.init(
        self, 
        "assets/images/pets/" .. (type),
        true
    )

    PetConstructors[type](self);
end

function Pet:draw(__x, __y)
    Pet.super.draw(self, __x, __y)
    if DEBUG_MODE then
        Noble.Text.draw(self.animation.currentName, 2, 15);
    end
end
