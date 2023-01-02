include <../WalkBridgeConfig.inc>

include <../../Utils/Box.inc>
include <../../Utils/Constants.inc>
include <../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
BuildingAAbriHeadFront(
    walk_bridge_config,
    is_printable = true
);

module BuildingAAbriHeadFront(
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
            abri_head_bounds_y[0] - abri_wall,
            abri_base_size[Z]
        ]) {
            rotate(-90, VEC_X) rotate(180, VEC_Z){
                BuildingAAbriHeadFront(
                    walk_bridge_config = walk_bridge_config,
                    is_printable       = true
                );
            }
        }
    } else {
        bridge_size_xz = ConfigGet(walk_bridge_config, "bridge_size_xz");
        LinearExtrude(
            z_to   = abri_wall
        ) {
            difference() {
                Box(
                    x_from  = abri_head_position_x - (abri_head_size[X] - bridge_size_xz[0])/2,
                    y_to   = abri_head_size[Z]
                );
                Box(
                    x_from  = abri_head_position_x - (abri_head_size[X] - bridge_size_xz[0])/2 + 2,
                    x_to    = -2,
                    y_from  = abri_head_size[Z] * 1/3,
                    y_to    = abri_head_size[Z] * 2/3
                );
            }
        }
    }
}