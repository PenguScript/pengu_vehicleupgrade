# Vehicle Upgrade System for FiveM

A lightweight FiveM resource that allows players to upgrade their vehicles using a mechanic animation. This resource integrates with the QBCore framework and utilizes ox_target to provide in-game interactions for upgrading vehicles.

---

## Features

- **Vehicle Upgrades:** Replace an existing vehicle with an upgraded model.
- **Mechanic Animation:** Plays a repair animation while performing the upgrade.
- **Vehicle Mods Transfer:** Retains key modifications (engine, brakes, gearbox, etc.) during the upgrade.
- **Customizable Configuration:** Easily add or modify available upgrade options via a config file.

---

## Requirements

- **[QBCore Framework](https://github.com/qbcore-framework)** or **[QBX Framework](https://github.com/Qbox-project)**

- **[ox_target](https://github.com/overextended/ox_target)**  

---

## Installation

1. **Download or Clone the Repository:**  
   Place the resource folder (e.g., `pengu_vehicleupgrade`) into your FiveM `resources` directory.

2. **Add to Server Configuration:**  
   Include the following line in your `server.cfg`:
   ```ini
   ensure pengu_vehicleupgrade
   ```

3. **Restart Your Server:**  
   Once added, restart your FiveM server to load the new resource.

---

## Configuration

The available upgrade options are defined in the `config.lua` file. Each vehicle option consists of:

- **pre:** The model identifier for the vehicle before the upgrade. This model is used by ox_target to register interactable vehicles.
- **post:** The model identifier for the vehicle after the upgrade. This is the new upgraded vehicle that will be spawned.
- **cost:** The cost associated with the upgrade (integrate this with your server's economy as needed).

Example configuration:
```lua
Config = {}

Config.Cars = {
    [`euros`] = {
        pre = `euros`,       -- Pre-upgrade model identifier (target model)
        post = `zr380`,      -- Post-upgrade model identifier (spawned vehicle)
        cost = 1,            -- Upgrade cost
    },
    [`dominator`] = {
        pre = `dominator`,   -- Pre-upgrade model identifier (target model)
        post = `dominator4`, -- Post-upgrade model identifier (spawned vehicle)
        cost = 1,            -- Upgrade cost
    },
}
```

---

## Usage

When a player is near a vehicle whose model matches any of the `pre` identifiers specified in the configuration, the following process occurs:

1. **Target Interaction:**  
   An "Upgrade Car" option is displayed through ox_target when the player interacts with the vehicle.

2. **Animation & Facing Adjustment:**  
   The player is rotated to face the vehicle and a mechanic repair animation is played.

3. **Vehicle Data Collection:**  
   Key vehicle modifications (engine, brakes, gearbox, etc.) are stored to be re-applied later.

4. **Screen Transition & Upgrade Callback:**  
   The screen fades out, and a server callback (`pengu_vehicleupgrade:upgradeCar`) is triggered. This callback:
   - Deletes the old vehicle.
   - Spawns a new vehicle based on the `post` model.
   - Applies the original vehicle's color, modifications, and plate text to the new vehicle.

5. **Finalization:**  
   After a short wait and screen fade-in, the upgrade process is complete.

---

## Contributing

Contributions, issues, and feature requests are welcome! Please feel free to check [Issues](https://github.com/PenguScript/pengu_vehicleupgrade/issues) or submit a pull request with improvements.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

Enjoy upgrading your rides and enhancing your FiveM gameplay experience!