include <../../../../WalkBridgeConfig.inc>

use <../../../../../FlatChain/FloorHubTop.scad>
use <../../../../../FlatChain/Floor.scad>

use <../../ArcsAndTrestles/ArcsAndTrestles.scad>

use <FloorBeginPosition.scad>

walk_bridge_config = WalkBridgeConfig();

FloorBeginTop(walk_bridge_config);

module FloorBeginTop(
    walk_bridge_config,
    colorize = true
) {
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    
    difference() {
        FloorBeginPosition(
            walk_bridge_config = walk_bridge_config,
            colorize = colorize
        ) {
            FloorHubTop(bridge_chain_floor_config);
        }
        ArcsAndTrestles_cutout();
    }
}
