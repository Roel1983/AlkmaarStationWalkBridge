include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
use     <../../../../../Utils/Chamfered.scad>

use <../../../../Reference/MapPlatformA.scad>

use <misc/Tower2Panels.scad>

walk_bridge_config = WalkBridgeConfig();
Tower2BaseRight_Part(
    walk_bridge_config,
    is_printable = true
);

module Tower2BaseRight_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_a_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_a_config, "PlatformConfig"));
    
    back_bounds_x        = ConfigGet(platform_a_config, ["abri_config", "back_bounds_x"]);
    bridge_clearance     = ConfigGet(walk_bridge_config, "bridge_clearance");
    abri_wall            = ConfigGet(walk_bridge_config, "abri_wall");
    
    abri_front_bounds_x  = ConfigGet(platform_a_config, ["abri_config", "front_bounds_x"]);
    tower2_base_size     = ConfigGet(platform_a_config, ["tower2_config", "base_size"]);
    tower2_position_x    = ConfigGet(platform_a_config, ["tower2_config", "position_x"]);
    tower2_head_size     = ConfigGet(platform_a_config, ["tower2_config", "head_size"]);

    
    if(is_printable) {
        translate([
            -tower2_position_x,
            0,
            -tower2_base_size[1] / 2
        ]) {
            rotate(-90, VEC_X) Part();
        }
    } else {
        MapPlatformA();
        color("#81cdc6") Part();
    }
    
    module Part() {
        translate([0, -tower2_base_size[1] / 2]) rotate(90, VEC_X) {
            ChamferedSquare(
                thickness = abri_wall,
                x_from    = abri_front_bounds_x[1],
                x_to      = tower2_position_x + tower2_base_size[0] / 2,
                y_to      = tower2_base_size[2],
                chamfer_angle = [0, 45, 0, 0],
                align     = "outer"
            );
            
            translate([
                tower2_position_x,
                0
            ]) {
                Tower2Panels(
                    walk_bridge_config = walk_bridge_config,
                    width  = tower2_base_size[0],
                    height = tower2_base_size[2],
                    left_bevel = 45,
                    right_bevel = 0,
                    beams = "crosses"
                );
            }
            
            translate([
                tower2_position_x,
                0,
                (tower2_head_size[X] - tower2_base_size[X]) / 2
            ]) {
                ChamferedSquare(
                    x_size    = tower2_head_size[X],
                    y_to      = tower2_base_size[Z],
                    y_size    = nozzle(2),
                    thickness = (tower2_head_size[X] - tower2_base_size[X]) / 2 + abri_wall,
                    chamfer_angle = [0, 45, 0, 0],
                    align     = "outer"
                );
            }
            translate([
                tower2_position_x,
                0,
                - abri_wall
            ]) {
                x_size_1 = tower2_base_size[X] - 2 * abri_wall;
                x_size_2 = tower2_base_size[X] + (tower2_head_size[Y] - tower2_base_size[Y]) - 2 * abri_wall;
                
                Box(
                    x_from    = -x_size_2 / 2,
                    x_to      = x_size_1 / 2,
                    y_from    = tower2_base_size[Z],
                    y_size    = nozzle(6),
                    z_to      = (tower2_head_size[Y] - tower2_base_size[Y]) / 2
                );
                Box(
                    x_size    = x_size_2,
                    y_from    = tower2_base_size[Z] + nozzle(0),
                    y_size    = nozzle(2),
                    z_to      = (tower2_head_size[Y] - tower2_base_size[Y]) / 2
                );
                Box(
                    x_size    = x_size_2,
                    y_from    = tower2_base_size[Z] + nozzle(4),
                    y_size    = nozzle(2),
                    z_to      = (tower2_head_size[Y] - tower2_base_size[Y]) / 2
                );
            }
            beam = nozzle([4, 2]);
            for (x = [-2/5, 2/5]) translate([
                tower2_base_size[X] * x + tower2_position_x,
                0
            ]) {
                Box(
                    x_size    = beam[0],
                    y_to      = tower2_base_size[Z],
                    y_size    = nozzle(2) + beam[1],
                    z_to      = (tower2_head_size[Y] - tower2_base_size[Y]) / 2
                );
            }
        }
    }
}