include <../../../WalkBridgeConfig.inc>

use <Misc/WallSegement.scad>

walk_bridge_config = WalkBridgeConfig();
WallSegment2Right_Part(walk_bridge_config);

module WallSegment2Right_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment2_config");
    WallSegment(
        walk_bridge_config,
        wall_segment_config,
        mirror_x = false
    );
}
