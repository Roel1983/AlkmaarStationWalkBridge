include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
BuildingATower1HeadRight_Part(
    walk_bridge_config,
    is_printable = true
);

module BuildingATower1HeadRight_Part(
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
    tower1_head_roof_r   = ConfigGet(platform_config, ["tower1_config", "head_roof_r"]);
        
    if(!is_printable) {
        translate([
            tower1_position_x + tower1_head_size[X] / 2 - abri_wall,
            0,
            tower1_base_size[Z]
        ]) {
            rotate(90, VEC_Z) rotate(90, VEC_X) {
                BuildingATower1HeadRight_Part(
                    walk_bridge_config = walk_bridge_config,
                    is_printable       = true
                );
            }
        }
    } else {
        $fn = 64;
        LinearExtrude(
            z_to   = abri_wall
        ) {
            A(
                size   = [tower1_head_size[Y], tower1_head_size[Z]],
                roof_r = tower1_head_roof_r
            );
        }
    }
    
    module A(size, roof_r) {
        hull() {
            translate([-size[X] / 2, 0]) {
                square([size[X], size[Y]]);
            }
            intersection() {
                h = size[Y] - sqrt(pow(roof_r, 2) - pow(size[X]/2, 2));
                translate([
                    0,
                    h
                ]) {
                    circle(r=roof_r);
                }
                translate([-size[X] / 2, 0]) {
                    square([size[X], h + roof_r]);
                }
            }
        }
    }
}

