include <../../../../WalkBridgeConfig.inc>

use <../../../../../FlatChain/FloorHubCap.scad>
use <../../../../../FlatChain/Floor.scad>

use <FloorEndPosition.scad>

walk_bridge_config = WalkBridgeConfig();

FloorEndCap(walk_bridge_config);

module FloorEndCap(
    walk_bridge_config,
    colorize = true
) {
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    
    FloorEndPosition(
        walk_bridge_config = walk_bridge_config,
        colorize = colorize
    ) {
        FloorHubCap(bridge_chain_floor_config);
    }
}
