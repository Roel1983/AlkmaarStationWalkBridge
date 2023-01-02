include <../WalkBridgeConfig.inc>

include <../../Utils/Box.inc>
include <../../Utils/Constants.inc>
include <../../Utils/LinearExtrude.inc>

walk_bridge_config = WalkBridgeConfig();
BuildingAAbriHeadLeft(
    walk_bridge_config,
    is_printable = true
);

module BuildingAAbriHeadLeft(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_a_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_a_config, "PlatformConfig"));
    
    abri_wall       = ConfigGet(walk_bridge_config, "abri_wall");
    abri_position_x = ConfigGet(platform_a_config, ["abri_config", "position_x"]);
    abri_head_position_y = ConfigGet(platform_a_config, ["abri_config", "head_position_y"]);
    abri_head_size  = ConfigGet(platform_a_config, ["abri_config", "head_size"]);
    abri_head_overhang_r = ConfigGet(platform_a_config, ["abri_config", "head_overhang_r"]);
    abri_head_overhang_z      = ConfigGet(platform_a_config, ["abri_config", "head_overhang_z"]);
    if(!is_printable) {
        abri_base_size     = ConfigGet(platform_a_config, ["abri_config", "base_size"]);
        translate([
            abri_position_x - abri_head_size[X] / 2,
            abri_head_position_y,
            abri_base_size[Z]
        ]) {
            rotate(90, VEC_Z) rotate(90, VEC_X){
                BuildingAAbriHeadLeft(
                    walk_bridge_config = walk_bridge_config,
                    is_printable       = true
                );
            }
        }
    } else {
        abri_head_roof_r = ConfigGet(platform_a_config, ["abri_config", "head_roof_r"]);
        $fn = 64;
        LinearExtrude(
            z_to   = abri_wall
        ) {
            A(
                size   = [abri_head_size[Y], abri_head_size[Z]],
                roof_r = abri_head_roof_r
            );
            difference() {
                Box(
                    x_from = -abri_head_size[Y]/ 2,
                    x_to   = 0,
                    y_from = -abri_head_overhang_r,
                    y_to   = 0
                );
                translate([
                    -abri_head_size[Y] / 2,
                    -abri_head_overhang_r - abri_head_overhang_z
                ]) {
                    circle(r=abri_head_overhang_r);
                }
            }
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