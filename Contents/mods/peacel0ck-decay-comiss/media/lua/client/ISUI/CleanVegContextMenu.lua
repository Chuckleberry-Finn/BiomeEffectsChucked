--[[
require('luautils');

local function predicateNotBroken(item)
    return not item:isBroken()
end

local function onCleanVegMenu(worldobjects, square, player)
    local bo = CleanVegCursor:new("", "", player)
    getCell():setDrag(bo, player:getPlayerNum())
end

local function addCleanVegMenu(player, context, worldobjects)
    local player = getSpecificPlayer(player);
    local inventory = player:getInventory();
    local square;
    local target;

    if player:getVehicle() then return end

    for i,v in ipairs(worldobjects) do
        square = v:getSquare();
    end

    if not square then return end

    for i=0,square:getObjects():size()-1 do
        local object = square:getObjects():get(i);

        if object then
            if object:getTextureName() and luautils.stringStarts(object:getTextureName(), "blends_grassoverlays") then
                target = object;
            else
                local attached = object:getAttachedAnimSprite()
                if attached then
                    for n=1,attached:size() do
                        local sprite = attached:get(n-1)
                        if sprite and sprite:getParentSprite() and sprite:getParentSprite():getName() and
                         luautils.stringStarts(sprite:getParentSprite():getName(), "blends_grassoverlays")
                        or luautils.stringStarts(sprite:getParentSprite():getName(), "d_plants")
                        or luautils.stringStarts(sprite:getParentSprite():getName(), "d_generic")
                        or luautils.stringStarts(sprite:getParentSprite():getName(), "f_wallvines")
                        or luautils.stringStarts(sprite:getParentSprite():getName(), "blends_natural")
                        or luautils.stringStarts(sprite:getParentSprite():getName(), "e_newgrass")
                        or luautils.stringStarts(sprite:getParentSprite():getName(), "vegetation_farm") then
                            target = sprite
                            break;
                        end
                    end
                end
            end
        end
    end

    if not target then return end


    context:addOption(getText('UI_REMOVE_VEG'), worldobjects, onCleanVegMenu, square, player);
end

-- ------------------------------------------------
-- Game hooks
-- ------------------------------------------------
Events.OnFillWorldObjectContextMenu.Add(addCleanVegMenu);

--]]