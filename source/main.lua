import 'libraries/noble/Noble'
import 'scenes/ExampleScene'
import 'scenes/ExampleScene2'
import 'scenes/BaseScene'
import 'Pet'
import 'Cursor'
import 'utilities/Utilities'

-- TODO
Noble.Settings.setup({
	Difficulty = "Medium"
})

-- TODO
Noble.GameData.setup({
	pet = {
		type = 'adventurer',
		name = 'Hero',
		status = {
			happiness = 1
		},    
	}
})

DEBUG_MODE = true;
if DEBUG_MODE then
	Utilities.enableDevOptions();
end

CursorInstance = Cursor();
PetInstance = Pet(Noble.GameData.get('pet'))

Noble.new(ExampleScene, 1.5, Noble.TransitionType.CROSS_DISSOLVE)
