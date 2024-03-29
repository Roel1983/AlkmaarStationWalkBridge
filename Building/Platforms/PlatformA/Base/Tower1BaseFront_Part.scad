include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>
use <../../../../../Utils/Chamfered.scad>

walk_bridge_config = WalkBridgeConfig();
Tower1BaseFront_Part(
    walk_bridge_config,
    is_printable = false
);

module Tower1BaseFront_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_config, "PlatformConfig"));
    
    abri_wall         = ConfigGet(walk_bridge_config, "abri_wall");
    tower1_base_size  = ConfigGet(platform_config, ["tower1_config", "base_size"]);
    tower1_position_x = ConfigGet(platform_config, ["tower1_config", "position_x"]);
    head_size         = ConfigGet(platform_config, ["tower1_config", "head_size"]);
    
    if(is_printable) {
        rotate(90, VEC_Y) {
            translate([-tower1_position_x + tower1_base_size[X] / 2, 0]) Part();
        }
    } else {
        color("#81cdc6") Part();
    }
    
    module Part() {
        translate([
            tower1_position_x - tower1_base_size[X] / 2,
            0
        ]) rotate(-90, VEC_Y) rotate(-90) {
            ChamferedSquare(
                x_size    = tower1_base_size[Y],
                y_to      = tower1_base_size[Z],
                thickness = abri_wall,
                chamfer_angle = [0, 45, 0, 45],
                align     = "outer"
            );
            ChamferedSquare(
                x_size    = tower1_base_size[Y],
                y_to      = tower1_base_size[Z],
                y_size    = nozzle(2),
                thickness = (head_size[X] - tower1_base_size[X]) / 2,
                chamfer_angle = [0, 45, 0, 45]
            );
            Box(
                x_size    = tower1_base_size[Y] - 2 * abri_wall,
                y_from      = tower1_base_size[Z],
                y_size    = nozzle(6),
                z_to      = (head_size[X] - tower1_base_size[X]) / 2 - abri_wall
            );
            Box(
                x_size    = tower1_base_size[Y] + (head_size[X] - tower1_base_size[X]) - 2 * abri_wall,
                y_from    = tower1_base_size[Z] + nozzle(2),
                y_size    = nozzle(2),
                z_to      = (head_size[X] - tower1_base_size[X]) / 2 - abri_wall
            );
            beam = nozzle([4, 2]);
            for (x = [-2/5, 0, 2/5]) translate([tower1_base_size[Y] * x, 0]) {
                Box(
                    x_size    = beam[0],
                    y_to      = tower1_base_size[Z],
                    y_size    = nozzle(2) + beam[1],
                    z_to      = (head_size[X] - tower1_base_size[X]) / 2
                );
            }
        }
    }
}