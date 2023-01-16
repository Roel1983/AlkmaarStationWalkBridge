include <../../../WalkBridgeConfig.inc>

use <Misc/SideWalkSegement.scad>

walk_bridge_config = WalkBridgeConfig();
SideWalkSegment2Right_Part(walk_bridge_config, is_printable = true);

module SideWalkSegment2Right_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment2_config");
    SideWalkSegment(
        walk_bridge_config,
        wall_segment_config,
        mirror_x     = false,
        is_printable = is_printable
    );
}
