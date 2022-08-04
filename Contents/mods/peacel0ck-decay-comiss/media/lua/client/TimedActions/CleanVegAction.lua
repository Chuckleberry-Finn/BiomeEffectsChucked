--[[
require('TimedActions/ISBaseTimedAction');

CleanVegAction = ISBaseTimedAction:derive("CleanVegAction");

function CleanVegAction:isValid()
    return true
end

function CleanVegAction:waitToStart()
    self.character:faceLocation(self.square:getX(), self.square:getY())
    return self.character:shouldBeTurning()
end

function CleanVegAction:update()
    self.character:faceLocation(self.square:getX(), self.square:getY())
    self.character:setMetabolicTarget(Metabolics.LightWork);end

function CleanVegAction:start()
    self:setActionAnim("RemoveGrass")
    self:setOverrideHandModels(nil, nil)
    self.square:playSound("RemovePlant");


    self.character:reportEvent("EventCleanVeg");
end

function CleanVegAction:stop()
    ISBaseTimedAction.stop(self);
end

function CleanVegAction:perform()

    local args = { x = self.square:getX(), y = self.square:getY(), z = self.square:getZ() }

    sendClientCommand(self.character, 'CleanVeg', 'CleanVegCommand', args)

    local vegRand = ZombRand(1,1000);
    local vegFoodRare = {"Centipede","Centipede2","Frog","Acorn","Snail","Cilantro","Pillbug","LemonGrass","SawflyLarva","HollyBerry","Termites","Grasshopper","GrapeLeaves","Violets","Worm","Sage","Parsley","Nettles","Oregano","Thym","Tomato","Strewberrie","Cherry","WildEggs","MushroomGeneric4","MushroomGeneric5","MushroomGeneric6","MushroomGeneric7","MushroomGeneric2","MushroomGeneric1","DeadBird","DeadSquirrel","DeadRat","BerryPoisonIvy","BerryGeneric5","BerryGeneric4","BerryGeneric3","BerryGeneric2","BerryGeneric1","BerryBlack","BerryBlue","Cockroach","DeadMouse","DeadRabbit"}
    local vegOther = {"PillsAntiDep","PillsBeta","Pills","PillsSleepingTablets","PillsVitamins","WalkieTalkie2","WhiskeyFull","WoodenLance","WildGarlic","WhiskeyWaterFull","WaterBottleFull","WaterPopBottle","WineWaterFull","BeerWaterFull","Wallet4","Wallet3","Wallet2","Wallet","SmashedBottle","SheetPaper2","SheetRope","Screws","Pinecone","Hat_SurgicalMask_Green","Hat_SurgicalMask_Blue","Log","CandleLit","KeyRing","Journal","HandTorch","Pan","Fork","Key1","Key2","Key3","Key4","Key5","KeyPadlock","CombinationPadlock","Padlock","Doll","Dust Mask","Pop3Empty","Pop2Empty","PopEmpty","Torch"}
    local vegStuff = {"WoodenStick","Twigs","Twigs","Twigs","Twigs","Twigs","Twigs","Twigs","TreeBranch","TreeBranch","Stone","Stone","Stone","TreeBranch","SharpedStone","Stone"}

    countvegFoodRare = 0
    for _ in pairs(vegFoodRare) do countvegFoodRare = countvegFoodRare + 1 end

    countvegOther = 0
    for _ in pairs(vegOther) do countvegOther = countvegOther + 1 end

    countvegStuff = 0
    for _ in pairs(vegStuff) do countvegStuff = countvegStuff + 1 end

    if  vegRand <= 5 then

        local objFoundRare = vegFoodRare[ZombRand(1,countvegFoodRare)]
        local objFoundOther = vegOther[ZombRand(1,countvegOther)]
        local objFoundCommon = vegStuff[ZombRand(1,countvegStuff)]

        HaloTextHelper.addText(self.character, getText("UI_FOUNDSOMETHING"), true, HaloTextHelper.getColorGreen());
        HaloTextHelper.addTextWithArrow(self.character, getText("UI_GAINSKILL"), true, HaloTextHelper.getColorGreen());

        self.character:getInventory():AddItem("Base."..objFoundRare)
        self.character:getInventory():AddItem("Base."..objFoundOther)
        self.character:getInventory():AddItem("Base."..objFoundCommon)

        self.character:getXp():AddXP(Perks.PlantScavenging, 15);

    elseif  vegRand >= 6 and vegRand <= 11 then

        local objFoundRare = vegFoodRare[ZombRand(1,countvegFoodRare)]
        local objFoundCommon = vegStuff[ZombRand(1,countvegStuff)]

        HaloTextHelper.addText(self.character, getText("UI_FOUNDSOMETHING"), true, HaloTextHelper.getColorGreen());
        HaloTextHelper.addTextWithArrow(self.character, getText("UI_GAINSKILL"), true, HaloTextHelper.getColorGreen());

        self.character:getInventory():AddItem("Base."..objFoundRare)
        self.character:getInventory():AddItem("Base."..objFoundCommon)

        self.character:getXp():AddXP(Perks.PlantScavenging, 10);

    elseif  vegRand > 11 and vegRand <= 200 then

        local objFoundCommon = vegFoodRare[ZombRand(1,countvegFoodRare)]

        HaloTextHelper.addText(self.character, getText("UI_FOUNDSOMETHING"), true, HaloTextHelper.getColorGreen());
        HaloTextHelper.addTextWithArrow(self.character, getText("UI_GAINSKILL"), true, HaloTextHelper.getColorGreen());

        self.character:getInventory():AddItem("Base."..objFoundCommon)

        self.character:getXp():AddXP(Perks.PlantScavenging, 5);

    elseif  vegRand > 201 and vegRand <= 500 then

        self.character:getXp():AddXP(Perks.PlantScavenging, 1);

    end
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function CleanVegAction:new(character, square, time)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.square = square;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = time;
    o.caloriesModifier = 10;
    if character:isTimedActionInstant() then
        o.maxTime = 300;
    end
    return o;
end

--]]