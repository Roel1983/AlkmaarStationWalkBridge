include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
include <../../../../../Utils/TransformCopy.inc>
use     <../../../../../Utils/Chamfered.scad>

use <../../../Misc/Window.scad>
use <../../../../Reference/ViewEF.scad>

ViewEF();

walk_bridge_config = WalkBridgeConfig();
AbriBaseFront_Part(
    walk_bridge_config,
    is_printable = false
);

module AbriBaseFront_Part(
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
        
        base_right_bounds_y  = ConfigGet(platform_a_config, ["abri_config", "base_right_bounds_y"]);
        base_left_bounds_y   = ConfigGet(platform_a_config, ["abri_config", "base_left_bounds_y"]);
        assert(base_right_bounds_y[0] == base_left_bounds_y[0]);
        head_front_y         = ConfigGet(platform_a_config, ["abri_config", "head_front_y"]);
        front_bounds_x       = ConfigGet(platform_a_config, ["abri_config", "front_bounds_x"]);
        abri_head_height     = ConfigGet(platform_a_config, ["abri_config", "head_height"]);
        
        beam_width = scaled(m(0.25));
        
        window_config = WindowConfig(
            width              = scaled(m(1.35)),
            height             = scaled(m(2.1)),
            radius             = scaled(m(1.6)),
            slat_count_x       = 2,
            slat_positions_y   = scaled(m([.7, 1.35])),
            different_top_slat = true
        );
        
        translate([0, base_right_bounds_y[0]]) {
            rotate(90, VEC_X) {
                ChamferedSquare(
                    x_from    = front_bounds_x[0],
                    x_to      = front_bounds_x[1],
                    y_to      = bridge_clearance,
                    thickness = abri_wall,
                    chamfer   = [0, 1, 0, 1],
                    align     = "outer"
                );
                FlatBeams();
            }
            
            LinearExtrude(
                x_size = beam_width,
                x_to   = front_bounds_x[1]
            ) {
                OverhangBeam();
            }
            LinearExtrude(
                x_size = beam_width,
                x_from = -front_bounds_x[1]
            ) {
                OverhangBeam();
            }
            LinearExtrude(
                x_size = beam_width,
                x_from = front_bounds_x[0]
            ) {
                OverhangBeam();
            }
        }
        
        
        module OverhangBeam() {
            radius = scaled(m(1.5));
            difference() {
                Box(
                    x_from   = head_front_y - base_left_bounds_y[0],
                    y_from = bridge_clearance - radius - beam_width,
                    y_to   = bridge_clearance
                );
                translate([
                    head_front_y - base_left_bounds_y[0],
                    bridge_clearance - radius - beam_width
                ]) {
                    circle(r = radius);
                }
            }
        }
        
        module FlatBeams() {
            radius = scaled(m(1));
            LinearExtrude(
                z_to = layer(6)
            ) {
                Box(
                    x_from = front_bounds_x[0],
                    x_to   = front_bounds_x[1],
                    y_to = bridge_clearance,
                    y_size = beam_width
                );
                difference() {
                    Box(
                        x_from = front_bounds_x[0],
                        x_to   = front_bounds_x[1],
                        y_to   = bridge_clearance
                    );
                    hull() {
                        mirror_copy(VEC_X) { 
                            translate([
                                front_bounds_x[1] - beam_width - radius,
                                bridge_clearance - radius
                            ]) {
                                circle(r = radius);
                            }
                        }
                        Box(
                            x_size = 2 * (front_bounds_x[1] - beam_width),
                            y_size = 1
                        );
                    }
                    hull() {
                        translate([
                            -front_bounds_x[1] - radius,
                            bridge_clearance - radius
                        ]) {
                            circle(r = radius);
                        }
                        translate([
                            front_bounds_x[0] + radius + beam_width,
                            bridge_clearance - radius
                        ]) {
                            circle(r = radius);
                        }
                        Box(
                            x_from = front_bounds_x[0] + beam_width,
                            x_to   = -front_bounds_x[1],
                            y_size = 1
                        );
                    }
                }
            }
        }
    }
}