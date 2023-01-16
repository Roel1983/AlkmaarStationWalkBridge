include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
Back_Part(
    walk_bridge_config,
    is_printable = true
);

module Back_Part(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_config, "PlatformConfig"));
    
    abri_wall           = ConfigGet(walk_bridge_config, "abri_wall");
    bridge_size_xz      = ConfigGet(walk_bridge_config, "bridge_size_xz");
    tower1_base_size     = ConfigGet(platform_config, ["tower1_config", "base_size"]);
    abri_head_bounds_y  = ConfigGet(platform_config, ["abri_config", "head_bounds_y"]);
    abri_base_size      = ConfigGet(platform_config, ["abri_config", "base_size"]);
    abri_head_size      = ConfigGet(platform_config, ["abri_config", "head_size"]);
    abri_support_width  = ConfigGet(platform_config, ["abri_config", "support_width"]);
    abri_support_height = ConfigGet(platform_config, ["abri_config", "support_height"]);
    abri_support_wall   = ConfigGet(platform_config, ["abri_config", "support_wall"]);
    abri_position_x     = ConfigGet(platform_config, ["abri_config", "position_x"]);
    tower2_base_size    = ConfigGet(platform_config, ["tower2_config", "base_size"]);
    assert(tower1_base_size[Y] == tower2_base_size[Y]);
    tower1_position_x   = ConfigGet(platform_config, ["tower1_config", "position_x"]);
    tower2_position_x   = ConfigGet(platform_config, ["tower2_config", "position_x"]);
    
    if(!is_printable) {
        translate([
            0,
            -tower1_base_size[Y] / 2 + abri_wall
        ]) {
            rotate(90, VEC_X) {
                Back_Part(
                    walk_bridge_config = walk_bridge_config,
                    is_printable       = true
                );
            }
        }
    } else {
        AbriBase();
        Tower1();
        Tower2();
    }
    
    module Tower1() {
        Box(
            x_to = -abri_base_size[X] / 2 + abri_position_x,    
            x_from = tower1_position_x +-tower1_base_size[X] / 2,
            y_to   = tower1_base_size[Z],
            z_to   = abri_wall
        );
    }
    
    module Tower2() {
        Box(
            x_to = tower2_position_x + tower2_base_size[X] / 2,
            x_from   = abri_base_size[X] / 2 + abri_position_x,
            y_to   = tower2_base_size[Z],
            z_to   = abri_wall
        );
    }
    
    module AbriBase() {
        Box(
            x_to   = abri_base_size[X] / 2 + abri_position_x,
            x_from = -abri_base_size[X] / 2 + abri_position_x,
            y_to   = abri_base_size[Z],
            z_to   = (abri_base_size[Y] - tower1_base_size[Y]) / 2 + abri_wall
        );
    }
    
}