include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
Tower1HeadFront_Part(
    walk_bridge_config,
    is_printable = true
);

module Tower1HeadFront_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_config, "PlatformConfig"));
    
    abri_wall            = ConfigGet(walk_bridge_config, "abri_wall");
    tower1_base_size     = ConfigGet(platform_config, ["tower1_config", "base_size"]);
    tower1_head_size     = ConfigGet(platform_config, ["tower1_config", "head_size"]);
    tower1_position_x    = ConfigGet(platform_config, ["tower1_config", "position_x"]);
        
    if(!is_printable) {
        translate([
            tower1_position_x,
            tower1_head_size[Y] / 2 - abri_wall,
            tower1_base_size[Z]
        ]) {
            rotate(180, VEC_Z) rotate(90, VEC_X) {
                Tower1HeadFront_Part(
                    walk_bridge_config = walk_bridge_config,
                    is_printable       = true
                );
            }
        }
    } else {
        color("#81cdc6") {
            Box(
                x_size = tower1_head_size[X],
                y_to   = tower1_head_size[Z],
                z_to   = abri_wall
            );
        }
    }
}