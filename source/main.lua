import 'libraries/noble/Noble'
import 'scenes/ExampleScene'
import 'scenes/ExampleScene2'
import 'scenes/BaseScene'
import 'Pet'

DEBUG_MODE = true;

-- Noble.Settings.setup({
-- 	Difficulty = "Medium"
-- })

Noble.GameData.setup({
	pet = {
		type = 'ducky',
		name = 'Quackerton the 5th',
		status = {
			happiness = 1
		},    
	}
})


if DEBUG_MODE then
	Noble.showFPS = true
end

PetInstance = Pet(Noble.GameData.get('pet'))

Noble.new(ExampleScene, 1.5, Noble.TransitionType.CROSS_DISSOLVE)
