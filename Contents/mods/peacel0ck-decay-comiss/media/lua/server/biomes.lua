local BIOMES = {}

BIOMES["grime"] = {

    areas = { { x1 = 1, y1 = 1, x2 = 99999, y2 = 99999, z1 = 0, z2 = 7}, },
    chance = 100,

    --solidfloor = { inside = {}, outside = {}, },

    WallW = {"overlay_grime_wall_01_0"},
    WallN = {"overlay_grime_wall_01_1"},
    WallNW = {"overlay_grime_wall_01_2"},
    WallSE = {"overlay_grime_wall_01_3"},
    DoorWallW = {"overlay_grime_wall_01_10"},
    DoorWallN = {"overlay_grime_wall_01_11"},
    WindowW = {"overlay_grime_wall_01_8"},
    WindowN = {"overlay_grime_wall_01_9"},
}


BIOMES["desert"] = {
    areas = false,--{ { x1 = 1, y1 = 1, x2 = 99999, y2 = 99999, z1 = 0, z2 = 7}, },
    chance = 90,

    --solidfloor = { inside = {}, outside = {}, },

    WallW = {"f_wallvines_1_0","f_wallvines_1_1","f_wallvines_1_6","f_wallvines_1_7",
             "f_wallvines_1_12","f_wallvines_1_13","f_wallvines_1_18","f_wallvines_1_19"},

    WallN = {"f_wallvines_1_2","f_wallvines_1_3","f_wallvines_1_8","f_wallvines_1_9",
             "f_wallvines_1_14","f_wallvines_1_15","f_wallvines_1_20","f_wallvines_1_21"},

    WallNW = {"f_wallvines_1_4","f_wallvines_1_5","f_wallvines_1_10","f_wallvines_1_11",
              "f_wallvines_1_16","f_wallvines_1_17","f_wallvines_1_22","f_wallvines_1_23"},
}
BIOMES["desert"].DoorWallW = BIOMES["desert"].WallW
BIOMES["desert"].DoorWallN = BIOMES["desert"].WallN
BIOMES["desert"].WindowW = BIOMES["desert"].WallW
BIOMES["desert"].WindowN = BIOMES["desert"].WallN


