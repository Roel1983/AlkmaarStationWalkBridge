include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/GlueTogether.inc>

use <Parts/BuildingATower2HeadFront.scad>
use <Parts/BuildingATower2HeadBack.scad>
use <Parts/BuildingATower2HeadLeft.scad>
use <Parts/BuildingATower2HeadRight.scad>

walk_bridge_config = WalkBridgeConfig();
PlatformATower2Head(
    walk_bridge_config
);

module PlatformATower2Head(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        BuildingATower2HeadFront      (walk_bridge_config);
        BuildingATower2HeadBack       (walk_bridge_config);
        BuildingATower2HeadLeft       (walk_bridge_config);
        BuildingATower2HeadRight      (walk_bridge_config);
//        BuildingATower2HeadFloor      (walk_bridge_config);
//        BuildingATower2HeadRoof       (walk_bridge_config);
    }
}