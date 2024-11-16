include <../../../../WalkBridgeConfig.inc>

use <../../../../../FlatChain/FloorStraightTopRight.scad>
use <../../../../../FlatChain/Floor.scad>

use <FloorCenterPosition.scad>

walk_bridge_config = WalkBridgeConfig();

FloorCenterTopRight(walk_bridge_config);

module FloorCenterTopRight(
    walk_bridge_config,
    colorize = true
) {
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    
    FloorCenterPosition(
        walk_bridge_config = walk_bridge_config,
        colorize = colorize
    ) {
        FloorStraightTopRight(bridge_chain_floor_config);
    }
}
