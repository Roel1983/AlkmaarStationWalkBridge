include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
use <../../../../../Utils/Chamfered.scad>

walk_bridge_config = WalkBridgeConfig();
Tower2BaseSide_Part(
    walk_bridge_config,
    is_printable = true
);

module Tower2BaseSide_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_config, "PlatformConfig"));
    
    abri_wall            = ConfigGet(walk_bridge_config, "abri_wall");
    tower2_base_size     = ConfigGet(platform_config, ["tower2_config", "base_size"]);
    tower2_position_x    = ConfigGet(platform_config, ["tower2_config", "position_x"]);
    tower2_head_size     = ConfigGet(platform_config, ["tower2_config", "head_size"]);
    
    if(is_printable) {
        rotate(-90, VEC_Y) {
            translate([-tower2_position_x - tower2_base_size[X] / 2, 0]) Part();
        }
    } else {
        color("#81cdc6") Part();
    }
    
    module Part() {
        translate([
            tower2_position_x + tower2_base_size[X] / 2,
            0
        ]) rotate(90, VEC_Y) rotate(90) {
            ChamferedSquare(
                x_size    = tower2_base_size[Y],
                y_to      = tower2_base_size[Z],
                thickness = abri_wall,
                chamfer_angle = [0, 45, 0, 45]
            );
            ChamferedSquare(
                x_size    = tower2_base_size[Y],
                y_to      = tower2_base_size[Z],
                y_size    = nozzle(2),
                thickness = (tower2_head_size[X] - tower2_base_size[X]) / 2 + abri_wall,
                chamfer_angle = [0, 45, 0, 45]
            );
            Box(
                x_size    = tower2_base_size[Y],
                y_from    = tower2_base_size[Z],
                y_size    = nozzle(6),
                z_to      = (tower2_head_size[X] - tower2_base_size[X]) / 2
            );
            Box(
                x_size    = tower2_base_size[Y] + (tower2_head_size[X] - tower2_base_size[X]),
                y_from    = tower2_base_size[Z] + nozzle(2),
                y_size    = nozzle(2),
                z_to      = (tower2_head_size[X] - tower2_base_size[X]) / 2
            );
            beam = nozzle([4, 2]);
            for (x = [-2/5, 2/5]) translate([tower2_base_size[Y] * x, 0]) {
                Box(
                    x_size    = beam[0],
                    y_to      = tower2_base_size[Z],
                    y_size    = nozzle(2) + beam[1],
                    z_to      = (tower2_head_size[X] - tower2_base_size[X]) / 2 + abri_wall
                );
            }
        }
    }
    
        
    *if(!is_printable) {
        translate([
            tower2_position_x + tower2_base_size[X] / 2 - abri_wall,
            0
        ]) {
            rotate(90, VEC_Z) rotate(90, VEC_X) {
                Tower2BaseSide_Part(
                    walk_bridge_config = walk_bridge_config,
                    is_printable       = true
                );
            }
        }
    } else {
        color("#81cdc6") {
            Box(
                x_size = tower2_base_size[Y],
                y_to   = tower2_base_size[Z],
                z_to   = abri_wall        
            );
        }
    }
}