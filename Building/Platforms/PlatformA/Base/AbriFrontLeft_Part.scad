include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
use     <../../../../../Utils/Chamfered.scad>

use <../../../../Reference/MapPlatformA.scad>

MapPlatformA();

walk_bridge_config = WalkBridgeConfig();
AbriFrontLeft_Part(
    walk_bridge_config,
    is_printable = false
);

module AbriFrontLeft_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_a_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_a_config, "PlatformConfig"));
    
    front_bounds_x       = ConfigGet(platform_a_config, ["abri_config", "front_bounds_x"]);
    back_bounds_x        = ConfigGet(platform_a_config, ["abri_config", "back_bounds_x"]);
    
    if(is_printable) {
        translate([
            0, 0,
            -front_bounds_x[1]
        ]) rotate(-90, VEC_Y) Part();
    } else {
        color("#81cdc6") Part();
    }
    
    module Part() {
        bridge_clearance     = ConfigGet(walk_bridge_config, "bridge_clearance");
        abri_wall            = ConfigGet(walk_bridge_config, "abri_wall");
        
        head_front_y         = ConfigGet(platform_a_config, ["abri_config", "head_front_y"]);
        base_left_bounds_y   = ConfigGet(platform_a_config, ["abri_config", "base_left_bounds_y"]);
        base_right_bounds_y  = ConfigGet(platform_a_config, ["abri_config", "base_right_bounds_y"]);
        abri_head_height     = ConfigGet(platform_a_config, ["abri_config", "head_height"]);
        abri_head_roof_r     = ConfigGet(platform_a_config, ["abri_config", "head_roof_r"]);
        tower2_base_size     = ConfigGet(platform_a_config, ["tower2_config", "base_size"]);

        head_size_y          = base_right_bounds_y[1] - head_front_y;
        roof_center_z = (
            bridge_clearance +
            abri_head_height -
            sqrt(pow(abri_head_roof_r, 2) - pow(head_size_y/2, 2))
        );
        roof_center_y = (base_right_bounds_y[1] + head_front_y) / 2;
        h = (
            roof_center_z + abri_head_roof_r
        );
        
        translate([front_bounds_x[1], 0]) rotate(180) rotate(-90, VEC_Y) {
            difference() {
                union() {
                    Wall();
                    GlueStrip();
                }
                Roof();
            }
        }
        module Wall() {
            render() ChamferedPolygon(
                thickness     = abri_wall,
                points        = [
                    [
                        0,
                        tower2_base_size[1] / 2 - abri_wall - nozzle(4)
                    ], [
                        0,
                        -base_left_bounds_y[0]
                    ], [
                        bridge_clearance,
                        -base_left_bounds_y[0]
                    ], [
                        bridge_clearance,
                        -head_front_y
                    ], [
                        h,
                        -head_front_y
                    ], [
                        h,
                        tower2_base_size[1] / 2 - abri_wall - nozzle(4)
                    ]
                ],
                chamfer_angle = [0, 45, 0, 45, 0, 0],
                align         = "outer"
            );
        }
        
        module GlueStrip() {
            BIAS = 0.1;
            Box(
                y_to = tower2_base_size[1] / 2 - abri_wall,
                y_from   = tower2_base_size[1] / 2 - abri_wall - nozzle(4),
                z_from = -BIAS,
                z_to   =  back_bounds_x[1] - front_bounds_x[1] - abri_wall,
                x_to   =  h
            );
        }
        module Roof() {
            BIAS = 1;
            LinearExtrude(
                z_from = -abri_wall-BIAS,
                z_to   = BIAS
            ) {
                difference() {
                    Box(
                        x_from = roof_center_z,
                        x_to   = h + BIAS,
                        y_from   = -base_left_bounds_y[1] - BIAS,
                        y_to = -head_front_y + BIAS
                    );
                    translate([roof_center_z, -roof_center_y]) circle(r = abri_head_roof_r);
                }
            }
        }
    }
}