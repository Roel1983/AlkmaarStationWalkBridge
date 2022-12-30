include <../../../Utils/Box.inc>
include <../../../Utils/Constants.inc>
include <../../../Utils/TransformIf.inc>
include <../../WalkBridge.inc>

walk_bridge_config  = WalkBridgeConfig();
wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment1_config");
BridgeWallSegment(walk_bridge_config, wall_segment_config);

module BridgeWallSegment(
    walk_bridge_config,
    wall_segment_config,
    mirror_x = false,
    mirror_y = false
 ) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    assert(is_config(wall_segment_config, "WallSegmentConfig"));
    
    bridge_clearance      = ConfigGet(walk_bridge_config, "bridge_clearance");
    bridge_wall           = ConfigGet(walk_bridge_config, "bridge_wall");
    bridge_size_xz        = ConfigGet(walk_bridge_config, "bridge_size_xz");
    
    pos_y  = ConfigGet(wall_segment_config, "pos_y");
    size_y = ConfigGet(wall_segment_config, "size_y");
    
    translate([0, pos_y]) {
        mirror_if(mirror_x, VEC_X) mirror_if(mirror_y, VEC_Y) {
            Box(
                x_to   = bridge_size_xz[0] / 2,
                x_size = bridge_wall,
                y_to   = size_y,
                z_from = bridge_clearance,
                z_size = bridge_size_xz[1]
            );
        }
    }
}