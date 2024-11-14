include <../../../../WalkBridgeConfig.inc>
include <../../../../../Utils/GlueTogether.inc>

use <FloorCenterBottom.scad>
use <FloorCenterTopInner.scad>
use <FloorCenterTopLeft.scad>
use <FloorCenterTopRight.scad>

walk_bridge_config = WalkBridgeConfig();

FloorCenter(walk_bridge_config);

module FloorCenter(
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
        FloorCenterBottom  (walk_bridge_config, colorize);
        FloorCenterTopInner(walk_bridge_config, colorize);
        FloorCenterTopLeft (walk_bridge_config, colorize);
        FloorCenterTopRight(walk_bridge_config, colorize);
    }
}
