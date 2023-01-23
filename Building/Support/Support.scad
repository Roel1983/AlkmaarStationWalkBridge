include <../../WalkBridgeConfig.inc>

include <../../../Utils/Box.inc>
include <../../../Utils/GlueTogether.inc>
use<SupportPart.scad>

walk_bridge_config = WalkBridgeConfig();
Support(
    walk_bridge_config
);

module Support(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
        SupportPart(walk_bridge_config);
    }
    
}