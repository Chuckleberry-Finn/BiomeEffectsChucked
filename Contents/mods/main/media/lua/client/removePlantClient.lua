require "ISUI/ISWorldObjectContextMenu"
require "TimedActions/ISRemoveBush"
require "TimedActions/ISRemoveGrass"
require "luautils"

local function predicateCutPlant(item)
    return not item:isBroken() and item:hasTag("CutPlant")
end

local ISRemoveBush_getBushObject = ISRemoveBush.getBushObject
function ISRemoveBush:getBushObject(square)
    if not square then return nil end

    local vanillaPass = ISRemoveBush_getBushObject(self, square)
    if not vanillaPass then
        for i=0,square:getObjects():size()-1 do
            local object = square:getObjects():get(i)
            local attached = object:getAttachedAnimSprite()
            if attached then
                for n=0,attached:size()-1 do
                    local sprite = attached:get(n)
                    local parentSprite = sprite:getParentSprite()
                    if parentSprite and parentSprite:getProperties():Is(IsoFlagType.canBeCut) then
                        return object, n
                    end
                end
            end
        end
    else
        return vanillaPass
    end
    return nil
end


local ISRemoveGrass_isValid = ISRemoveGrass.isValid
function ISRemoveGrass:isValid()
    local vanillaPass = ISRemoveGrass_isValid(self)
    if not vanillaPass then
        for i=0,self.square:getObjects():size()-1 do
            local object = self.square:getObjects():get(i)
            local attached = object:getAttachedAnimSprite()
            if attached then
                for n=0,attached:size()-1 do
                    local sprite = attached:get(n)
                    local parentSprite = sprite:getParentSprite()
                    if parentSprite and parentSprite:getProperties():Is(IsoFlagType.canBeRemoved)
                        and (not luautils.stringStarts(parentSprite:getName(), "f_wallvines_")) then
                        return true
                    end
                end
            end
        end
    else
        return vanillaPass
    end
    return false
end


local ISRemoveBush_perform = ISRemoveBush.perform
function ISRemoveBush:perform()
    local sq = self.square
    local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ() }
    sendClientCommand(self.character, "onRemovePlant", "canBeCut", args)
    ISRemoveBush_perform(self)
end


local ISRemoveGrass_perform = ISRemoveGrass.perform
function ISRemoveGrass:perform()
    local sq = self.square
    local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ() }
    sendClientCommand(self.character, "onRemovePlant", "canBeRemoved", args)
    ISRemoveGrass_perform(self)
end


local function addSpriteSensitiveContexts(player, context, worldobjects)
    local playerObj = getSpecificPlayer(player)
    local inventory = playerObj:getInventory()
    local square

    local canBeCut
    local canBeRemoved

    if playerObj:getVehicle() then return end

    for _,v in ipairs(worldobjects) do
        square = v:getSquare()
    end

    if not square then return end

    for i=0,square:getObjects():size()-1 do
        local object = square:getObjects():get(i)
        if object then

            local attached = object:getAttachedAnimSprite()
            local hasCuttingTool = inventory:containsEvalRecurse(predicateCutPlant)

            if attached then
                for n=1,attached:size() do
                    local sprite = attached:get(n-1)
                    local parentSprite = sprite:getParentSprite()

                    if parentSprite and parentSprite:getProperties()
                            and parentSprite:getProperties():Is(IsoFlagType.canBeCut) and hasCuttingTool then
                        canBeCut = sprite
                    end

                    if parentSprite and parentSprite:getProperties()
                            and parentSprite:getProperties():Is(IsoFlagType.canBeRemoved)
                            and (not luautils.stringStarts(parentSprite:getName(), "f_wallvines_")) then
                        canBeRemoved = sprite
                    end
                end
            end
        end
    end

    if canBeCut then
        context:addOption(getText("ContextMenu_RemoveBush"), worldobjects, ISWorldObjectContextMenu.onRemovePlant, canBeCut, false, player)
    end
    if canBeRemoved then
        context:addOption(getText("ContextMenu_RemoveGrass"), worldobjects, ISWorldObjectContextMenu.onRemoveGrass, canBeRemoved, player)
    end
end

Events.OnFillWorldObjectContextMenu.Add(addSpriteSensitiveContexts)