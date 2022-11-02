import 'Pet'
-- Helpful options for development only. Controlled by the global boolean `DEBUG_MODE` in `./main.lua`
function Utilities.enableDevOptions()
	print('~~~ Debug Mode... ACTIVATED!!! ~~~')

	Noble.showFPS = true;

	playdate.getSystemMenu():addOptionsMenuItem(
		'State', 
		PetInstance:getAnimationNames(), 
		function(state)
			PetInstance.animation:setState(state);
		end
	)

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

function Utilities.map(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end