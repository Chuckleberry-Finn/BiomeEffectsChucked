--[[
require('luautils');

local function onCleanVegCommand(module, command, player, args)
    if module == 'CleanVeg' then
        if command == 'CleanVegCommand' then
            local sq = getCell():getGridSquare(args.x, args.y, args.z)

            if not sq then return end

            for i=0,sq:getObjects():size()-1 do
                local object = sq:getObjects():get(i);

                if object then
                    if object:getTextureName() and luautils.stringStarts(object:getTextureName(), "blends_grassoverlays") then
                        sq:RemoveTileObject(object);
                    else
                        local attached = object:getAttachedAnimSprite()
                        if attached then
                            for n = attached:size(), 1, -1 do
                                local sprite = attached:get(n-1)
                                if sprite and sprite:getParentSprite() and sprite:getParentSprite():getName() and luautils.stringStarts(sprite:getParentSprite():getName(), "blends_grassoverlays")
                                        or luautils.stringStarts(sprite:getParentSprite():getName(), "d_plants")
                                        or luautils.stringStarts(sprite:getParentSprite():getName(), "d_generic")
                                        or luautils.stringStarts(sprite:getParentSprite():getName(), "f_wallvines")
                                        or luautils.stringStarts(sprite:getParentSprite():getName(), "blends_natural")
                                        or luautils.stringStarts(sprite:getParentSprite():getName(), "e_newgrass")
                                        or luautils.stringStarts(sprite:getParentSprite():getName(), "vegetation_farm") then
                                    object:RemoveAttachedAnim(n-1)
                                    object:transmitUpdatedSpriteToClients()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

Events.OnClientCommand.Add(onCleanVegCommand)
--]]