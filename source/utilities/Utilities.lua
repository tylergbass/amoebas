
-- Helpful options for development only. Controlled by the global boolean `DEBUG_MODE` in `./main.lua`
function Utilities.enableDevOptions()
	print('~~~ Debug Mode... ACTIVATED!!! ~~~')

	Noble.showFPS = true;

	playdate.getSystemMenu():addOptionsMenuItem(
		'State', 
		{
			'idle',
			'disturbed',
			'dizzy',
			'eating',
			'excited',
			'needy',
			'sad',
			'sleeping',
			'tired',
			'walking'
		}, 
		function(state)
			PetInstance.animation:setState(state);
		end
	)

	-- Reset old test save values
	Noble.GameData.set('pet', {
		type = 'microbe1',
		name = 'Hero',
		status = {
			happiness = 1
		},    
	})
end

function Utilities.slope(x1, y1, x2, y2)
	local rise = y2 - y1;
	local run = x2 - x1;
	return { rise, run }
end

function Utilities.centerScreen()
	return (playdate.display.getWidth()/2), (playdate.display.getHeight()/2)
end
