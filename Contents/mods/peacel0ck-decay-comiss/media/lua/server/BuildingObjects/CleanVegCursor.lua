--[[
CleanVegCursor = ISBuildingObject:derive("CleanVegCursor")

local function doCleanVegMenu(player, square)
    local inventory = player:getInventory()
    if luautils.walkAdj(player, square, true) then
        ISTimedActionQueue.add(CleanVegAction:new(player, square, 150));
    end
end

function CleanVegCursor:create(x, y, z, north, sprite)
    local square = getWorld():getCell():getGridSquare(x, y, z)
    doCleanVegMenu(self.character, square)
end

function CleanVegCursor:isValid(square)
    local inventory = self.character:getInventory()

    for i=0,square:getObjects():size()-1 do
        local object = square:getObjects():get(i);

        if object then
            if object:getTextureName() and luautils.stringStarts(object:getTextureName(), "blends_grassoverlays") then

            else
                local attached = object:getAttachedAnimSprite()
                if attached then
                    for n=1,attached:size() do
                        local sprite = attached:get(n-1)
                        if sprite and sprite:getParentSprite() and sprite:getParentSprite():getName() and
                                (luautils.stringStarts(sprite:getParentSprite():getName(), "blends_grassoverlays")
                                or luautils.stringStarts(sprite:getParentSprite():getName(), "d_plants")
                                or luautils.stringStarts(sprite:getParentSprite():getName(), "f_wallvines")
                                or luautils.stringStarts(sprite:getParentSprite():getName(), "d_generic")
                                or luautils.stringStarts(sprite:getParentSprite():getName(), "blends_natural")
                                or luautils.stringStarts(sprite:getParentSprite():getName(), "e_newgrass")
                                or luautils.stringStarts(sprite:getParentSprite():getName(), "vegetation_farm")) then
                            return true
                        end
                    end
                end
            end
        end
    end

    return false
end

function CleanVegCursor:render(x, y, z, square)
    if not CleanVegCursor.floorSprite then
        CleanVegCursor.floorSprite = IsoSprite.new()
        CleanVegCursor.floorSprite:LoadFramesNoDirPageSimple('media/ui/FloorTileCursor.png')
    end
    local r,g,b,a = 0.0,1.0,0.0,0.8
    if self:isValid(square) == false then
        r = 1.0
        g = 0.0
    end
    CleanVegCursor.floorSprite:RenderGhostTileColor(x, y, z, r, g, b, a)
end

function CleanVegCursor:new(sprite, northSprite, character)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o:init()
    o:setSprite(sprite)
    o:setNorthSprite(northSprite)
    o.character = character
    o.player = character:getPlayerNum()
    o.noNeedHammer = true
    o.skipBuildAction = true
    return o
end
--]]