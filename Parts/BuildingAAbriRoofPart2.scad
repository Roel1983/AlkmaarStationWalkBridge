include <../WalkBridgeConfig.inc>

include <../../Utils/Box.inc>
include <../../Utils/Constants.inc>
include <../../Utils/LinearExtrude.inc>

use <misc/BuildingAAbriRoofPart.scad>

walk_bridge_config = WalkBridgeConfig();
BuildingAAbriRoofPart2(
    walk_bridge_config,
    is_printable = true
);

module BuildingAAbriRoofPart2(
    walk_bridge_config,
    is_printable = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    platform_config = ConfigGet(walk_bridge_config, "platform_a_config");
    assert(is_config(platform_config, "PlatformConfig"));
    
    abri_head_size      = ConfigGet(platform_config, ["abri_config", "head_size"]);
    abri_position_x     = ConfigGet(platform_config, ["abri_config", "position_x"]);
    abri_roof_seam_position = ConfigGet(platform_config, ["abri_config", "roof_seam_position"]);
    
    BuildingAAbriRoofPart(
        walk_bridge_config = walk_bridge_config,
        is_printable       = is_printable,
        x_from = -abri_head_size[X] /2 + abri_position_x,
        x_to   = -abri_head_size[X] /2 + abri_position_x + abri_roof_seam_position
    );
}
