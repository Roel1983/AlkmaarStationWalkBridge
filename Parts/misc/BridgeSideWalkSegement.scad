UNITS_NOZZLE = mm(.4);
include <../../../Utils/Box.inc>
include <../../../Utils/Constants.inc>
include <../../../Utils/LinearExtrude.inc>
include <../../../Utils/TransformIf.inc>
include <../../WalkBridge.inc>

walk_bridge_config  = WalkBridgeConfig();
wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment1_config");
BridgeSideWalkSegment(walk_bridge_config, wall_segment_config);

module BridgeSideWalkSegment(
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
    mirror_y           = ConfigGet(wall_segment_config, "mirror_y");
    
    side_walk_overlap = mm(6) / 2 - mm(1);
     
    translate([0, pos_y]) {
        mirror_if(mirror_x, VEC_X) mirror_if(mirror_y, VEC_Y) {

        Box(
            x_from = bridge_size_xz[0] / 2 + mm(2),
            x_to   = bridge_size_xz[0] / 2 + scaled(m(1)),
            y_from = -side_walk_overlap,
            y_to   = size_y + 2 * side_walk_overlap,
            z_from = bridge_clearance + scaled(m(.5)),
            z_size = mm(1)
        );
            
            

        }
    }
}

        
        
        