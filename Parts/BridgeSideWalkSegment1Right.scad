include <../WalkBridge.inc>
include <misc/BridgeSideWalkSegement.inc>

walk_bridge_config = WalkBridgeConfig();
BridgeSideWalkSegment1Right(walk_bridge_config, is_printable = true);

module BridgeSideWalkSegment1Right(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment1_config");
    BridgeSideWalkSegment(
        walk_bridge_config,
        wall_segment_config,
        mirror_x     = false,
        is_printable = is_printable
    );
}
