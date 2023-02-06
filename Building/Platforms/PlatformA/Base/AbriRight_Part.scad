include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
use     <../../../../../Utils/Chamfered.scad>

use <../../../../Reference/MapPlatformA.scad>

MapPlatformA();

walk_bridge_config = WalkBridgeConfig();
AbriRight_Part(
    walk_bridge_config,
    is_printable = false
);

module AbriRight_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_a_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_a_config, "PlatformConfig"));
    
    front_bounds_x       = ConfigGet(platform_a_config, ["abri_config", "front_bounds_x"]);
    
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
        base_right_bounds_y   = ConfigGet(platform_a_config, ["abri_config", "base_right_bounds_y"]);
        abri_head_height     = ConfigGet(platform_a_config, ["abri_config", "head_height"]);
        abri_head_roof_r     = ConfigGet(platform_a_config, ["abri_config", "head_roof_r"]);
        tower1_base_size     = ConfigGet(platform_a_config, ["tower1_config", "base_size"]);

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
        
        translate([front_bounds_x[0], 0]) rotate(-90, VEC_Y) {
            difference() {
                Wall();
                Roof();
            }
        }
        module Wall() {
            render(convexity=2) ChamferedPolygon(
                thickness     = abri_wall,
                points        = [
                    [
                        h,
                        base_right_bounds_y[1]
                    ], [
                        h,
                        head_front_y
                    ], [
                        bridge_clearance,
                        head_front_y
                    ], [
                        bridge_clearance,
                        base_right_bounds_y[0]
                    ], [
                        0,
                        base_right_bounds_y[0]
                    ], [
                        0,
                        base_right_bounds_y[1]
                    ]
                ],
                chamfer_angle = [0, 45, 0, 45, 0, 45],
                align         = "outer"
            );
        }
        
        module Roof() {
            BIAS = 1;
            LinearExtrude(
                z_from = - abri_wall - BIAS,
                z_to   = BIAS
            ) {
                difference() {
                    Box(
                        x_from = roof_center_z,
                        x_to   = h + BIAS,
                        y_from = head_front_y - BIAS,
                        y_to   = base_right_bounds_y[1] + BIAS
                    );
                    translate([roof_center_z, roof_center_y]) circle(r = abri_head_roof_r);
                }
            }
        }
    }
}