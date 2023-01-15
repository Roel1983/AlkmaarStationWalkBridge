include <../../../WalkBridgeConfig.inc>

use <../../../../FlatChain/FloorStraight.scad>
use <../../../../FlatChain/Floor.scad>

walk_bridge_config = WalkBridgeConfig();

FloorCenter(walk_bridge_config);

module FloorCenter(
    walk_bridge_config,
    colorize = true
) {
    bridge_clearance          = ConfigGet(walk_bridge_config, "bridge_clearance");
    bridge_floor_from         = ConfigGet(walk_bridge_config, "bridge_floor_from");
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    floor_thickness           = ConfigGet(bridge_chain_floor_config, "thickness");
    hub_length                = ConfigGet(bridge_chain_floor_config, "hub_length");

    translate([
        0,
        bridge_floor_from + hub_length,
        bridge_clearance + floor_thickness
    ]) {
        rotate(90) FloorStraight(bridge_chain_floor_config);;
    }
}
