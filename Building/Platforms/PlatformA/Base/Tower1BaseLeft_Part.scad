include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
use     <../../../../../Utils/Chamfered.scad>

use <../../../../Reference/MapPlatformA.scad>

walk_bridge_config = WalkBridgeConfig();
Tower1BaseRight_Part(
    walk_bridge_config,
    is_printable = false
);

module Tower1BaseRight_Part(
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
    tower1_base_size     = ConfigGet(platform_a_config, ["tower1_config", "base_size"]);
    tower1_position_x    = ConfigGet(platform_a_config, ["tower1_config", "position_x"]);
    tower1_head_size     = ConfigGet(platform_a_config, ["tower1_config", "head_size"]);
    
    if(is_printable) {
        translate([
            -tower1_position_x,
            0,
            -tower1_base_size[1] / 2
        ]) {
            rotate(-90, VEC_X) Part();
        }
    } else {
        MapPlatformA();
        color("#81cdc6") Part();
    }
    
    module Part() {
        translate([0, -tower1_base_size[1] / 2]) rotate(90, VEC_X) {
            ChamferedSquare(
                thickness = abri_wall,
                x_to      = tower1_position_x - tower1_base_size[0] / 2,    
                x_from    = abri_front_bounds_x[0],
                y_to      = tower1_base_size[2],
                chamfer_angle = [0, -45, 0, 0],
                align     = "outer"
            );
            ChamferedSquare(
                thickness = (tower1_head_size[X] - tower1_base_size[X]) / 2,
                x_to      = tower1_position_x - tower1_base_size[0] / 2,    
                x_from    = abri_front_bounds_x[0],
                y_to      = tower1_base_size[2],
                y_size    = nozzle(2),
                chamfer_angle = [0, -45, 0, 0],
                align     = "inner"
            );
            beam = nozzle([4, 2]);
            for (x = [-2/5, 2/5]) translate([
                tower1_base_size[X] * x + tower1_position_x,
                0
            ]) {
                Box(
                    x_size    = beam[0],
                    y_to      = tower1_base_size[Z],
                    y_size    = nozzle(2) + beam[1],
                    z_to    = (tower1_head_size[Y] - tower1_base_size[Y]) / 2
                );
            }
        }
    }
}