include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
Tower2HeadLeft_Part(
    walk_bridge_config,
    is_printable = true
);

module Tower2HeadLeft_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_config, "PlatformConfig"));
    
    abri_wall            = ConfigGet(walk_bridge_config, "abri_wall");
    tower2_base_size     = ConfigGet(platform_config, ["tower2_config", "base_size"]);
    tower2_head_size     = ConfigGet(platform_config, ["tower2_config", "head_size"]);
    tower2_position_x    = ConfigGet(platform_config, ["tower2_config", "position_x"]);
        
    if(!is_printable) {
        translate([
            tower2_position_x - tower2_head_size[X] / 2 + abri_wall,
            0,
            tower2_base_size[Z]
        ]) {
            rotate(-90, VEC_Z) rotate(90, VEC_X) {
                Tower2HeadLeft_Part(
                    walk_bridge_config = walk_bridge_config,
                    is_printable       = true
                );
            }
        }
    } else {
        Box(
            x_size = tower2_head_size[Y],
            y_to   = tower2_head_size[Z],
            z_to   = abri_wall
        );
    }
}