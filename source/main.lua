import 'libraries/noble/Noble'
import 'scenes/BaseScene'
import 'Pet'
import 'Cursor'
import 'Menu'
import 'utilities/Utilities'

-- TODO
Noble.Settings.setup({
	Difficulty = "Medium" --does not do anything
})

-- TODO not all of these are used
Noble.GameData.setup({
	pet = {
		type = 'babyAmoeba',
		name = 'Hero',
		status = {
			happiness = 1, 
			hunger = 0,
			age = 0
		},    
	}
})

--singletons
CursorInstance = Cursor();
PetInstance = Pet(Noble.GameData.get('pet'));
MenuInstance = Menu();

DEBUG_MODE = true;
if DEBUG_MODE then
	Utilities.enableDevOptions();
end

Noble.new(BaseScene, 1.5, Noble.TransitionType.CROSS_DISSOLVE)
