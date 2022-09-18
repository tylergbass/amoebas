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
		type = 'adventurer',
		name = 'Hero',
		status = {
			happiness = 1
		},    
	}
})




if DEBUG_MODE then
	print('~~~ DEBUG MODE ~~~')

	Noble.showFPS = true;

	-- Reset old test save values
	Noble.GameData.set('pet', {
		type = 'adventurer',
		name = 'Hero',
		status = {
			happiness = 1
		},    
	})
end

PetInstance = Pet(Noble.GameData.get('pet'))

Noble.new(ExampleScene, 1.5, Noble.TransitionType.CROSS_DISSOLVE)
