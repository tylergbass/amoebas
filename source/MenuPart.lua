import 'utilities/Utilities'

MenuPart = {}

class('MenuPart').extends(NobleSprite) 

function MenuPart:init(id, zIndex)
    self.id = id;

    if (self.id == nil) then
        error('MenuPart needs the name of the part as a constructor arg')
    end

    MenuPart.super.init(
        self, 
        "assets/images/menu/" .. self.id
    )

    if (zIndex ~= nil) then
        self:setZIndex(zIndex);
    end
    
    self:setSize(400, 240);

    -- TODO: add the correct position/dimensions for each menu part's collideRect
    -- self:setCollideRect( 0, 0, 50, 50 );
end

function MenuPart:draw(__x, __y)
    MenuPart.super.draw(
        self,
        __x or self.x,
        __y or self.y
    )
end

function MenuPart:handleCursorClickDown()
    MenuInstance:focusPartById(self.id);
end
