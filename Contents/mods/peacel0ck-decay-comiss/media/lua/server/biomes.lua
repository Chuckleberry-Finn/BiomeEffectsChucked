------------------------------------------------------------------
---     Special Case Functions - Useful for edge cases.        ---
------------------------------------------------------------------
-- All special case functions must be defined above BIOMES = {} --
--     All special case functions must return true/false.       --
------------------------------------------------------------------

local specialCaseFunctions = {}
specialCaseFunctions.square = {}
specialCaseFunctions.object = {}

---This is a filler function to trigger another check below
---@param object IsoObject
function specialCaseFunctions.object.hasObjectOnTop(object)
    if not object then return end

    if object:isTableSurface() then
        return false
    else
        local ioSquare = object:getSquare()
        if ioSquare then

            for i=object:getObjectIndex()+1, ioSquare:getObjects():size() do
                ---@type IsoObject
                local otherIsoObject = ioSquare:getObjects():get(i)
                if otherIsoObject and (otherIsoObject:isTableTopObject() or otherIsoObject:isTableSurface()) then
                    return true
                end
            end
        end
        return false
    end
end


---@param object IsoObject
function specialCaseFunctions.object.isObjectType(object, var)
    if not object or not var then return end
    return (tostring(object:getType()) == var)
end
-- "normal", "jukebox", "wall", "stairsTW", "stairsTN", "stairsMW", "stairsMN", "stairsBW", "stairsBN", "UNUSED9", "UNUSED10",
-- "doorW", "doorN", "lightswitch", "radio", "curtainN", "curtainS", "curtainW", "curtainE", "doorFrW", "doorFrN", "tree",
-- "windowFN", "windowFW", "UNUSED24", "WestRoofB", "WestRoofM", "WestRoofT", "isMoveAbleObject",

---@param object IsoObject
---@param var string string that can be separated by , for multiple checks, !var = not var, all var cases have to be true to pass
function specialCaseFunctions.object.isIsoFlagType(object, var)
    if not object and not var then return end
    local cases = 0
    local valid = 0

    local ifAnyValid = string.match(var, "@,(.*)")
    if ifAnyValid then
        var = ifAnyValid
    end

    for str in string.gmatch(var, "([^"..",".."]+)") do
        local propertyCont = object:getProperties()
        local notStr = string.match(str, "!(.*)")
        cases = cases+1
        if notStr then
            if not propertyCont:Is(notStr) then
                valid = valid+1
            end
        else
            if propertyCont:Is(str) then
                valid = valid+1
            end
        end
    end

    if ifAnyValid then
        return (valid>0)
    else
        return (cases==valid)
    end
end
--  "collideW", "collideN", "solidfloor", "noStart", "windowW", "windowN", "hidewalls", "exterior", "NoWallLighting",
-- "doorW", "doorN", "transparentW", "transparentN", "WallOverlay", "FloorOverlay", "vegitation", "burning", "burntOut",
-- "unflamable", "cutW", "cutN", "tableN", "tableNW", "tableW", "tableSW", "tableS", "tableSE", "tableE", "tableNE",
--  "halfheight", "HasRainSplashes", "HasRaindrop", "solid", "trans", "pushable", "solidtrans", "invisible", "floorS",
-- "floorE", "shelfS", "shelfE", "alwaysDraw", "ontable", "transparentFloor", "climbSheetW", "climbSheetN", "climbSheetTopN",
-- "climbSheetTopW", "attachtostairs", "sheetCurtains", "waterPiped", "HoppableN", "HoppableW", "bed", "blueprint",
-- "canPathW", "canPathN", "blocksight", "climbSheetE", "climbSheetS", "climbSheetTopE", "climbSheetTopS", "makeWindowInvincible",
-- "water", "canBeCut", "canBeRemoved", "taintedWater", "smoke", "attachedN", "attachedS", "attachedE", "attachedW",
-- "attachedFloor", "attachedSurface", "attachedCeiling", "attachedNW", "ForceAmbient", "WallSE", "WindowN", "WindowW",
-- "FloorHeightOneThird", "FloorHeightTwoThirds", "CantClimb", "diamondFloor", "attachedSE", "TallHoppableW", "WallWTrans",
-- "TallHoppableN", "WallNTrans", "container", "DoorWallW", "DoorWallN", "WallW", "WallN", "WallNW", "SpearOnlyAttackThrough", "forceRender"


---------------------
--- BIOME DEFINES ---
---------------------

local BIOMES = {}