BIOMES["jungle"] = {
    ---Whatever area you choose needs to have a smaller x1/y1/z1 than x2/y2/z2
    areas = { { x1 = 1, y1 = 1, x2 = 99999, y2 = 99999, z1 = 0, z2 = 3}, },
    chance = 90,

    solidfloor = {

        inside = { --[[
            "vegetation_farm_01_40","vegetation_farm_01_41", "vegetation_farm_01_46", "vegetation_farm_01_43",
            "e_newgrass_1_18", "e_newgrass_1_20", "e_newgrass_1_22", "e_newgrass_1_23",
            "e_newgrass_1_24", "e_newgrass_1_27", "e_newgrass_1_28", "e_newgrass_1_50", "e_newgrass_1_52",
            "e_newgrass_1_28", "e_newgrass_1_4", "e_newgrass_1_3", "e_newgrass_1_83", "blends_grassoverlays_01_53",
            "blends_grassoverlays_01_52", "blends_grassoverlays_01_51", "blends_grassoverlays_01_49",
            "blends_grassoverlays_01_48", "blends_grassoverlays_01_24", "blends_grassoverlays_01_25",
            "blends_grassoverlays_01_26", "blends_grassoverlays_01_27", "blends_grassoverlays_01_28",
            "blends_grassoverlays_01_29", "blends_grassoverlays_01_5", "blends_grassoverlays_01_4",
            "blends_grassoverlays_01_3", "blends_grassoverlays_01_2", "blends_grassoverlays_01_1",
            "blends_grassoverlays_01_0", "blends_grassoverlays_01_32", "blends_grassoverlays_01_33",
            "blends_grassoverlays_01_34", "blends_grassoverlays_01_35", "blends_grassoverlays_01_36",
            "blends_grassoverlays_01_37", "blends_grassoverlays_01_16", "blends_grassoverlays_01_17",
            "blends_grassoverlays_01_19", "blends_grassoverlays_01_18", "d_plants_1_0", "d_plants_1_1",
            "d_plants_1_2", "d_plants_1_3", "d_plants_1_4", "d_plants_1_5", "d_plants_1_6", "d_plants_1_7",
            "d_plants_1_8", "d_plants_1_9", "d_plants_1_10", "d_plants_1_11", "d_plants_1_12", "d_plants_1_13",
            "d_plants_1_14", "d_plants_1_15", "d_plants_1_16", "d_plants_1_17", "d_plants_1_18", "d_plants_1_19",
            "d_plants_1_20", "d_plants_1_21", "d_plants_1_22", "d_plants_1_23", "d_plants_1_25", "d_plants_1_26",
            "d_plants_1_28", "d_plants_1_29", "d_plants_1_32", "d_plants_1_33", "d_plants_1_34", "d_plants_1_35",
            "d_plants_1_36", "d_plants_1_37", "d_plants_1_38", "d_plants_1_39", "d_plants_1_48", "d_plants_1_49",
            "d_plants_1_50", "d_plants_1_51", "d_plants_1_52", "d_plants_1_53", "d_plants_1_54", "d_plants_1_55 ",
            "d_generic_1_20", "d_generic_1_80", "d_generic_1_81", "d_generic_1_14", "d_generic_1_24", "d_generic_1_22",
            "d_generic_1_86", "d_generic_1_51", "d_generic_1_82"
       --]] },

        outside = { "d_plants_1_28", "d_plants_1_60", "d_plants_1_29", "d_plants_1_36", "d_plants_1_37", "d_plants_1_25",
                    "d_plants_1_18", "d_plants_1_19", "d_plants_1_61", "d_plants_1_0", "d_plants_1_1", "d_plants_1_4",
                    "d_plants_1_5", "d_plants_1_6", "d_plants_1_7", "d_plants_1_8", "d_plants_1_19", "d_plants_1_20",
                    "d_plants_1_34", "d_plants_1_35", "d_plants_1_36", "d_plants_1_37", "d_plants_1_38",
                     "vegetation_farm_01_40", "vegetation_farm_01_41", "vegetation_farm_01_46", "vegetation_farm_01_43",
                     "e_newgrass_1_4", "e_newgrass_1_3", "e_newgrass_1_2", "e_newgrass_1_1", "e_newgrass_1_0", "e_newgrass_1_46",
                     "e_newgrass_1_45", "e_newgrass_1_7", "e_newgrass_1_6", "e_newgrass_1_5", "e_newgrass_1_40",
                     "e_newgrass_1_41", "e_newgrass_1_42", "e_newgrass_1_43", "e_newgrass_1_44", "e_newgrass_1_47",
                     "e_newgrass_1_39", "e_newgrass_1_38", "e_newgrass_1_37", "e_newgrass_1_19", "e_newgrass_1_20",
                     "e_newgrass_1_22", "e_newgrass_1_23", "e_newgrass_1_36", "d_plants_1_38", "d_plants_1_35", "d_plants_1_39",
                     "d_plants_1_34", "d_plants_1_32", "d_plants_1_33", "d_plants_1_55", "d_plants_1_53", "d_plants_1_49",
                     "d_plants_1_51", "d_plants_1_16", "d_plants_1_17", "d_plants_1_20", "d_plants_1_21", "d_plants_1_22",
                     "d_plants_1_18", "d_plants_1_19", "d_plants_1_23", "d_plants_1_37", "d_plants_1_36" },
    },

    WallW = {"f_wallvines_1_43","f_wallvines_1_42","f_wallvines_1_37","f_wallvines_1_36",
             "f_wallvines_1_31","f_wallvines_1_30","f_wallvines_1_25","f_wallvines_1_24"},

    WallN = {"f_wallvines_1_45","f_wallvines_1_44","f_wallvines_1_39","f_wallvines_1_38",
             "f_wallvines_1_33","f_wallvines_1_32","f_wallvines_1_27","f_wallvines_1_26"},

    WallNW = {"f_wallvines_1_47","f_wallvines_1_46","f_wallvines_1_41","f_wallvines_1_40",
             "f_wallvines_1_34","f_wallvines_1_35","f_wallvines_1_29","f_wallvines_1_28"},

}
BIOMES["jungle"].DoorWallW = BIOMES["jungle"].WallW
BIOMES["jungle"].DoorWallN = BIOMES["jungle"].WallN
BIOMES["jungle"].WindowW = BIOMES["jungle"].WallW
BIOMES["jungle"].WindowN = BIOMES["jungle"].WallN


--ObjectTypes
-- "normal", "jukebox", "wall", "stairsTW", "stairsTN", "stairsMW", "stairsMN", "stairsBW", "stairsBN", "UNUSED9", "UNUSED10",
-- "doorW", "doorN", "lightswitch", "radio", "curtainN", "curtainS", "curtainW", "curtainE", "doorFrW", "doorFrN", "tree",
-- "windowFN", "windowFW", "UNUSED24", "WestRoofB", "WestRoofM", "WestRoofT", "isMoveAbleObject",

