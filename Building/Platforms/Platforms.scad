include <../../../Utils/GlueTogether.inc>

include <../../WalkBridgeConfig.inc>

use <PlatformA/PlatformA.scad>
use <PlatformB/PlatformB.scad>
use <PlatformC/PlatformC.scad>

walk_bridge_config = WalkBridgeConfig();
Platforms(
    walk_bridge_config,
    xray = false
);

module Platforms(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        PlatformA(walk_bridge_config, colorize = false);
        PlatformB(walk_bridge_config, colorize = false);
        PlatformC(walk_bridge_config, colorize = false);
    }
}