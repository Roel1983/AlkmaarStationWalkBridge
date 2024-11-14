include <../../../../WalkBridgeConfig.inc>

use <../../../../../FlatChain/FloorHubCap.scad>
use <../../../../../FlatChain/Floor.scad>

use <FloorBeginPosition.scad>

walk_bridge_config = WalkBridgeConfig();

FloorBeginCap(walk_bridge_config);

module FloorBeginCap(
    walk_bridge_config,
    colorize = true
) {
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    
    FloorBeginPosition(
        walk_bridge_config = walk_bridge_config,
        colorize = colorize
    ) {
        FloorHubCap(bridge_chain_floor_config);
    }
}
