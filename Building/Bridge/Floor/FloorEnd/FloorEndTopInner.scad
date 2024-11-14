include <../../../../WalkBridgeConfig.inc>

use <../../../../../FlatChain/FloorHubTopInner.scad>
use <../../../../../FlatChain/Floor.scad>

use <FloorEndPosition.scad>

walk_bridge_config = WalkBridgeConfig();

FloorEndTopInner(walk_bridge_config);

module FloorEndTopInner(
    walk_bridge_config,
    colorize = true
) {
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    
    FloorEndPosition(
        walk_bridge_config = walk_bridge_config,
        colorize = colorize
    ) {
        FloorHubTopInner(bridge_chain_floor_config);
    }
}
