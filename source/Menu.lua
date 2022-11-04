import 'MenuPart'
import 'utilities/Utilities'

Menu = {}

class('Menu', {
	almanac = MenuPart('almanac'),
	clean = MenuPart('clean'),
	feed = MenuPart('feed'),
	know = MenuPart('know'),
	play = MenuPart('play'),
	stuff = MenuPart('stuff'),
	left_pump = MenuPart('left_guy', 100),
	right_pump = MenuPart('right_guy', 100),
}).extends(Object);


-- menu parts in clockwize order
local parts = { 'know', 'feed', 'play', 'almanac', 'clean', 'stuff' }

function Menu:init()
    Menu.super.init();

    -- index of focused part in `parts` array
    self.focused = 1;
end

function Menu:focusNextPart()
    self.focused += 1;
    if (self.focused > #parts) then
        self.focused = 1;        
    end
    self:updateFocus();
end

function Menu:focusPrevPart()
    self.focused -= 1;
    if (self.focused < 1) then
        self.focused = #parts;        
    end
    self:updateFocus();
end

function Menu:focusPartById(id)
    local index = Utilities.getIndex(parts, id)

    if (index == 0) then
        error('MenuPart with id "'.. id .. '" is not found')
    end

    self.focused = index;
    self:updateFocus();
end

function Menu:updateFocus();
    print(parts[self.focused], 'is focused');
end

function Menu:addPartsToScene()
    for i, part in pairs(parts) do --actualcode
		Menu[part]:add()
		Menu[part]:moveTo(Utilities.centerScreen())
	end

    Menu.left_pump:add()
    Menu.right_pump:add()

    Menu.left_pump:moveTo(Utilities.centerScreen())
	Menu.right_pump:moveTo(Utilities.centerScreen())
end