BIOMES["WORLD"] = {---WORLD flags this biome for ALL tiles - don't use this lightly
   areas = { { x1 = 11847, y1 = 6834, x2 = 11920, y2 = 6899, z1 = 0, z2 = 7 }, },

   objectTypes = false,
   --- '@,' at the start of the string denotes "if any valid" rather than "all must be valid".
   flagTypes = "@,solidfloor,WallW,WallN,WallNW,WindowW,WindowN,DoorWallW,DoorWallN,floorS,floorE",

   overlays = {

        ["ALL"] = {---ALL tiles - don't use this lightly
            { name = "other", chance = 100, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"overlay_grime_wall_01_0"}},
            { name = "other", chance = 100, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"overlay_grime_wall_01_1"}},
            { name = "other", chance = 100, specialCases = "isIsoFlagType:WallNW,!exterior", tiles = {"overlay_grime_wall_01_2"}},

            { name = "other", chance = 100, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"overlay_grime_wall_01_4"}},
            { name = "other", chance = 100, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"overlay_grime_wall_01_5"}},
            { name = "other", chance = 100, specialCases = "isIsoFlagType:WallNW,!exterior", tiles = {"overlay_grime_wall_01_6"}},

            { name = "other", chance = 30, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"overlay_grime_wall_01_20"}},
            { name = "other", chance = 30, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"overlay_grime_wall_01_21"}},
            { name = "other", chance = 30, specialCases = "isIsoFlagType:WallNW,!exterior", tiles = {"overlay_grime_wall_01_22"}},

            { name = "other", chance = 100, specialCases = "isIsoFlagType:WindowW,!exterior", tiles = {"overlay_grime_wall_01_8"}},
            { name = "other", chance = 100, specialCases = "isIsoFlagType:WindowN,!exterior", tiles = {"overlay_grime_wall_01_9"}},

            { name = "other", chance = 100, specialCases = "isIsoFlagType:DoorWallW,!exterior", tiles = {"overlay_grime_wall_01_10"}},
            { name = "other", chance = 100, specialCases = "isIsoFlagType:DoorWallN,!exterior", tiles = {"overlay_grime_wall_01_11"}},

            { name = "other", chance = 100, specialCases = "isIsoFlagType:floorS,!exterior", tiles = {"overlay_grime_floor_01_0"}},
            { name = "other", chance = 100, specialCases = "isIsoFlagType:floorE,!exterior", tiles = {"overlay_grime_floor_01_1"}},

            { name = "other", chance = 100, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"pert_walls_decayingwallpaper_0","pert_walls_decayingwallpaper_12","pert_walls_decayingwallpaper_28","pert_walls_decayingwallpaper_30"}},
            { name = "other", chance = 100, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"pert_walls_decayingwallpaper_1","pert_walls_decayingwallpaper_13","pert_walls_decayingwallpaper_29","pert_walls_decayingwallpaper_31"}},
            { name = "other", chance = 100, specialCases = "isIsoFlagType:WallNW,!exterior", tiles = {"pert_walls_decayingwallpaper_2"}},
            { name = "other", chance = 100, specialCases = "isIsoFlagType:WallSE,!exterior", tiles = {"pert_walls_decayingwallpaper_3"}},

            { name = "other", chance = 30, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"pert_walls_decayingwallpaper_4"}},
            { name = "other", chance = 30, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"pert_walls_decayingwallpaper_5"}},

            { name = "other", chance = 30, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"pert_walls_decayingwallpaper_6"}},
            { name = "other", chance = 30, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"pert_walls_decayingwallpaper_7"}},

            { name = "other", chance = 30, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"pert_walls_decayingwallpaper_19"}},
            { name = "other", chance = 30, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"pert_walls_decayingwallpaper_18"}},

            { name = "other", chance = 30, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"pert_walls_decayingwallpaper_20"}},
            { name = "other", chance = 30, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"pert_walls_decayingwallpaper_21"}},

            { name = "other", chance = 20, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"pert_walls_decayingwallpaper_22"}},
            { name = "other", chance = 20, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"pert_walls_decayingwallpaper_23"}},

            { name = "other", chance = 20, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"pert_walls_decayingwallpaper_24"}},
            { name = "other", chance = 20, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"pert_walls_decayingwallpaper_25"}},

            { name = "other", chance = 20, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"pert_walls_decayingwallpaper_26"}},
            { name = "other", chance = 20, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"pert_walls_decayingwallpaper_27"}},

            { name = "other", chance = 20, specialCases = "isIsoFlagType:WallW,!exterior", tiles = {"pert_walls_decayingwallpaper_32"}},
            { name = "other", chance = 20, specialCases = "isIsoFlagType:WallN,!exterior", tiles = {"pert_walls_decayingwallpaper_33"}},

        },

    },
}