--FlagTypes
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

local specialOverrideExceptions = {"IsoCurtain","IsoDoor","IsoWindow","IsoBarricade","IsoLightSwitch"}
---Vanilla has a getFloor but it causes layering issues if there's objects over the floor - like walls
---@param isoGridSquare IsoGridSquare
local function ifFlagTypeGetObject(isoGridSquare, isoFlagType)
    local isoObjects = isoGridSquare:getObjects()

    local objWithFlagFound
    local lastSpriteObject

    if isoFlagType == IsoFlagType.solidfloor and isoGridSquare:getProperties():Is("BlocksPlacement") then return end

    for i=0, isoObjects:size()-1 do
        ---@type IsoObject
        local isoObj = isoObjects:get(i)
        if isoObj then
            local isoObjSprite = isoObj:getSprite()
            local isoObjSpriteName = isoObjSprite:getName()
            if isoObjSprite and isoObjSpriteName then
                if isoObj:getType()==IsoObjectType.wall and string.find(isoObjSpriteName, "roofs") then
                else
                    if isoObjSprite:getProperties():Is(isoFlagType) then
                        objWithFlagFound = true
                        lastSpriteObject = i
                    end

                    if objWithFlagFound then
                        if (not isoGridSquare:getProperties():Is("IsMoveAble")) then
                            lastSpriteObject = i
                        end
                        for _,type in pairs(specialOverrideExceptions) do
                            if instanceof(isoObj, type) then
                                lastSpriteObject = i
                            end
                        end
                    end
                end
            end
        end
    end
    if objWithFlagFound and lastSpriteObject then
        return isoObjects:get(lastSpriteObject)
    end
end


local function applySpriteToObject(sprite, isoObject)

    if not isoObject:getAttachedAnimSprite() then
        isoObject:setAttachedAnimSprite(ArrayList.new(4))
    end

    ---@type IsoSprite
    local isoSprite = getSprite(sprite)
    isoSprite:setName(sprite)

    ---@type IsoSpriteInstance
    local isoSpriteInstance = IsoSpriteInstance.get(isoSprite)

    ---@type ArrayList
    local isoObjectAttachedAnimSprite = isoObject:getAttachedAnimSprite()
    if isoObjectAttachedAnimSprite then
        isoObjectAttachedAnimSprite:add(isoSpriteInstance)
    end
end


local function grabRandom(list)
    if #list==0 then return end
    if #list==1 then return list[1] end
    return list[ZombRand(#list)+1]
end


---@param isoGridSquare IsoGridSquare
local function applyBiome(isoGridSquare, x, y, z, outside)
    local biomes = isoGridSquare:getModData()["BIOME"]
    for id,_ in pairs(biomes) do
        local biome = BIOMES[id]
        if (ZombRand(101) <= biome.chance) then

            for flag,sprites in pairs(biome) do
                if IsoFlagType[flag] then

                    local object = ifFlagTypeGetObject(isoGridSquare, IsoFlagType[flag])
                    if object then

                        local spritesToUse
                        if (sprites.inside or sprites.outside) then
                            if outside and sprites.outside then
                                spritesToUse = sprites.outside
                            elseif (not outside) and sprites.inside then
                                spritesToUse = sprites.inside
                            end
                        else
                            spritesToUse = sprites
                        end

                        if spritesToUse then
                            local randTile = grabRandom(spritesToUse)
                            if randTile then
                                applySpriteToObject(randTile, object)
                            end
                        end
                    end
                end
            end
        end
    end
end


---@param square IsoGridSquare
local function parseBiomesOnSquare(square)
    if not square then return end

    local outside = square:isOutside()
    local x, y, z = square:getX(), square:getY(), square:getZ()
    local mData = square:getModData()
    local biomeID = mData["BIOME"]
    if biomeID then return end

    for id, data in pairs(BIOMES) do
        if data.areas then
            for _,areaPoints in pairs(data.areas) do
                if x>=areaPoints.x1 and x<= areaPoints.x2 and y>=areaPoints.y1 and y<=areaPoints.y2 and z>=areaPoints.z1 and z<=areaPoints.z2 then
                    mData["BIOME"] = mData["BIOME"] or {}
                    mData["BIOME"][id] = true
                end
            end
        end
    end

    if mData["BIOME"] then
        applyBiome(square, x, y, z, outside)
    end
end

Events.LoadGridsquare.Add(parseBiomesOnSquare)