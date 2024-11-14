include <../../../../WalkBridgeConfig.inc>
include <../../../../../Utils/GlueTogether.inc>

use <FloorBeginBottom.scad>
use <FloorBeginCap.scad>
use <FloorBeginTop.scad>
use <FloorBeginTopInner.scad>

walk_bridge_config = WalkBridgeConfig();

FloorBegin(walk_bridge_config);

module FloorBegin(
    walk_bridge_config,
    xray     = false,
    colorize = false,
    index    = undef
) {
    GlueTogether(
        xray     = xray,
        colorize = colorize,
        index    = index
    ) {
        FloorBeginBottom  (walk_bridge_config, colorize);
        FloorBeginCap     (walk_bridge_config, colorize);
        FloorBeginTop     (walk_bridge_config, colorize);
        FloorBeginTopInner(walk_bridge_config, colorize);
    }
}
