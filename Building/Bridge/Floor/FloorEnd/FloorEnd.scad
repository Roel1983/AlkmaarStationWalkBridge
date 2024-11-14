include <../../../../WalkBridgeConfig.inc>
include <../../../../../Utils/GlueTogether.inc>

use <FloorEndBottom.scad>
use <FloorEndCap.scad>
use <FloorEndTop.scad>
use <FloorEndTopInner.scad>

walk_bridge_config = WalkBridgeConfig();

FloorEnd(walk_bridge_config);

module FloorEnd(
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
        FloorEndBottom  (walk_bridge_config, colorize);
        FloorEndCap     (walk_bridge_config, colorize);
        FloorEndTop     (walk_bridge_config, colorize);
        FloorEndTopInner(walk_bridge_config, colorize);
    }
}
