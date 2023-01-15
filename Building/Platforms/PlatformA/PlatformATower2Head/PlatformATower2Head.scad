include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/GlueTogether.inc>

use <BuildingATower2HeadFront_Part.scad>
use <BuildingATower2HeadBack_Part.scad>
use <BuildingATower2HeadLeft_Part.scad>
use <BuildingATower2HeadRight_Part.scad>

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
        BuildingATower2HeadFront_Part      (walk_bridge_config);
        BuildingATower2HeadBack_Part       (walk_bridge_config);
        BuildingATower2HeadLeft_Part       (walk_bridge_config);
        BuildingATower2HeadRight_Part      (walk_bridge_config);
//        BuildingATower2HeadFloor_Part      (walk_bridge_config);
//        BuildingATower2HeadRoof_Part       (walk_bridge_config);
    }
}