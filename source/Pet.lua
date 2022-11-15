import 'utilities/Utilities'
import 'FSM'

Pet = {}

-- Read NobleSprite docs
class('Pet').extends(NobleSprite) 

-- Data for Pet subtypes. You could also implement this as actual subclasses instead. 
local PetData = {
    microbe1 = {
        size = { 92, 101 },
        animations = {
            { 'disturbed', 8 },
            { 'dizzy', 27 },
            { 'eating', 59 },
            { 'excited', 53 },
            { 'idle', 1 },
            { 'needy', 40 },
            { 'sad', 11 },
            { 'sleeping', 4 },
            { 'tired', 10 },
            { 'walking', 5 },
        },
    },
    babyAmoeba = {
        size = { 63, 57 },
        animations = {
            { 'dizzy', 3 },
            { 'eating', 8 },
            { 'excited', 12 },
            { 'idle', 3 },
            { 'needy', 11 },
            { 'sad', 2 },
            { 'tired', 3 },
            { 'walking', 4 },
        },
    },
    vibrio = {
        size = { 75, 114 },
        animations = {
            { 'dizzy', 13 },
            { 'excited', 7 },
            { 'idle', 2 },
            { 'needy', 9 },
            { 'sad', 3 },
            { 'sleeping', 4 },
            { 'walking', 4 },
        },
    },

}

-- Calls sprite.addState for each animation in the above table
local initAnimationsFromData = function (self, animations)
    local lastValue = 0;
    for _i,v in ipairs(animations) do
        local newValue = lastValue + v[2]
        self.animation:addState(v[1], lastValue + 1, newValue, nil, true, nil, 3)
        lastValue = newValue;
    end
end

-- The Pet class. One singleton instance of Pet is constructed in main.lua
function Pet:init(petSaveData)
    local type = petSaveData.type;

    -- Error if the `type` doesn't exist in PetData
    self.data = PetData[type];
    if (self.data == nil) then
        error(tostring(type) .. " is not a valid pet type :(")
    end

    -- The assets in the `pets` folder maps to the keys of the PetData folder
    Pet.super.init(
        self, 
        "assets/images/pets/" .. (type) .. "/" .. (type),
        true
    )

    initAnimationsFromData(self, self.data.animations)

    -- This is a state machine library I found. 
    -- You don't *have* to use this; you might find that simple IF statements in the `update` method work better for you. Your call!
    self.states = {
        hunger = FSM.create({
            initial = "satisfied",
            events = {
              {name = "feed",  from = "starving",  to = "hungry"},
              {name = "feed",  from = "hungry",  to = "satisfied"},
              {name = "feed",  from = "satisfied",  to = "full"},
              {name = "starve",  from = "hungry",  to = "satisfied"},

            }
        })
    }

    self:setScale(8);
    self:setSize(self.data.size[1], self.data.size[2]);
    self:setCollideRect( 0, 0, self:getSize() );
    self.isBouncing = false;
end

-- runs each tick
function Pet:update()
    
end

-- runs each tick, draw code
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
        Noble.Text.draw(self.animation.currentName, 0, 0);
    end
end


-- I haven't tested this in a while and I have made a lot of changes since implementing this
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

    if (self.x + (self.width/2) >= playdate.display.getWidth()) or (self.x - (self.width/2)) <= 0 then
        self.xBounceSpeed = -self.xBounceSpeed;
    end 
 
    if (self.y + (self.height/2) >= playdate.display.getHeight()) or (self.y - (self.height/2)) <= 0 then
        self.yBounceSpeed = -self.yBounceSpeed;
    end 

end

-- I am proud of my cursor code, see how easy it is to add a click handler :)
function Pet:handleCursorClickDown()
    print('pet was clicked')
end

-- used in the dev debug menu
function Pet:getAnimationNames()
    local ret = Utilities.map(self.data.animations, function(item)
        return item[1]
    end)
    return ret
end