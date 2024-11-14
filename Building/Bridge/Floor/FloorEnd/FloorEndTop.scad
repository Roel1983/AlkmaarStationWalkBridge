include <../../../../WalkBridgeConfig.inc>

use <../../../../../FlatChain/FloorHubTop.scad>
use <../../../../../FlatChain/Floor.scad>

use <FloorEndPosition.scad>

walk_bridge_config = WalkBridgeConfig();

FloorEndTop(walk_bridge_config);

module FloorEndTop(
    walk_bridge_config,
    colorize = true
) {
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    
    FloorEndPosition(
        walk_bridge_config = walk_bridge_config,
        colorize = colorize
    ) {
        FloorHubTop(bridge_chain_floor_config);
    }
}
