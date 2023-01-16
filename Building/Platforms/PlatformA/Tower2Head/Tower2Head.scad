include <../../../../WalkBridgeConfig.inc>

include <../../../../../Utils/GlueTogether.inc>

use <Tower2HeadFront_Part.scad>
use <Tower2HeadBack_Part.scad>
use <Tower2HeadLeft_Part.scad>
use <Tower2HeadRight_Part.scad>

walk_bridge_config = WalkBridgeConfig();
Tower2Head(
    walk_bridge_config
);

module Tower2Head(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        Tower2HeadFront_Part      (walk_bridge_config);
        Tower2HeadBack_Part       (walk_bridge_config);
        Tower2HeadLeft_Part       (walk_bridge_config);
        Tower2HeadRight_Part      (walk_bridge_config);
//        Tower2HeadFloor_Part      (walk_bridge_config);
//        Tower2HeadRoof_Part       (walk_bridge_config);
    }
}