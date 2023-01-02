include <../WalkBridgeConfig.inc>

use <misc/BridgeSideWalkSegement.scad>

walk_bridge_config = WalkBridgeConfig();
BridgeSideWalkSegment3Left(walk_bridge_config, is_printable = true);

module BridgeSideWalkSegment3Left(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment3_config");
    BridgeSideWalkSegment(
        walk_bridge_config,
        wall_segment_config,
        mirror_x     = true,
        is_printable = is_printable
    );
}
