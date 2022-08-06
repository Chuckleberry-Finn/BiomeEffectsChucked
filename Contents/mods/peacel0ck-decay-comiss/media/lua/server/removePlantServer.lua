require = "BuildingObjects/ISRemovePlantCursor"

local ISRemovePlantCursor_getRemovableObject = ISRemovePlantCursor.getRemovableObject
function ISRemovePlantCursor:getRemovableObject(square)
    local vanillaPass = ISRemovePlantCursor_getRemovableObject(self, square)
    if not vanillaPass and self.removeType ~= "wallVine" then
        for i=1,square:getObjects():size() do
            local object = square:getObjects():get(i-1)

            local attached = object:getAttachedAnimSprite()

            if attached then
                for n=0,attached:size()-1 do
                    local sprite = attached:get(n)
                    local parentSprite = sprite:getParentSprite()

                    if self.removeType == "bush" and parentSprite and parentSprite:getProperties()
                            and parentSprite:getProperties():Is(IsoFlagType.canBeCut) then
                        return object
                    end

                    if self.removeType == "grass" and parentSprite and parentSprite:getProperties()
                            and parentSprite:getProperties():Is(IsoFlagType.canBeRemoved)
                            and (not luautils.stringStarts(parentSprite:getName(), "f_wallvines_")) then
                        return object
                    end
                end
            end
        end
    else
        return vanillaPass
    end
    return nil
end


local function onRemovePlantCommand(module, command, player, args)
    if module == "onRemovePlant" then

        if not IsoFlagType[command] then return end

        local sq = getCell():getGridSquare(args.x, args.y, args.z)
        if not sq then return end

        for i=0,sq:getObjects():size()-1 do
            local object = sq:getObjects():get(i)

            if object then
                local attached = object:getAttachedAnimSprite()
                if attached then
                    for n = attached:size()-1, 0, -1 do
                        local sprite = attached:get(n)
                        local parentSprite = sprite:getParentSprite()

                        if parentSprite and parentSprite:getProperties()
                                and parentSprite:getProperties():Is(IsoFlagType[command])
                                and (not luautils.stringStarts(parentSprite:getName(), "f_wallvines_")) then
                            object:RemoveAttachedAnim(n)
                            object:transmitUpdatedSpriteToClients()
                        end
                    end
                end
            end
        end
    end
end
Events.OnClientCommand.Add(onRemovePlantCommand)