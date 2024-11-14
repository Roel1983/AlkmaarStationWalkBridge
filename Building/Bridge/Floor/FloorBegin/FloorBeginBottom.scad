include <../../../../WalkBridgeConfig.inc>

use <../../../../../FlatChain/FloorHubBottom.scad>
use <../../../../../FlatChain/Floor.scad>

use <FloorBeginPosition.scad>

walk_bridge_config = WalkBridgeConfig();

FloorBeginBottom(walk_bridge_config);

module FloorBeginBottom(
    walk_bridge_config,
    colorize = true
) {
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    
    FloorBeginPosition(
        walk_bridge_config = walk_bridge_config,
        colorize = colorize
    ) {
        FloorHubBottom(bridge_chain_floor_config);
    }
}
