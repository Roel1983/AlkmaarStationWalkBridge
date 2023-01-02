include <../WalkBridgeConfig.inc>

include <../../Utils/Box.inc>
include <../../Utils/Constants.inc>
include <../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
BuildingATower2BaseSide(
    walk_bridge_config,
    is_printable = true
);

module BuildingATower2BaseSide(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_config, "PlatformConfig"));
    
    abri_wall            = ConfigGet(walk_bridge_config, "abri_wall");
    tower2_base_size     = ConfigGet(platform_config, ["tower2_config", "base_size"]);
    tower2_position_x    = ConfigGet(platform_config, ["tower2_config", "position_x"]);
        
    if(!is_printable) {
        translate([
            tower2_position_x + tower2_base_size[X] / 2 - abri_wall,
            0
        ]) {
            rotate(90, VEC_Z) rotate(90, VEC_X) {
                BuildingATower2BaseSide(
                    walk_bridge_config = walk_bridge_config,
                    is_printable       = true
                );
            }
        }
    } else {
        Box(
            x_size = tower2_base_size[Y],
            y_to   = tower2_base_size[Z],
            z_to   = abri_wall        
        );
    }
}