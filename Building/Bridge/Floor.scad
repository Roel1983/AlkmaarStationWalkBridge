include <../../WalkBridgeConfig.inc>

include <../../../Utils/GlueTogether.inc>
include <../../../Utils/Box.inc>

use <Floor/FloorBegin.scad>
use <Floor/FloorCenter.scad>
use <Floor/FloorEnd.scad>

walk_bridge_config = WalkBridgeConfig();
Floor(
    walk_bridge_config,
    xray = false
);

module Floor(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        FloorBegin (walk_bridge_config, colorize = false);
        FloorCenter(walk_bridge_config, colorize = false);
        FloorEnd   (walk_bridge_config, colorize = false);
    }
}