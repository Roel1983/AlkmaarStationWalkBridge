UNITS_NOZZLE = mm(.4);
include <../../../Utils/Box.inc>
include <../../../Utils/Constants.inc>
include <../../../Utils/LinearExtrude.inc>
include <../../../Utils/TransformIf.inc>
include <../../WalkBridge.inc>

walk_bridge_config  = WalkBridgeConfig();
wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment1_config");
BridgeWallSegment(walk_bridge_config, wall_segment_config);

module BridgeWallSegment(
    walk_bridge_config,
    wall_segment_config,
    mirror_x = false
 ) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    assert(is_config(wall_segment_config, "WallSegmentConfig"));
    
    bridge_clearance      = ConfigGet(walk_bridge_config, "bridge_clearance");
    bridge_wall           = ConfigGet(walk_bridge_config, "bridge_wall");
    bridge_size_xz        = ConfigGet(walk_bridge_config, "bridge_size_xz");
    bridge_wall_window_panel_width = ConfigGet(walk_bridge_config, "bridge_wall_window_panel_width");
    
    pos_y              = ConfigGet(wall_segment_config, "pos_y");
    size_y             = ConfigGet(wall_segment_config, "size_y");
    window_panel_count = ConfigGet(wall_segment_config, "window_panel_count");
    window_panel_width = ConfigGet(wall_segment_config, "window_panel_width");
    offset_begin       = ConfigGet(wall_segment_config, "offset_begin");
     
    translate([0, pos_y]) {
        mirror_if(mirror_x, VEC_X) {
            LinearExtrude(
                x_to   = bridge_size_xz[0] / 2,
                x_size = bridge_wall
            ) {
                difference() {
                    Box(
                        x_to   = size_y,
                        y_from = bridge_clearance,
                        y_size = bridge_size_xz[1]
                    );
                    for(i = [0:window_panel_count - 1 ]) {
                        translate([
                            offset_begin + window_panel_width * (i + .5),
                            0
                        ]) {
                            Box(
                                x_size   = window_panel_width - nozzle(8),
                                y_from = bridge_clearance + bridge_size_xz[1] - mm(20),
                                y_to   = bridge_clearance + bridge_size_xz[1] - mm(2)
                            );
                        }
                    }
                }
            }
        }
    }
}
