include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
use     <../../../../../Utils/Chamfered.scad>

use <../../../Misc/Window.scad>

walk_bridge_config = WalkBridgeConfig();
RightBack_Part(
    walk_bridge_config,
    is_printable = false
);

module RightBack_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_config, "PlatformConfig"));
    platform_a_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_a_config, "PlatformConfig"));
    
    abri_wall           = ConfigGet(walk_bridge_config, "abri_wall");
    bridge_clearance    = ConfigGet(walk_bridge_config, "bridge_clearance");
    bridge_size_xz      = ConfigGet(walk_bridge_config, "bridge_size_xz");
    
    front_bounds_x      = ConfigGet(platform_a_config, ["abri_config", "front_bounds_x"]);
    abri_head_height    = ConfigGet(platform_a_config, ["abri_config", "head_height"]);
    base_right_bounds_y = ConfigGet(platform_a_config, ["abri_config", "base_right_bounds_y"]);
    back_bounds_x       = ConfigGet(platform_a_config, ["abri_config", "back_bounds_x"]);
    backwall_to_bridge_z = ConfigGet(platform_a_config, ["abri_config", "backwall_to_bridge_z"]);
    
    if(is_printable) {
        Part();
    } else {
        color("#81cdc6") Part();
    }
    
    module Part() {
        window_config = WindowConfig(
            width              = scaled(m(1.35)),
            height             = scaled(m(2.05)),
            radius             = scaled(m(1.6)),
            slat_count_x       = 2,
            slat_positions_y   = scaled(m([.7, 1.35])),
            different_top_slat = true
        );
        
        translate([
            0,
            base_right_bounds_y[1]
        ]) rotate(90, VEC_X) rotate(180, VEC_Y){
            difference() {
                render(2) ChamferedPolygon(
                    thickness     = abri_wall,
                    chamfer_angle = [0, 0, 0, 0, 0, 45, 0, 45],
                    align         = "outer",
                    points        = [
                        [
                            -back_bounds_x[1],
                            bridge_clearance + abri_head_height
                        ], [
                            -bridge_size_xz[0] / 2,
                            bridge_clearance + abri_head_height
                        ], [
                            -bridge_size_xz[0] / 2,
                            bridge_clearance
                        ], [
                            bridge_size_xz[0] / 2,
                            bridge_clearance
                        ], [
                            bridge_size_xz[0] / 2,
                            bridge_clearance + abri_head_height
                        ], [
                            -back_bounds_x[0],
                            bridge_clearance + abri_head_height
                        ], [
                            -back_bounds_x[0],
                            0
                        ], [
                            -back_bounds_x[1],
                            0
                        ]
                    ]
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
                BIAS = 0.1;
                Box(
                    x_to   = -back_bounds_x[1] + abri_wall,
                    x_size = abri_wall + BIAS,
                    y_from = -BIAS,
                    y_to   = bridge_clearance - backwall_to_bridge_z,
                    z_from = -abri_wall - BIAS,
                    z_to   = BIAS
                );
            }
            AtEachWindowPosition() {
                WindowSlats(window_config);
            }
        }
        
        module AtEachWindowPosition() {
            for(x1=scaled(m([-2.3]))) {
                for(xi=[-1:1:1]) translate([
                    -(((front_bounds_x[0] + front_bounds_x[1]) / 2) + x1 + xi * scaled(m(1.50))),
                    bridge_clearance + scaled(m(1.8)),
                    -abri_wall
                ]) {
                    children();
                }
            }
        }
    }
}