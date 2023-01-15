include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/GlueTogether.inc>

use <BuildingAFront_Part.scad>
use <BuildingABack_Part.scad>
use <BuildingAAbriHeadFront_Part.scad>
use <BuildingAAbriHeadBack_Part.scad>
use <BuildingAAbriHeadLeft_Part.scad>
use <BuildingAAbriHeadRight_Part.scad>
use <BuildingAAbriRoofPart2_Part.scad>
use <BuildingATower1BaseSide_Part.scad>
use <BuildingATower1HeadFront_Part.scad>
use <BuildingATower1HeadBack_Part.scad>
use <BuildingATower1HeadLeft_Part.scad>
use <BuildingATower1HeadRight_Part.scad>
use <BuildingATower2BaseSide_Part.scad>

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
        BuildingAFront_Part                (walk_bridge_config);
        BuildingABack_Part                 (walk_bridge_config);
        BuildingAAbriHeadFront_Part        (walk_bridge_config);
        BuildingAAbriHeadBack_Part         (walk_bridge_config);
        BuildingAAbriHeadLeft_Part         (walk_bridge_config);
        BuildingAAbriHeadRight_Part        (walk_bridge_config);
        BuildingAAbriRoofPart2_Part        (walk_bridge_config);
        BuildingATower1BaseSide_Part       (walk_bridge_config);
        BuildingATower1HeadFront_Part      (walk_bridge_config);
        BuildingATower1HeadBack_Part       (walk_bridge_config);
        BuildingATower1HeadLeft_Part       (walk_bridge_config);
        BuildingATower1HeadRight_Part      (walk_bridge_config);
        BuildingATower2BaseSide_Part       (walk_bridge_config);
    }
}