include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
include <../../../../../Utils/TransformIf.inc>
use <../../../Misc/Window.scad>

walk_bridge_config  = WalkBridgeConfig();
wall_segment_config = ConfigGet(walk_bridge_config, "wall_segment1_config");
WallSegment(walk_bridge_config, wall_segment_config);

module WallSegment(
    walk_bridge_config,
    wall_segment_config,
    mirror_x = false,
    is_printable = false
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
    
    window_config = ConfigGet(walk_bridge_config, "bridge_window_config");
     
    adjusted_window_config = WindowConfig(
        parent = window_config,
        width  = scaled(m(1.0)) // TODO calculate
    );
    
    mirror_if(mirror_x, VEC_X) {
        translate([bridge_size_xz[0] / 2, pos_y, bridge_clearance]) {
            color("#81cdc6") {
                rotate(90, VEC_Y) rotate(90, VEC_Z) {
                    difference() { 
                        Box(
                            x_to   = size_y,
                            y_to   = bridge_size_xz[1],
                            z_to   = bridge_wall
                        );
                        AtEachWindowPosition() {
                            WindowGap(adjusted_window_config);
                        }
                    }
                    AtEachWindowPosition() {
                        WindowSlats(adjusted_window_config);
                    }
                }
            }
            if(!is_printable) {
                color("black", alpha= 0.2) Box(
                    x_from = -1,
                    x_to   = 0.1,
                    y_to   = size_y,
                    z_from = bridge_size_xz[1] / 2,
                    z_to   = bridge_size_xz[1]
                );
            }
        }
    }
    module AtEachWindowPosition() {
        for(i = [0 : window_panel_count - 1 ]) {
            translate([
                offset_begin + window_panel_width * (i + .5),
                bridge_size_xz[1] - ConfigGet(window_config, "height") - nozzle(4)
            ]) {
                children();
            }
        }
    }
}
