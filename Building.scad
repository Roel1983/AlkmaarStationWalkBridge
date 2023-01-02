include <../Utils/GlueTogether.inc>

include <WalkBridgeConfig.inc>

use <Building/PlatformA.scad>
use <Building/PlatformB.scad>
use <Building/PlatformC.scad>
use <Building/Support.scad>
use <Building/Bridge.scad>

walk_bridge_config = WalkBridgeConfig();
Building(
    walk_bridge_config,
    xray = false
);

module Building(
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
        Support(walk_bridge_config,   colorize = false);
        Bridge(walk_bridge_config,    colorize = false);
    }
}