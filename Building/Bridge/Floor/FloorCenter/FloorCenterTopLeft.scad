include <../../../../WalkBridgeConfig.inc>

use <../../../../../FlatChain/FloorStraightTopLeft.scad>
use <../../../../../FlatChain/Floor.scad>

use <FloorCenterPosition.scad>

walk_bridge_config = WalkBridgeConfig();

FloorCenterTopLeft(walk_bridge_config);

module FloorCenterTopLeft(
    walk_bridge_config,
    colorize = true
) {
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    
    FloorCenterPosition(
        walk_bridge_config = walk_bridge_config,
        colorize = colorize
    ) {
        FloorStraightTopLeft(bridge_chain_floor_config);
    }
}
