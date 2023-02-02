include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
use     <../../../../../Utils/Chamfered.scad>

use <../../../Misc/Window.scad>
use <../../../../Reference/ViewEF.scad>

ViewEF();

walk_bridge_config = WalkBridgeConfig();
AbriHeadFront_Part(
    walk_bridge_config,
    is_printable = false
);

module AbriHeadFront_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_a_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_a_config, "PlatformConfig"));
    
    if(is_printable) {
        rotate(-90, VEC_X) Part();
    } else {
        color("#81cdc6") Part();
    }
    
    module Part() {
        bridge_clearance     = ConfigGet(walk_bridge_config, "bridge_clearance");
        abri_wall            = ConfigGet(walk_bridge_config, "abri_wall");
        
        head_front_y         = ConfigGet(platform_a_config, ["abri_config", "head_front_y"]);
        front_bounds_x       = ConfigGet(platform_a_config, ["abri_config", "front_bounds_x"]);
        abri_head_height     = ConfigGet(platform_a_config, ["abri_config", "head_height"]);
        
        window_config = WindowConfig(
            width              = scaled(m(1.35)),
            height             = scaled(m(2.1)),
            radius             = scaled(m(1.6)),
            slat_count_x       = 2,
            slat_positions_y   = scaled(m([.7, 1.35])),
            different_top_slat = true
        );
        
        echo(head_front_y);
        translate([0, head_front_y]) {
            rotate(90, VEC_X) {
                difference() {
                    ChamferedSquare(
                        x_from    = front_bounds_x[0] + abri_wall,
                        x_to      = front_bounds_x[1] - abri_wall,
                        y_from    = bridge_clearance,
                        y_size    = abri_head_height,
                        thickness = abri_wall,
                        chamfer   = [0, 1, 0, 1],
                        align     = "outer"
                    );
                    AtEachWindowPosition() {
                        WindowGap(window_config);
                        Box(
                            x_size = ConfigGet(window_config, "width"),
                            y_from = scaled(m(-1.3)),
                            y_to   = scaled(m(-0.3)),
                            z_from = abri_wall / 2,
                            z_size = abri_wall
                        );
                    }
                }
                AtEachWindowPosition() {
                    WindowSlats(window_config);
                }
            }
        }
        
        module AtEachWindowPosition() {
            for(x1=scaled(m([-2.3,2.3 ]))) {
                for(xi=[-1:1:1]) translate([
                    ((front_bounds_x[0] + front_bounds_x[1]) / 2) + x1 + xi * scaled(m(1.50)),
                    bridge_clearance + scaled(m(1.8)),
                    -abri_wall
                ]) {
                    children();
                }
            }
        }
        
        abri_head_position_x = ConfigGet(platform_a_config, ["abri_config", "position_x"]);
    }
}