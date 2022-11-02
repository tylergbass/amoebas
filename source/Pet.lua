import 'utilities/Utilities'

Pet = {}

class('Pet').extends(NobleSprite) 

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

local initAnimationsFromData = function (self, animations)
    local lastValue = 0;
    for _i,v in ipairs(animations) do
        local newValue = lastValue + v[2]
        self.animation:addState(v[1], lastValue + 1, newValue, nil, true, nil, 3)
        lastValue = newValue;
    end
end

function Pet:init(petSaveData)
    local type = petSaveData.type;

    self.data = PetData[type];
    if (self.data == nil) then
        error(tostring(type) .. " is not a valid pet type :(")
    end

    Pet.super.init(
        self, 
        "assets/images/pets/" .. (type) .. "/" .. (type),
        true
    )


    initAnimationsFromData(self, self.data.animations)

    self:setSize(self.data.size[1], self.data.size[2]);
    self:setCollideRect( 0, 0, self:getSize() );
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
        Noble.Text.draw(self.animation.currentName, 0, 0);
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

    if (self.x + (self.width/2) >= playdate.display.getWidth()) or (self.x - (self.width/2)) <= 0 then
        self.xBounceSpeed = -self.xBounceSpeed;
    end 
 
    if (self.y + (self.height/2) >= playdate.display.getHeight()) or (self.y - (self.height/2)) <= 0 then
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

function Pet:handleCursorClickDown()
    -- TODO: remove later
    self.animation:setState("needy")
end

function Pet:getAnimationNames()
    local ret = Utilities.map(self.data.animations, function(item)
        return item[1]
    end)
    return ret
end