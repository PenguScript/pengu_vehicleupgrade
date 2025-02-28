lib.callback.register("vehicle_upgrade_system:upgradeCar", function(source, ent, coords, rotation, model, heading, plate)
    local entity = NetworkGetEntityFromNetworkId(ent)
    if DoesEntityExist(entity) then
        local primary, secondary = GetVehicleColours(entity)
        DeleteEntity(entity)
        print(model)
        print(Config.Cars[model].post, coords.x, coords.y, coords.z, heading, true, false)
        local vehicle = CreateVehicle(Config.Cars[model].post, coords.x, coords.y, coords.z+0.1, heading, true, false)
        SetVehicleNumberPlateText(vehicle, plate)
        SetVehicleColours(vehicle, primary, secondary)
        
        local vehNetId = vehicle -- Convert to network ID to return to the client
        return vehNetId
    else
        print("Entity does not exist")
        return nil
    end
end)
