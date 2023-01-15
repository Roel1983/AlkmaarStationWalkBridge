include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/GlueTogether.inc>

use <BuildingAAbriRoofPart1_Part.scad>

walk_bridge_config = WalkBridgeConfig();
PlatformAAbriRoof(
    walk_bridge_config
);

module PlatformAAbriRoof(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        BuildingAAbriRoofPart1_Part(walk_bridge_config);
    }
}