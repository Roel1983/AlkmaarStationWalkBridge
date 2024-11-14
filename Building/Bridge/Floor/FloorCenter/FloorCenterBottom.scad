include <../../../../WalkBridgeConfig.inc>

use <../../../../../FlatChain/FloorStraightBottom.scad>
use <../../../../../FlatChain/Floor.scad>

use <FloorCenterPosition.scad>

walk_bridge_config = WalkBridgeConfig();

FloorCenterBottom(walk_bridge_config);

module FloorCenterBottom(
    walk_bridge_config,
    colorize = true
) {
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    
    FloorCenterPosition(
        walk_bridge_config = walk_bridge_config,
        colorize = colorize
    ) {
        FloorStraightBottom(bridge_chain_floor_config);
    }
}
