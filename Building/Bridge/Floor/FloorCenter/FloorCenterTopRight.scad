include <../../../../WalkBridgeConfig.inc>

use <FloorCenterTopLeft.scad>

walk_bridge_config = WalkBridgeConfig();

FloorCenterTopRight(walk_bridge_config);

module FloorCenterTopRight(
    walk_bridge_config,
    colorize = true
) {
    mirror(VEC_X) {
        FloorCenterTopLeft(
            walk_bridge_config = walk_bridge_config,
            colorize = colorize
        );
    }
}
