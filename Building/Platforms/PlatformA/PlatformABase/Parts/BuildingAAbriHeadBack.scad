include <../../../../../WalkBridgeConfig.inc>

include <../../../../../../Utils/Box.inc>
include <../../../../../../Utils/Constants.inc>
include <../../../../../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
BuildingAAbriHeadBack(
    walk_bridge_config,
    is_printable = true
);

module BuildingAAbriHeadBack(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_a_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_a_config, "PlatformConfig"));
    
    abri_wall            = ConfigGet(walk_bridge_config, "abri_wall");
    abri_head_position_x = ConfigGet(platform_a_config, ["abri_config", "position_x"]);
    abri_head_size       = ConfigGet(platform_a_config, ["abri_config", "head_size"]);
    
    if(!is_printable) {
        abri_head_bounds_y = ConfigGet(platform_a_config, ["abri_config", "head_bounds_y"]);
        abri_base_size     = ConfigGet(platform_a_config, ["abri_config", "base_size"]);
        translate([
            abri_head_position_x - abri_head_size[X]/2,
            abri_head_bounds_y[1] + abri_wall,
            abri_base_size[Z]
        ]) {
            rotate(90, VEC_X) {
                BuildingAAbriHeadBack(
                    walk_bridge_config = walk_bridge_config,
                    is_printable       = true
                );
            }
        }
    } else {
        head_overhang_z      = ConfigGet(platform_a_config, ["abri_config", "head_overhang_z"]);
        Box(
            x_to   = abri_head_size[X],
            y_from = -head_overhang_z,
            y_to   = abri_head_size[Z],
            z_to   = abri_wall
        );
    }
}