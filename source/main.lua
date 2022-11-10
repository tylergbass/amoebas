import 'libraries/noble/Noble'
import 'scenes/BaseScene'
import 'Pet'
import 'Cursor'
import 'Menu'
import 'utilities/Utilities'

-- TODO
Noble.Settings.setup({
	Difficulty = "Medium"
})

-- TODO
Noble.GameData.setup({
	pet = {
		type = 'babyAmoeba',
		name = 'Hero',
		status = {
			happiness = 1
		},    
	}
})

CursorInstance = Cursor();
PetInstance = Pet(Noble.GameData.get('pet'))
MenuInstance = Menu();

DEBUG_MODE = true;
if DEBUG_MODE then
	Utilities.enableDevOptions();
end

Noble.new(BaseScene, 1.5, Noble.TransitionType.CROSS_DISSOLVE)
