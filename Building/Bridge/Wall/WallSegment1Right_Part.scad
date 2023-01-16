include <../../../WalkBridgeConfig.inc>

use <Misc/WallSegement.scad>

walk_bridge_config = WalkBridgeConfig();
WallSegment1Right_Part(walk_bridge_config);

module WallSegment1Right_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment1_config");
    WallSegment(
        walk_bridge_config,
        wall_segment_config,
        mirror_x = false
    );
}
