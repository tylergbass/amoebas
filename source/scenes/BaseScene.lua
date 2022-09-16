BaseScene = {}
class("BaseScene").extends(NobleScene)

BaseScene.backgroundColor = Graphics.kColorWhite		-- This is the background color of this scene.

-- This runs when your scene's object is created, which is the first thing that happens when transitining away from another scene.
function BaseScene:init()
	BaseScene.super.init(self)
	playdate.graphics.setColor(playdate.graphics.kColorBlack)

	PetInstance:moveTo(200, 100);
end

-- When transitioning from another scene, this runs as soon as this scene needs to be visible (this moment depends on which transition type is used).
function BaseScene:enter()
	BaseScene.super.enter(self)
	PetInstance:add()
	
end

-- This runs once a transition from another scene is complete.
function BaseScene:start()
	BaseScene.super.start(self)
end

-- This runs once per frame.
function BaseScene:update()
	BaseScene.super.update(self)
	PetInstance:draw()
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

-- You can define this here, or within your scene's init() function.
BaseScene.inputHandler = {

	-- A button
	--
	AButtonDown = function()			-- Runs once when button is pressed.
		PetInstance.animation:setState('angry')
		-- Your code here
	end,
	AButtonHold = function()			-- Runs every frame while the player is holding button down.
		-- Your code here
	end,
	AButtonHeld = function()			-- Runs after button is held for 1 second.
		-- Your code here
	end,
	AButtonUp = function()				-- Runs once when button is released.
		-- Your code here
	end,

	-- B button
	--
	BButtonDown = function()
		-- Your code here
		PetInstance.animation:setState('idle')
	end,
	BButtonHeld = function()
		-- Your code here
	end,
	BButtonHold = function()
		-- Your code here
	end,
	BButtonUp = function()
		-- Your code here
	end,

	-- D-pad left
	--
	leftButtonDown = function()
		-- Your code here
	end,
	leftButtonHold = function()
		-- Your code here
	end,
	leftButtonUp = function()
		-- Your code here
	end,

	-- D-pad right
	--
	rightButtonDown = function()
		-- Your code here
	end,
	rightButtonHold = function()
		-- Your code here
	end,
	rightButtonUp = function()
		-- Your code here
	end,

	-- D-pad up
	--
	upButtonDown = function()
		-- Your code here
	end,
	upButtonHold = function()
		-- Your code here
	end,
	upButtonUp = function()
		-- Your code here
	end,

	-- D-pad down
	--
	downButtonDown = function()
		-- Your code here
	end,
	downButtonHold = function()
		-- Your code here
	end,
	downButtonUp = function()
		-- Your code here
	end,

	-- Crank
	--
	cranked = function(change, acceleratedChange)	-- Runs when the crank is rotated. See Playdate SDK documentation for details.
		-- Your code here
	end,
	crankDocked = function()						-- Runs once when when crank is docked.
		-- Your code here
	end,
	crankUndocked = function()						-- Runs once when when crank is undocked.
		-- Your code here
	end
}