local outdoorFloorPlants = { "d_plants_1_28","d_plants_1_60","d_plants_1_29","d_plants_1_36","d_plants_1_37","d_plants_1_25","d_plants_1_18", "d_plants_1_19","d_plants_1_61","d_plants_1_0", "d_plants_1_1", "d_plants_1_4", "d_plants_1_5","d_plants_1_6", "d_plants_1_7", "d_plants_1_8", "d_plants_1_19", "d_plants_1_20", "d_plants_1_34", "d_plants_1_35", "d_plants_1_36", "d_plants_1_37", "d_plants_1_38", "vegetation_farm_01_40","vegetation_farm_01_41","vegetation_farm_01_46", "vegetation_farm_01_43","e_newgrass_1_4", "e_newgrass_1_3", "e_newgrass_1_2","e_newgrass_1_1","e_newgrass_1_0", "e_newgrass_1_46", "e_newgrass_1_45", "e_newgrass_1_7", "e_newgrass_1_6", "e_newgrass_1_5", "e_newgrass_1_40", "e_newgrass_1_41", "e_newgrass_1_42", "e_newgrass_1_43", "e_newgrass_1_44", "e_newgrass_1_47","e_newgrass_1_39", "e_newgrass_1_38", "e_newgrass_1_37", "e_newgrass_1_19", "e_newgrass_1_20","e_newgrass_1_22", "e_newgrass_1_23", "e_newgrass_1_36", "d_plants_1_38","d_plants_1_35", "d_plants_1_39", "d_plants_1_34","d_plants_1_32", "d_plants_1_33", "d_plants_1_55", "d_plants_1_53", "d_plants_1_49", "d_plants_1_51", "d_plants_1_16", "d_plants_1_17", "d_plants_1_20", "d_plants_1_21", "d_plants_1_22","d_plants_1_18", "d_plants_1_19", "d_plants_1_23", "d_plants_1_37", "d_plants_1_36" }
BIOMES["jungle"] = {
    ---Whatever area you choose needs to have a smaller x1/y1/z1 than x2/y2/z2
    areas = { { x1 = 11847, y1 = 6834, x2 = 11920, y2 = 6899, z1 = 0, z2 = 0}, },

    objectTypes = false,
    flagTypes = "solidfloor,!exterior",

    overlays = {
        ["ALL"] = {---ALL tiles - don't use this lightly
                ---Anything other than "other" is a special case for specific roomIDs, giving "other" a specialCase of "isOutside".
                --- Special cases are handled as a string, denoting function names above separated by a semicolon (;).
                { name = "other", chance = 90, specialCases = false, tiles = outdoorFloorPlants},
                --{ name = "roomID", chance = 100, specialCases = "isOutside;hasObjectOnTop", tiles = { "f_wallvines_1_24", "f_wallvines_1_25"}},
        },
    },
}


--------------------------------------------------------------------------------------------------------------
--- Under The Hood Stuff Below, Modders/Mappers should be able to get what they want out of what is above. ---
--------------------------------------------------------------------------------------------------------------

