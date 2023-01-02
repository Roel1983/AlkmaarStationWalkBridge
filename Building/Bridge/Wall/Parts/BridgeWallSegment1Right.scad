include <../../../../WalkBridgeConfig.inc>

use <Misc/BridgeWallSegement.scad>

walk_bridge_config = WalkBridgeConfig();
BridgeWallSegment1Right(walk_bridge_config);

module BridgeWallSegment1Right(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment1_config");
    BridgeWallSegment(
        walk_bridge_config,
        wall_segment_config,
        mirror_x = false
    );
}
