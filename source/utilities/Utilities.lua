import 'Pet'
-- Helpful options for development only. Controlled by the global boolean `DEBUG_MODE` in `./main.lua`
function Utilities.enableDevOptions()
	print('~~~ Debug Mode... ACTIVATED!!! ~~~')

	Noble.showFPS = true; --FPS counter

	playdate.getSystemMenu():addOptionsMenuItem( -- built in function to add menu option
		'State', --name of menu option
		PetInstance:getAnimationNames(), -- returns array of names
		function(state) -- last parameter supplies a function to run when button is pressed
			PetInstance.animation:setState(state); 
		end
	)

	playdate.getSystemMenu():addOptionsMenuItem(
		'Pet',
		{ 'microbe1', 'vibrio', 'babyAmoeba' }, -- this is what an array looks like
		function(state) -- state is a declared variable representing button value  
			Noble.GameData.set('pet', { 
				type = state -- set pet field in save data to have a type of state
			})
		end
	)

	-- Uncomment to reset save values
	-- Noble.GameData.set('pet', {
	-- 	type = 'babyAmoeba',
	-- 	status = {
	-- 		happiness = 1
	-- 	},    
	-- })
end

-- returns slope as an array
function Utilities.slope(x1, y1, x2, y2)
	local rise = y2 - y1;
	local run = x2 - x1;
	return { rise, run }
end

-- returns center screen coordinates
function Utilities.centerScreen()
	return (playdate.display.getWidth()/2), (playdate.display.getHeight()/2)
end

-- array map function 
function Utilities.map(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

-- searches for first occurrence of item in list and returns index (lua is 1-indexed)
function Utilities.getIndex(list, x)
	for idx, v in pairs(list) do
		if v == x then return idx end
	end
	return 0
end