local function applyTiles(overlays, roomID, object)
    local found = {}

    for _,overlay in pairs(overlays) do
        if overlay.name == roomID and (ZombRand(101) <= (overlay.chance)) then

            local specialCaseFailed = false

            if overlay.specialCases then
                for str in string.gmatch(overlay.specialCases, "([^"..";".."]+)") do

                    local funcStr = string.match(str, "(.*):")
                    local additionalVarStr = string.match(str, ":(.*)")

                    local funcSquare = specialCaseFunctions.square[funcStr]
                    if funcSquare then
                        local returnedVal = funcSquare(object:getSquare(), additionalVarStr)
                        if not returnedVal then
                            specialCaseFailed = true
                        end
                    end
                    local funcObject = specialCaseFunctions.object[funcStr]
                    if funcObject then
                        local returnedVal = funcObject(object, additionalVarStr)
                        if not returnedVal then
                            specialCaseFailed = true
                        end
                    end
                end
            end

            if (not specialCaseFailed) then
                local foundTile = overlay.tiles[ZombRand(#overlay.tiles)+1]
                table.insert(found, foundTile)
            end
        end
    end

    return found
end


local function isNilOrWhiteSpace(str)
    if str==nil or string.len(str)==0 or string.match(str,"^%s*$") then
        return true
    end
    return false
end


---@param isoObject IsoObject
local function applySpriteToObject(isoObject, spriteName)
    if (not isNilOrWhiteSpace(spriteName) and (not isServer()) and (getTexture(spriteName) == nil)) then
        spriteName = nil
    end

    if (not isNilOrWhiteSpace(spriteName)) then
        if not isoObject:getAttachedAnimSprite() then
            isoObject:setAttachedAnimSprite(ArrayList.new(4))
        end

        ---@type IsoSprite
        local isoSprite = getSprite(spriteName)
        isoSprite:setName(spriteName)

        ---@type IsoSpriteInstance
        local isoSpriteInstance = IsoSpriteInstance.get(isoSprite)

        --[[
        if (alpha > 0.0) then
            --isoSpriteInstance.tintr = r
            --isoSpriteInstance.tintg = b
            --isoSpriteInstance.tintb = g
            isoSpriteInstance:SetAlpha(alpha)
        end
        --]]

        --isoSpriteInstance.bCopyTargetAlpha = false
        --isoSpriteInstance.bMultiplyObjectAlpha = true

        ---@type ArrayList
        local isoObjectAttachedAnimSprite = isoObject:getAttachedAnimSprite()
        if isoObjectAttachedAnimSprite then
            isoObjectAttachedAnimSprite:add(isoSpriteInstance)
        end
    end
end


---@param isoObject IsoObject
local function applyBiomeOverlaysToObject(isoObject)
    if not isoObject then return end

    ---@type IsoGridSquare
    local isoGridSquare = isoObject:getSquare()
    if isoGridSquare then
        local r = -1.0
        local b = -1.0
        local g = -1.0
        local alpha = -1.0

        if isoObject:getSprite() and isoObject:getSprite():getName() then
            ---use BIOMES rather than TileOverlays as in vanilla
            local biomes = isoGridSquare:getModData()["BIOME"]
            for id,_ in pairs(biomes) do
                local biome = BIOMES[id]
                if (not biome.flagTypes) or (biome.flagTypes and specialCaseFunctions.object.isIsoFlagType(isoObject, biome.flagTypes)) then
                    ---custom tileOverlay, not vanilla object
                    local tileOverlay = biome.overlays[isoObject:getSprite():getName()] or biome.overlays["ALL"]

                    if tileOverlay then

                        local roomID = "other"
                        if (isoGridSquare:getRoom() ~= nil) then
                            roomID = isoGridSquare:getRoom():getName()
                        end

                        local tileOverlaysFound = applyTiles(tileOverlay, roomID, isoObject)
                        if tileOverlaysFound then
                            for k,spriteName in pairs(tileOverlaysFound) do
                                applySpriteToObject(isoObject, spriteName)--, alpha)
                            end
                        end
                    end
                end
            end
        end
    end
end


---@param isoGridSquare IsoGridSquare
local function applyBiomeToGridSquare(isoGridSquare)

    local isoObjects = isoGridSquare:getObjects()
    local numOfObjects = isoObjects:size()

    if isoObjects and numOfObjects>0 then
        for i=0, numOfObjects-1 do
            ---@type IsoObject
            local isoObj = isoObjects:get(i)
            if isoObj and (not instanceof(isoObj, "IsoWorldInventoryObject")) then
                if isoObj:getSprite() and isoObj:getSprite():getName() and (not getContainerOverlays():hasOverlays(isoObj)) then
                    applyBiomeOverlaysToObject(isoObj)
                end
            end
        end
    end
end


---@param square IsoGridSquare
local function parseBiomesOnSquare(square)
    local mData = square:getModData()
    local biomeID = mData["BIOME"]
    if biomeID then return end

    local x, y, z = square:getX(), square:getY(), square:getZ()

    for id, data in pairs(BIOMES) do
        if data.areas then
            for _,areaPoints in pairs(data.areas) do
                if x>=areaPoints.x1 and x<= areaPoints.x2 and y>=areaPoints.y1 and y<=areaPoints.y2 and z>=areaPoints.z1 and z<=areaPoints.z2 then
                    mData["BIOME"] = mData["BIOME"] or {}
                    mData["BIOME"][id] = true
                end
            end
        else
            mData["BIOME"] = mData["BIOME"] or {}
            mData["BIOME"][id] = true
        end
    end

    if mData["BIOME"] then
        applyBiomeToGridSquare(square)
    end
end
Events.LoadGridsquare.Add(parseBiomesOnSquare)