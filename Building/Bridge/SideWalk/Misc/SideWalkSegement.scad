include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
include <../../../../../Utils/TransformIf.inc>

walk_bridge_config  = WalkBridgeConfig();
wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment1_config");
SideWalkSegment(walk_bridge_config, wall_segment_config);

module SideWalkSegment(
    walk_bridge_config,
    wall_segment_config,
    mirror_x = false,
    is_printable = false
 ) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    assert(is_config(wall_segment_config, "WallSegmentConfig"));
    
    bridge_clearance      = ConfigGet(walk_bridge_config, "bridge_clearance");
    bridge_size_xz        = ConfigGet(walk_bridge_config, "bridge_size_xz");
        
    pos_y              = ConfigGet(wall_segment_config, "pos_y");
    size_y             = ConfigGet(wall_segment_config, "size_y");
    offset_begin       = ConfigGet(wall_segment_config, "offset_begin");
    offset_end         = ConfigGet(wall_segment_config, "offset_end");
    
    side_walk_overlap = layer(6) / 2 + nozzle(2) + mm(1);
     
    translate([0, pos_y]) {
        mirror_if(mirror_x, VEC_X) {
            Box(
                x_from = bridge_size_xz[0] / 2 + mm(2),
                x_to   = bridge_size_xz[0] / 2 + scaled(m(1)),
                y_from = offset_begin - side_walk_overlap,
                y_to   = size_y + side_walk_overlap - offset_end,
                z_from = bridge_clearance + scaled(m(.5)),
                z_size = mm(1)
            );
        }
    }
}       
        