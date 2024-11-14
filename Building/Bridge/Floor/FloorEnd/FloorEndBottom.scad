include <../../../../WalkBridgeConfig.inc>

use <../../../../../FlatChain/FloorHubBottom.scad>
use <../../../../../FlatChain/Floor.scad>

use <FloorEndPosition.scad>

walk_bridge_config = WalkBridgeConfig();

FloorEndBottom(walk_bridge_config);

module FloorEndBottom(
    walk_bridge_config,
    colorize = true
) {
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    
    FloorEndPosition(
        walk_bridge_config = walk_bridge_config,
        colorize = colorize
    ) {
        FloorHubBottom(bridge_chain_floor_config);
    }
}
