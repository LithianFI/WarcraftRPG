udg_SelectionDialog = {}
udg_TestSpawn = nil
gg_rct_WindrunnerDescription = nil
gg_rct_SorceressDescription = nil
gg_rct_TestSpawn = nil
gg_trg_Windrunner_Description = nil
gg_trg_Windunner_Selection = nil
gg_trg_Melee_Initialization = nil
gg_unit_S001_0002 = nil
function InitGlobals()
    local i = 0
    i = 0
    while (true) do
        if ((i > 10)) then break end
        udg_SelectionDialog[i] = DialogCreate()
        i = i + 1
    end
end

function CreateNeutralPassiveBuildings()
    local p = Player(PLAYER_NEUTRAL_PASSIVE)
    local u
    local unitID
    local t
    local life
    u = CreateUnit(p, FourCC("ncp3"), -28864.0, 29376.0, 270.000)
    u = CreateUnit(p, FourCC("ncp3"), -29504.0, 29376.0, 270.000)
end

function CreateNeutralPassive()
    local p = Player(PLAYER_NEUTRAL_PASSIVE)
    local u
    local unitID
    local t
    local life
    gg_unit_S001_0002 = CreateUnit(p, FourCC("S001"), -29502.6, 29386.0, 270.000)
    u = CreateUnit(p, FourCC("S002"), -28861.8, 29375.9, 270.000)
end

function CreatePlayerBuildings()
end

function CreatePlayerUnits()
end

function CreateAllUnits()
    CreateNeutralPassiveBuildings()
    CreatePlayerBuildings()
    CreateNeutralPassive()
    CreatePlayerUnits()
end

function CreateRegions()
    local we
    gg_rct_WindrunnerDescription = Rect(-29696.0, 28928.0, -29312.0, 29184.0)
    gg_rct_SorceressDescription = Rect(-29056.0, 28928.0, -28672.0, 29184.0)
    gg_rct_TestSpawn = Rect(-29824.0, 27392.0, -29600.0, 27616.0)
end

function Trig_Windrunner_Description_Actions()
    CreateTextTagUnitBJ("TRIGSTR_017", gg_unit_S001_0002, 0, 10, 100, 100, 100, 0)
    DisplayTextToForce(GetForceOfPlayer(GetOwningPlayer(GetTriggerUnit())), "TRIGSTR_011")
end

function InitTrig_Windrunner_Description()
    gg_trg_Windrunner_Description = CreateTrigger()
    TriggerRegisterEnterRectSimple(gg_trg_Windrunner_Description, gg_rct_WindrunnerDescription)
    TriggerAddAction(gg_trg_Windrunner_Description, Trig_Windrunner_Description_Actions)
end

function Trig_Windunner_Selection_Conditions()
    if (not (GetUnitTypeId(GetTriggerUnit()) == FourCC("selc"))) then
        return false
    end
    return true
end

function Trig_Windunner_Selection_Actions()
    RemoveUnit(GetTriggerUnit())
    udg_TestSpawn = GetRandomLocInRect(gg_rct_TestSpawn)
    CreateNUnitsAtLoc(1, FourCC("WIND"), Player(0), udg_TestSpawn, bj_UNIT_FACING)
end

function InitTrig_Windunner_Selection()
    gg_trg_Windunner_Selection = CreateTrigger()
    TriggerRegisterUnitInRangeSimple(gg_trg_Windunner_Selection, 100.00, gg_unit_S001_0002)
    TriggerAddCondition(gg_trg_Windunner_Selection, Condition(Trig_Windunner_Selection_Conditions))
    TriggerAddAction(gg_trg_Windunner_Selection, Trig_Windunner_Selection_Actions)
end

function Trig_Melee_Initialization_Func001A()
    CreateNUnitsAtLoc(1, FourCC("selc"), GetEnumPlayer(), GetPlayerStartLocationLoc(GetEnumPlayer()), bj_UNIT_FACING)
end

function Trig_Melee_Initialization_Actions()
    ForForce(GetPlayersAll(), Trig_Melee_Initialization_Func001A)
end

function InitTrig_Melee_Initialization()
    gg_trg_Melee_Initialization = CreateTrigger()
    TriggerAddAction(gg_trg_Melee_Initialization, Trig_Melee_Initialization_Actions)
end

function InitCustomTriggers()
    InitTrig_Windrunner_Description()
    InitTrig_Windunner_Selection()
    InitTrig_Melee_Initialization()
end

function RunInitializationTriggers()
    ConditionalTriggerExecute(gg_trg_Melee_Initialization)
end

function InitCustomPlayerSlots()
    SetPlayerStartLocation(Player(0), 0)
    SetPlayerColor(Player(0), ConvertPlayerColor(0))
    SetPlayerRacePreference(Player(0), RACE_PREF_HUMAN)
    SetPlayerRaceSelectable(Player(0), true)
    SetPlayerController(Player(0), MAP_CONTROL_USER)
end

function InitCustomTeams()
    SetPlayerTeam(Player(0), 0)
end

function main()
    SetCameraBounds(-29952.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), -30208.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 29952.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 29696.0 - GetCameraMargin(CAMERA_MARGIN_TOP), -29952.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 29696.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 29952.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), -30208.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    NewSoundEnvironment("Default")
    SetAmbientDaySound("LordaeronSummerDay")
    SetAmbientNightSound("LordaeronSummerNight")
    SetMapMusic("Music", true, 0)
    CreateRegions()
    CreateAllUnits()
    InitBlizzard()
    InitGlobals()
    InitCustomTriggers()
    RunInitializationTriggers()
end

function config()
    SetMapName("TRIGSTR_001")
    SetMapDescription("TRIGSTR_003")
    SetPlayers(1)
    SetTeams(1)
    SetGamePlacement(MAP_PLACEMENT_USE_MAP_SETTINGS)
    DefineStartLocation(0, -29760.0, 28800.0)
    InitCustomPlayerSlots()
    SetPlayerSlotAvailable(Player(0), MAP_CONTROL_USER)
    InitGenericPlayerSlots()
end

