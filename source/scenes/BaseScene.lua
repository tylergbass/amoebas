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
	PetInstance:add()
	PetInstance:moveTo((playdate.display.getWidth()/2) - (92/2), (playdate.display.getHeight()/2) - (101/2));	
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

BaseScene.inputHandler = {}