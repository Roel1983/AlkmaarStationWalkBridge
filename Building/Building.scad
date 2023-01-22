include <../../Utils/GlueTogether.inc>

include <../WalkBridgeConfig.inc>

use <Platforms/Platforms.scad>
use <Support/Support.scad>
use <Bridge/Bridge.scad>
use <../Reference/ViewEF.scad>

walk_bridge_config = WalkBridgeConfig();
Building(
    walk_bridge_config,
    xray = false,
    colorize = false
);

ViewEF();

module Building(
    walk_bridge_config,
    xray     = false,
    colorize = false
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        Platforms(walk_bridge_config, colorize = false);
        Support(walk_bridge_config,   colorize = false);
        Bridge(walk_bridge_config,    colorize = false);
    }
}