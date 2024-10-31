include <../../../WalkBridgeConfig.inc>

include <../../../../Utils/GlueTogether.inc>
include <../../../../Utils/Box.inc>

use <FloorBegin.scad>
use <FloorCenter.scad>
use <FloorEnd.scad>

walk_bridge_config = WalkBridgeConfig();
Floor(
    walk_bridge_config,
    xray = false
);

module Floor(
    walk_bridge_config,
    xray     = false,
    colorize = true,
    index    = undef
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize,
        index    = index
    ) {
        FloorBegin (walk_bridge_config, colorize = false);
        FloorCenter(walk_bridge_config, colorize = false);
        FloorEnd   (walk_bridge_config, colorize = false);
    }
}