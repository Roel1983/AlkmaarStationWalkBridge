include <../../WalkBridgeConfig.inc>

include <../../../Utils/GlueTogether.inc>

use <../../Parts/BuildingAFront.scad>
use <../../Parts/BuildingABack.scad>
use <../../Parts/BuildingAAbriHeadFront.scad>
use <../../Parts/BuildingAAbriHeadBack.scad>
use <../../Parts/BuildingAAbriRoofPart1.scad>
use <../../Parts/BuildingAAbriRoofPart2.scad>
use <../../Parts/BuildingATower1BaseSide.scad>
use <../../Parts/BuildingATower1HeadFront.scad>
use <../../Parts/BuildingATower1HeadBack.scad>
use <../../Parts/BuildingATower1HeadLeft.scad>
use <../../Parts/BuildingATower1HeadRight.scad>
use <../../Parts/BuildingATower2BaseSide.scad>

walk_bridge_config = WalkBridgeConfig();
PlatformABase(
    walk_bridge_config
);

module PlatformABase(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        BuildingAFront                (walk_bridge_config);
        BuildingABack                 (walk_bridge_config);
        BuildingAAbriHeadFront        (walk_bridge_config);
        BuildingAAbriHeadBack         (walk_bridge_config);
        BuildingAAbriRoofPart1        (walk_bridge_config);
        BuildingAAbriRoofPart2        (walk_bridge_config);
        BuildingATower1BaseSide       (walk_bridge_config);
        BuildingATower1HeadFront      (walk_bridge_config);
        BuildingATower1HeadBack       (walk_bridge_config);
        BuildingATower1HeadLeft       (walk_bridge_config);
        BuildingATower1HeadRight      (walk_bridge_config);
        BuildingATower2BaseSide       (walk_bridge_config);
    }
}