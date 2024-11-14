include <../../../../WalkBridgeConfig.inc>

module FloorEndPosition(
    walk_bridge_config,
    colorize = true
) {
    bridge_clearance          = ConfigGet(walk_bridge_config, "bridge_clearance");
    bridge_floor_to           = ConfigGet(walk_bridge_config, "bridge_floor_to");
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    floor_thickness           = ConfigGet(bridge_chain_floor_config, "thickness");
    
    color("DimGray") translate([
        0,
        bridge_floor_to,
        bridge_clearance + floor_thickness
    ]) {
        rotate(-90) children();
    }
}