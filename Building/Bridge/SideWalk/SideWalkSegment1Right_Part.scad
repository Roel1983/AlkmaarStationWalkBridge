include <../../../WalkBridgeConfig.inc>

use <Misc/SideWalkSegement.scad>

walk_bridge_config = WalkBridgeConfig();
SideWalkSegment1Right_Part(walk_bridge_config, is_printable = true);

module SideWalkSegment1Right_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment1_config");
    SideWalkSegment(
        walk_bridge_config,
        wall_segment_config,
        mirror_x     = false,
        is_printable = is_printable
    );
}
