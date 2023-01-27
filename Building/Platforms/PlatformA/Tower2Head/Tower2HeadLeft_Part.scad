include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/Constants.inc>

use <Misc/Tower2Wall.scad>

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
    
    tower2_config   = ConfigGet(platform_config, "tower2_config");
    assert(is_config(tower2_config, "Tower2Config"));
    
    abri_wall     = ConfigGet(walk_bridge_config, "abri_wall");
    base_size     = ConfigGet(platform_config, ["tower2_config", "base_size"]);
    head_size     = ConfigGet(platform_config, ["tower2_config", "head_size"]);
    position_x    = ConfigGet(platform_config, ["tower2_config", "position_x"]);
    
    if(is_printable) {
        rotate(-90, VEC_Y) {
            translate([
                -position_x - head_size[X] / 2,
                0,
                -base_size[Z]
            ]) {
                Part();
            }
        }
    } else {
        color("#81cdc6") Part();
    }
    
    module Part() {
        translate([
            position_x + head_size[X] / 2,
            0,
            base_size[Z]
        ]) {
            rotate(90) Tower2Wall(
                tower2_config = tower2_config,
                wall_width    = head_size[Y],
                wall_height   = head_size[Z],
                abri_wall     = abri_wall
            );
        }
    }
}
