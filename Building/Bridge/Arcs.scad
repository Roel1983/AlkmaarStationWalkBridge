include <../../../Utils/GlueTogether.inc>
include <../../../Utils/Box.inc>
include <../../WalkBridge.inc>

walk_bridge_config = WalkBridgeConfig();
Arcs(
    walk_bridge_config
);

module Arcs(
    walk_bridge_config,
    xray     = false,
    colorize = true
) {
    assert(is_config(walk_bridge_config, "WalkBridgeConfig"));
    
    color(alpha = .2)  Ghost();
    GlueTogether(
        xray     = xray,
        colorize = colorize
    ) {
    }
    
    module Ghost() {
        
    }
}