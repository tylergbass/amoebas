import 'Pet'
-- Helpful options for development only. Controlled by the global boolean `DEBUG_MODE` in `./main.lua`
function Utilities.enableDevOptions()
	print('~~~ Debug Mode... ACTIVATED!!! ~~~')

	Noble.showFPS = true;

	-- set current pet animation state
	playdate.getSystemMenu():addOptionsMenuItem(
		'State', 
		PetInstance:getAnimationNames(), 
		function(state)
			PetInstance.animation:setState(state);
		end
	)

	-- set current pet, requires game restart
	playdate.getSystemMenu():addOptionsMenuItem(
		'Pet', 
		{ 'microbe1', 'vibrio', 'babyAmoeba' }, 
		function(state)
			Noble.GameData.set('pet', {
				type = state
			})
		end
	)

	-- Reset old test save values
	-- Noble.GameData.set('pet', {
	-- 	type = 'babyAmoeba',
	-- 	status = {
	-- 		happiness = 1
	-- 	},    
	-- })
end

function Utilities.slope(x1, y1, x2, y2)
	local rise = y2 - y1;
	local run = x2 - x1;
	return { rise, run }
end

function Utilities.centerScreen()
	return (playdate.display.getWidth()/2), (playdate.display.getHeight()/2)
end

-- functional map: for each item in `tbl`, apply the transform `f`. Returns the new table
function Utilities.map(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end

-- get the index of an item in a list; if not found return 0
function Utilities.getIndex(list, x)
	for idx, v in pairs(list) do
		if v == x then return idx end
	end
	return 0
end

