local function RequestMechanicAnim()
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Wait(1)
    end
    return true
end
local QBCore = exports['qb-core']:GetCoreObject()
function GetHeadingToCoord(playerCoords, targetCoords)
    local dx = targetCoords.x - playerCoords.x
    local dy = targetCoords.y - playerCoords.y

    local heading = math.deg(math.atan2(dy, dx)) - 90.0

    if heading < 0 then
        heading = heading + 360
    end

    return heading
end


CreateThread(function()
    for i, v in pairs(Config.Cars) do
        exports.ox_target:addModel(v.pre, {
            {
                label = "Upgrade Car",
                icon = "fas fa-car",
                onSelect = function(data)
                    local entity = data.entity
                    local coords = GetEntityCoords(entity)
                    local rotation = GetEntityRotation(entity, 2)
                    local heading = GetEntityHeading(entity)
                    local model = GetEntityModel(entity)
                    local plate = GetVehicleNumberPlateText(entity)
                    print(plate)
                    local mods = {
                        engine = GetVehicleMod(entity, 11),
                        brakes = GetVehicleMod(entity, 12),
                        gearbox = GetVehicleMod(entity, 13),
                        suspension = GetVehicleMod(entity, 15),
                        armor = GetVehicleMod(entity, 16),
                        nitrous = GetVehicleMod(entity, 17),
                        turbo = GetVehicleMod(entity, 18)
                    }

                    local sentEnt = NetworkGetNetworkIdFromEntity(entity)
                    local facingVeh = GetHeadingToCoord(GetEntityCoords(PlayerPedId()), GetEntityCoords(entity))
                    TaskAchieveHeading(PlayerPedId(), facingVeh, 1000)
                    while math.abs(GetEntityHeading(PlayerPedId())-facingVeh) > 10.0 do
                        Wait(1)
                    end
                    local animRequest = RequestMechanicAnim()
                    
                    TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, 8.0, -1, 1, 1.0, false, false, false)
                    Wait(1000)
                    DoScreenFadeOut(1000)
                    Wait(1000)
                    local vehNetId = lib.callback.await("vehicle_upgrade_system:upgradeCar", 1000, sentEnt, coords, rotation, model, heading, plate)
                    
                    if vehNetId then
                        local vehicle = NetToVeh(vehNetId) -- Convert network ID back to vehicle handle
                        SetVehicleMod(vehicle, 11, mods.engine, false)
                        SetVehicleMod(vehicle, 12, mods.brakes, false)
                        SetVehicleMod(vehicle, 13, mods.gearbox, false)
                        SetVehicleMod(vehicle, 15, mods.suspension, false)
                        SetVehicleMod(vehicle, 16, mods.armor, false)
                        SetVehicleMod(vehicle, 17, mods.nitrous, false)
                        SetVehicleMod(vehicle, 18, mods.turbo, false)
                        Wait(1000)
                        DoScreenFadeIn(1000)
                        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0)
                    else
                        print("Failed to upgrade vehicle.")
                    end
                end,
            }
        })
    end
end)
