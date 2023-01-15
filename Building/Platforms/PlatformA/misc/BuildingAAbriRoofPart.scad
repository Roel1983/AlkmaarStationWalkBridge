include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Box.inc>
include <../../../../../Utils/Constants.inc>
include <../../../../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
abri_head_size      = ConfigGet(platform_config, ["abri_config", "head_size"]);
abri_position_x     = ConfigGet(platform_config, ["abri_config", "position_x"]);
BuildingAAbriRoofPart(
        walk_bridge_config = walk_bridge_config,
        is_printable       = true,
        x_from = -abri_head_size[X] / 2 + abri_position_x,
        x_to   = abri_head_size[X] /2 + abri_position_x
);

module BuildingAAbriRoofPart(
    walk_bridge_config,
    is_printable = false,
    x_from,
    x_to
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_config, "PlatformConfig"));
    
    abri_base_size      = ConfigGet(platform_config, ["abri_config", "base_size"]);
    abri_head_size      = ConfigGet(platform_config, ["abri_config", "head_size"]);
    abri_head_roof_r    = ConfigGet(platform_config, ["abri_config", "head_roof_r"]);
    abri_head_position_y = ConfigGet(platform_config, ["abri_config", "head_position_y"]);

    h = abri_head_size[Z] - sqrt(pow(abri_head_roof_r, 2) - pow(abri_head_size[Y]/2, 2));
    
    roof_thickness = nozzle(2);
    
    if(!is_printable) {
        translate([
            x_from, 
            abri_head_position_y,
            abri_base_size[Z]
        ]) {
            rotate(90, VEC_Z) rotate(90, VEC_X) {
                BuildingAAbriRoofPart(
                    walk_bridge_config = walk_bridge_config,
                    is_printable       = true,
                    x_from             = x_from,
                    x_to               = x_to
                );
            }
        }
    } else {
        LinearExtrude(
            z_to =  x_to - x_from
        ) {
            translate([
                0,
                h
            ]) {
                intersection() {
                    difference() {
                        circle(r=abri_head_roof_r);
                        circle(r=abri_head_roof_r - roof_thickness);
                    }
                    Box(
                        x_size = abri_head_size[Y],
                        y_to   = abri_head_roof_r
                    );
                }
            }
        }
    }
}
