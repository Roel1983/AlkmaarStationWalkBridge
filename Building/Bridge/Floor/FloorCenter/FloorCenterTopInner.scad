include <../../../../WalkBridgeConfig.inc>

use <../../../../../FlatChain/FloorStraightTopInner.scad>
use <../../../../../FlatChain/Floor.scad>

use <FloorCenterPosition.scad>

walk_bridge_config = WalkBridgeConfig();

FloorCenterTopInner(walk_bridge_config);

module FloorCenterTopInner(
    walk_bridge_config,
    colorize = true
) {
    bridge_chain_floor_config = ConfigGet(walk_bridge_config, "bridge_chain_floor_config");
    
    FloorCenterPosition(
        walk_bridge_config = walk_bridge_config,
        colorize = colorize
    ) {
        FloorStraightTopInner(bridge_chain_floor_config);
    }
}
