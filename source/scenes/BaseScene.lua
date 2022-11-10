import 'utilities/Utilities'

BaseScene = {}
class("BaseScene").extends(NobleScene)

BaseScene.backgroundColor = Graphics.kColorWhite		-- This is the background color of this scene.

-- This runs when your scene's object is created, which is the first thing that happens when transitining away from another scene.
function BaseScene:init()
	BaseScene.super.init(self)
	playdate.graphics.setColor(playdate.graphics.kColorBlack)
end


-- When transitioning from another scene, this runs as soon as this scene needs to be visible (this moment depends on which transition type is used).
function BaseScene:enter()
	BaseScene.super.enter(self)

	MenuInstance:addPartsToScene()
	PetInstance:add()
	CursorInstance:add()

	PetInstance:moveTo(Utilities.centerScreen());	
	CursorInstance:moveTo(Utilities.centerScreen());	
end

-- This runs once a transition from another scene is complete.
function BaseScene:start()
	BaseScene.super.start(self)
end

-- This runs once per frame.
function BaseScene:update()
	BaseScene.super.update(self)

	-- PetInstance:bounce()
end

-- This runs once per frame, and is meant for drawing code.
function BaseScene:drawBackground()
	BaseScene.super.drawBackground(self)
end

-- This runs as as soon as a transition to another scene begins.
function BaseScene:exit()
	BaseScene.super.exit(self)
end

-- This runs once a transition to another scene completes.
function BaseScene:finish()
	BaseScene.super.finish(self)
end

function BaseScene:pause()
	BaseScene.super.pause(self)
end

function BaseScene:resume()
	BaseScene.super.resume(self)
end

local crankTick = 0
BaseScene.inputHandler = {

	AButtonDown = function ()
		CursorInstance:clickDown()
	end,

	AButtonUp = function ()
		CursorInstance:clickUp()
	end,

	upButtonDown = function()
		CursorInstance:moveUp();
		MenuInstance.right_pump:moveBy(-2, 0)
	end,
	
	upButtonHold = function()
		CursorInstance:moveUp();
	end,

	rightButtonDown = function()
		CursorInstance:moveRight();
		MenuInstance:focusNextPart();
	end,
	
	rightButtonHold = function()
		CursorInstance:moveRight();
	end,

	downButtonDown = function()
		CursorInstance:moveDown();
		MenuInstance.right_pump:moveBy(2, 0)
	end,
	
	downButtonHold = function()
		CursorInstance:moveDown();
	end,

	leftButtonDown = function()
		CursorInstance:moveLeft();
		MenuInstance:focusPrevPart();
	end,
	
	leftButtonHold = function()
		CursorInstance:moveLeft();
	end,

	cranked = function(change, acceleratedChange)
		crankTick = crankTick + change
		if (crankTick > 30) then
			crankTick = 0
			MenuInstance:focusNextPart();
		elseif (crankTick < -30) then
			crankTick = 0
			MenuInstance:focusPrevPart();
		end
	end,
}
